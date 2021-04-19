program code_cpu
implicit none
  character(10) :: arg
  integer :: n, i, j
  real(8), parameter :: ONE = 1.0d0, ZERO=0.0d0
  real(8), allocatable :: A(:,:), B(:,:), C(:,:)
  real(8) :: alpha, beta, trace
  integer :: time
  integer :: t1, t2

! get n from command line 
  call get_command_argument(1, arg)  
  IF (LEN_TRIM(arg) == 0) STOP 
  read(arg, *) n 
  write(*,'(A,I10)') 'Matrices dimension: ', n

  allocate( A(n,n), B(n,n), C(n,n) )

  write(*,*) 'BLAS used'

  alpha = ONE
  beta = ONE
! initializations 
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

  call DGEMM('N', 'N', n, n, n, alpha, A, n, B, n, beta, C, n)

  t2 = time()

  trace = ZERO 
  do i = 1, n
    do j = 1, n
      trace = trace + C(i,j)
    end do 
  end do 
  write(*,'(A,f24.6)') 'Check trace: ', trace 
  write(*,'(A, I5)') 'Clock time elapsed: ', t2 - t1
  
  deallocate( A, B, C) 

end program
