subroutine get_cmt(cmt_file,yr,jda,ho,mi,sec,t_cmt,hdur,elat,elon,depth,mrr,mtt,&
mpp,mrt,mrp,mtp)
implicit none
integer :: yr,jda,ho,mi
real :: sec,t_cmt,hdur,elat,elon,depth
real :: mrr,mtt,mpp,mrt,mrp,mtp
character(len=80) :: cmt_file
!
integer :: ios,datasource,lstr,mo,da,julian_day
real :: mb,ms,scale
character(len=24) :: reg
character(len=128) :: string
integer :: lnblnk
!
!---- first read hypocenter info
!
open(unit=1,file=trim(cmt_file),action='read',status='old',iostat=ios)
if(ios.ne.0) then
  write(6,'(a)')'error opening CMT file '//trim(cmt_file)
  stop
endif
rewind(1)
read(1,'(a4,i5,i3,i3,i3,i3,f6.2,f9.4,f10.4,f6.1,f4.1,f4.1,1x,a)')datasource,yr, &
mo,da,ho,mi,sec,elat,elon,depth,mb,ms,reg
jda=julian_day(yr,mo,da)
!
!       scale the moment-tensor
!
scale=1.0E+30
!
ios=0
do while(ios.eq.0)
  read(1,'(a)',iostat=ios) string
  lstr=lnblnk(string)
  if(string(1:10).eq.'event name') then
  else if(string(1:10).eq.'time shift') then
    read(string(12:lstr),*) t_cmt
  else if(string(1:13).eq.'half duration') then
    read(string(15:lstr),*) hdur
  else if(string(1:8).eq.'latitude') then
    read(string(10:lstr),*) elat
  else if(string(1:9).eq.'longitude') then
    read(string(11:lstr),*) elon
  else if(string(1:5).eq.'depth') then
    read(string(7:lstr),*) depth
  else if(string(1:3).eq.'Mrr') then
    read(string(5:lstr),*) mrr
    mrr=mrr/scale
  else if(string(1:3).eq.'Mtt') then
    read(string(5:lstr),*) mtt
    mtt=mtt/scale
  else if(string(1:3).eq.'Mpp') then
    read(string(5:lstr),*) mpp
    mpp=mpp/scale
  else if(string(1:3).eq.'Mrt') then
    read(string(5:lstr),*) mrt
    mrt=mrt/scale
  else if(string(1:3).eq.'Mrp') then
    read(string(5:lstr),*) mrp
    mrp=mrp/scale
  else if(string(1:3).eq.'Mtp') then
    read(string(5:lstr),*) mtp
    mtp=mtp/scale
  endif
enddo
close(1)
!
return
end subroutine get_cmt
!=================================================================

integer function julian_day(yr,mo,da)
implicit none
integer :: yr,mo,da
!
integer :: mon(12)
integer :: lpyr
data mon/0,31,59,90,120,151,181,212,243,273,304,334/
!
julian_day=da+mon(mo)
if(mo.gt.2) julian_day=julian_day+lpyr(yr)
  return
end function julian_day
!=================================================================

integer function lpyr(yr)
implicit none
integer :: yr
!
!---- returns 1 if yr is a leap year
!
lpyr=0
if(mod(yr,400).eq.0) then
  lpyr=1
else if(mod(yr,4).eq.0) then
  lpyr=1
  if(mod(yr,100).eq.0) then
    lpyr=0
  endif
endif
return
end function lpyr
!=================================================================
