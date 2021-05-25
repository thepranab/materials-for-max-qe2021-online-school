program plot_noncolin_bands
use,intrinsic :: iso_fortran_env,only: dp=>real64
implicit none
!
character (len=80) :: inputfile
real(dp),allocatable   :: xk(:,:),e(:,:),sig(:,:)
real(dp) :: s =0._dp, xk1(3)
integer :: nks, nbnd,ik, ib
namelist /plot/ nks, nbnd 
call get_command_argument(1,inputfile)
print *,  inputfile
open(unit=12, file=trim(inputfile),action='read')
open(unit=13, file=trim(inputfile)//'.s',action='read')
read(13,plot)
read(12, plot )
allocate(xk(3,nks), e(nbnd,nks),sig(nbnd,nks))
do ik=1,nks
  read (12,*) xk(:,ik) 
  read(13,*)  xk(:,ik)
  read (12,*) e(:,ik) 
  read(13,*) sig(:,ik)
end do
close(12)
close(13)
open(12, file='mybands_data',action='write')
do ib = 1, nbnd
  write (12, *) 0._dp, e(ib,1),sig(ib,1)
  do ik = 2, nks
    s = s + sqrt(dot_product(xk(:,ik)-xk(:,ik-1), xk(:,ik)-xk(:,ik-1)))
    write (12,* ) s , e(ib,ik),sig(ib,ik)
  end do
write(12,*) 
s=0.0_dp
end do 
end program 


