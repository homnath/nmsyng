subroutine mnam(stn,ntw,cha,ext,dir,ldir,newfile)

!character(len=8) stn  for RECORDHEADER files
character(len=4) :: stn
character(len=2) :: ntw
character(len=8) :: cha
character(len=*) :: ext
character(len=*) :: dir,newfile
character(len=256) :: tempfile
logical exists
!
newfile=' '
lstn=lnblnk(stn)
newfile(1:lstn)=stn(1:lstn)
lnew=lstn
lntw=lnblnk(ntw)
if(lntw.gt.0)then
  newfile(lnew+1:lnew+lntw+1)='.'//ntw(1:lntw)
  lnew=lnew+lntw+1
endif
lcha=lnblnk(cha)
if(lcha.gt.0)then
  newfile(lnew+1:lnew+lcha+1)='.'//cha(1:lcha)
  lnew=lnew+lcha+1
endif
lext=lnblnk(ext)
if(lext.gt.0)then
  newfile(lnew+1:lnew+lext+1)='.'//ext(1:lext)
  lnew=lnew+lext+1
endif

return
end subroutine mnam
!===============================================================================
