subroutine find_disc(model_file,disc,rdisc,ndisc)

implicit none
include 'modes.h'

character(len=*) model_file
integer :: disc(NR),ndisc
real*8 :: rdisc(NR)

real*8 :: radius_last,radius,eps
integer :: nlayer,jdisc,iomod,i


radius_last = -1.0
eps = 1.0d-5
jdisc = 0
iomod = 11
open(iomod,file=model_file,status='old')
do i = 1, NR
   read(iomod,*) nlayer,radius
   if (abs(radius-radius_last) .lt. 1.0d-8) then
      jdisc = jdisc + 1
      rdisc(jdisc) = radius
      disc(jdisc) = i - 1
   endif
   radius_last = radius
enddo
close(iomod)
ndisc = jdisc

end subroutine find_disc
