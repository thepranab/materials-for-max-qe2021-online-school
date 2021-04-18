program code_gpu
USE cudafor ! CUDA Fortran 
USE cublas  ! cuBLAS libraries
implicit none
  character(10) :: arg
  integer :: n, i, j
  real(8), parameter :: ONE = 1.0d0, ZERO=0.0d0
  real(8), allocatable :: A(:,:), B(:,:), C(:,:)
  attributes(device) :: A, B, C                      ! matrices on device
  real(8) :: alpha, beta, trace
  integer :: time
  integer :: t1, t2

! get n from command line 
  call get_command_argument(1, arg)  
  IF (LEN_TRIM(arg) == 0) STOP 
  read(arg, *) n 
  write(*,'(A,I10)') 'Matrices dimension: ', n

  allocate( A(n,n), B(n,n), C(n,n) )

  write(*,*) 'cuBLAS used'

  trace = ZERO 
  alpha = ONE
  beta = ONE
! initializations on device
!$cuf kernel do(2)
  do i = 1, n
    do j = 1, n
      A(i,j) = ONE
      B(i,j) = ONE
      C(i,j) = ZERO 
      trace = trace + C(i,j)
    end do 
  end do 
  write(*,'(A,f24.6)') 'Check init: ', trace 

  t1 = time()

  call DGEMM('N', 'N', n, n, n, alpha, A, n, B, n, beta, C, n)  ! this is now a cuDGEMM 

  t2 = time()

  trace = ZERO 
!$cuf kernel do(1)
  do i = 1, n
    do j = 1, n
      trace = trace + C(i,j)
    end do 
  end do 
  write(*,'(A,f24.6)') 'Check trace: ', trace 
  write(*,'(A, I5)') 'Clock time elapsed: ', t2 - t1
  
  deallocate( A, B, C) 

end program
