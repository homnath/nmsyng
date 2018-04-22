
subroutine get_mode(type,nord,l,wcom,qmod,nnl,r,u,du,v,dv,av,ah)
  !
  ! Usage:
  !    *  input  * 
  !  type --- can be 't','s',  upper case is o.k. (char*1)
  !  nord --- order number                        (integer)
  !  l --- degree number                          (integer)
  !    *  output *
  !  wcom --- normalized anglar frequency         (real*8)
  !  qmod --- normalized Q factor                 (real*8)
  !  nnl --- number of layers of output array     (integer)
  !  r(nnl) --- normalized radius of each layer   (rest are all real*8)
  !  u(nnl),du(nnl),v(nnl),dv(nnl) ---
  !     in case of toroidal and radial modes, only u,du
  !     is valid, for spheroidal modes, all are valid.
  !
  implicit none
  include "modes.h"

  character(len=1) :: type
  integer :: nord,l,nnl
  real*8 :: wcom,qmod,radius(NR),r(NL),u(NL),du(NL)
  real*8,optional :: v(NL),dv(NL)

  character(len=512)::  model_file,catalogue,bin_file
  integer ::  ntype,nvec,reclen,i,j
  character(len=1) :: type1,type2,char
  integer :: iomod,iocat,iobin,nrec,ios,nn,ll,nnn,lll,junk1,junk2
  real*8 :: av,ah,bb,wwmhz,ttcom,ggcom,qqmod,eps
  real*4 :: buf(6*NL)

  nnl = NL
  eps = 1.0d-2

  iomod = 9
  iocat = 10
  iobin = 11

  ! read model radius 
  model_file = '/opt/seismo-util/Modes/nmcat/aniprem808.dk'
  print *,' Reading Model file ....  ', model_file
  open(iomod, file = model_file, status = 'old',iostat = ios)
  do i = 1 , NR
     if (ios .eq. 0)  read(iomod,*,iostat=ios)  junk1, radius(i)
     j = i - NR + NL 
     if ( j > 0 ) r(j) = radius(i) / RA
  enddo
  close(iomod)
  if (ios .ne. 0) stop 'Error reading model file'

  ntype = 3
  catalogue = '/u/yangl/data3/temp_blackhole/MODES_ORIGINAL/nmsrc/minos/data/spheroidal.aniprem808_1_50'
  bin_file = '/u/yangl/data3/temp_blackhole/MODES_ORIGINAL/nmsrc/minos/data/spheroidal.aniprem808_1_50.bin'
  nvec = 6 * NL 
  type1 = 'S';type2 = 's';
  reclen = 2 * 4 + 4 * 8 + nvec * 4

     ! get the record number of the desired mode from catalogue file
     print *, ' Reading Catalogue file ....  ', catalogue
     nrec = 0
     open(iocat,file=catalogue,status='old',iostat=ios)
     do while (ios .eq. 0) 
        nrec = nrec + 1
        read(iocat,200,iostat=ios) nn,char,ll,bb,wwmhz,ttcom,ggcom,qqmod
        print*, '####', nn,char,ll,bb,wwmhz
           if (nrec == 1 .and. (char /= type1 .and. char /= type2)) then
              print *,nn,ll,';',char,';',type1,';',type2
              stop 'Incorrect mode catalogue'
           endif
           if (nn == nord .and. ll == l) exit
        enddo
200     format(i5,1x,a1,i5,5g16.7)
        close(iocat)
        if (ios .gt. 0) stop 'Error reading0'
        if (ios .lt. 0) stop 'Mode not found in the catalogue'
        print *,' Record Number of ',nord,char,l,'is:  ',nrec
        write(*,'(a,2g16.7)')  '  Catalogue file:',bb,qqmod
        
        ! reading binary file for mode eigenfunction
        print *,' Reading Binary file ....'
        open(iobin,file=bin_file,status='old',iostat=ios,form='unformatted',&
             access='direct',recl=reclen+2*4)
        if (ios .ne. 0) stop 'Error opening catalogue file'
        read(iobin,rec = nrec,iostat = ios) &
             junk1,nnn,lll,wcom,qmod,av,ah,(buf(i),i=1,nvec),junk2
        close(iobin)
!!!!!!!!!!
        open(iobin,file=bin_file,status='old',iostat=ios,form='unformatted',&
             access='direct',recl=reclen+4*4)
        if (ios .ne. 0) stop 'Error opening catalogue file'
        read(iobin,rec = 1,iostat = ios) &
             junk1,junk1,nnn,lll,wcom,qmod,av,ah,(buf(i),i=1,nvec),junk1,junk2
        print*, junk1,nnn,lll,wcom,qmod,av,ah,junk2
        read(iobin,rec = 2,iostat = ios) &
             junk1,junk1,nnn,lll,wcom,qmod,av,ah,(buf(i),i=1,nvec),junk1,junk2
        print*, junk1,nnn,lll,wcom,qmod,av,ah,junk2
        close(iobin)
!!!!!!!!!!


        if (junk1 /= junk2 .or. junk1 /= reclen) then
           print *,junk1,junk2,reclen
           stop 'Incorrect reading1'
        endif
        write(*,300) nnn,char,lll,wcom,qmod
        300 format('  Binary Record:',i4,a2,i4,'  --   wcom:',g16.7, &
                   '   Q : ', g16.7)
        if (abs(wcom-bb) > eps  .or. abs(qmod - qqmod) > eps) stop 'Error reading2'
        
        u(1 : NL) = buf(1 : NL)
        du(1 : NL) = buf (NL + 1 : 2 * NL)
        
        if (ntype == 2) then
           v(1 : NL) = 0.
           dv(1 : NL) = 0.
        else if (ntype == 3) then
           v(1 : NL) = buf (2 * NL + 1 : 3 * NL)
           dv(1 : NL) = buf (3 * NL + 1 : 4 * NL)
        endif
        !print *,' Done reading mode'
      end subroutine get_mode
      
