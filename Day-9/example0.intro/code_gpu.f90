program code_gpu
USE cudafor ! CUDA Fortran 
USE cublas  ! cuBLAS libraries
implicit none
  character(10) :: arg
  integer :: n, i, j
  double precision, parameter :: ONE = 1.0d0, ZERO=0.0d0
  double precision, allocatable :: A(:,:), B(:,:), C(:,:)
  attributes(device) :: A, B, C                      ! matrices on device
  double precision :: alpha, beta, trace
  real :: t1, t2, t3, t4
  integer :: istat

  call cpu_time(t1)

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

  istat = cudaDeviceSynchronize()
  call cpu_time(t2)

  call DGEMM('N', 'N', n, n, n, alpha, A, n, B, n, beta, C, n)  ! this is now a cuDGEMM 

  istat = cudaDeviceSynchronize()
  call cpu_time(t3)

  trace = ZERO 
!$cuf kernel do(1)
  do i = 1, n
    do j = 1, n
      trace = trace + C(i,j)
    end do 
  end do 

  deallocate( A, B, C) 

  istat = cudaDeviceSynchronize()
  call cpu_time(t4)

  write(*,'(A,f24.6)') 'Check trace: ', trace 
  write(*,'(A, F15.3)') 'Full time:    ', t4 - t1
  write(*,'(A, F15.3)') 'Product time: ', t3 - t2

end program
