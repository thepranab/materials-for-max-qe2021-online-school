program code_cpu
implicit none
  character(10) :: arg
  integer :: n, i, j
  double precision, parameter :: ONE = 1.0d0, ZERO=0.0d0
  double precision, allocatable :: A(:,:), B(:,:), C(:,:)
  double precision :: alpha, beta, trace
  real :: t1, t2, t3, t4

  call cpu_time(t1)

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

  call cpu_time(t2)

  call DGEMM('N', 'N', n, n, n, alpha, A, n, B, n, beta, C, n)

  call cpu_time(t3)

  trace = ZERO 
  do i = 1, n
    do j = 1, n
      trace = trace + C(i,j)
    end do 
  end do 

  deallocate( A, B, C) 

  call cpu_time(t4)

  write(*,'(A,f24.6)') 'Check trace: ', trace 
  write(*,'(A, F15.3)') 'Full time:    ', t4 - t1
  write(*,'(A, F15.3)') 'Product time: ', t3 - t2
  

end program
