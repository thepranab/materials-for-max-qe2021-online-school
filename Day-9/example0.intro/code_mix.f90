program code_mix
USE cudafor ! CUDA Fortran 
USE cublas  ! cuBLAS libraries
implicit none
  character(10) :: arg
  integer :: n, i, j
  double precision, parameter :: ONE = 1.0d0, ZERO=0.0d0
  double precision, allocatable :: A(:,:), B(:,:), C(:,:)           ! host matrices
  double precision, allocatable :: A_d(:,:), B_d(:,:), C_d(:,:)     ! device matrices
  attributes(device) :: A_d, B_d, C_d                      ! matrices on device
  double precision :: alpha, beta, trace
  integer :: time
  integer :: t1, t2, t3, t4
  integer :: istat

  t1 = time()

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
! initializations on host  
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
  t2 = time()

! off-loading host --> device
  A_d = A  
  B_d = B
  C_d = C

  call DGEMM('N', 'N', n, n, n, alpha, A_d, n, B_d, n, beta, C_d, n)  ! this is now a cuDGEMM 

! get back the result device --> host
  C = C_d

  istat = cudaDeviceSynchronize()
  t3 = time()

  trace = ZERO 
  do i = 1, n
    do j = 1, n
      trace = trace + C(i,j)
    end do 
  end do 
  
  deallocate( A, B, C) 
  deallocate( A_d, B_d, C_d) 

  istat = cudaDeviceSynchronize()
  t4 = time()

  write(*,'(A,f24.6)') 'Check trace: ', trace 
  write(*,'(A, I5)') 'Full time:    ', t4 - t1
  write(*,'(A, I5)') 'Product time: ', t3 - t2

end program
