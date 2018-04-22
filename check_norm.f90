function check_norm(type,nord,l,wcom,u,v)

  implicit none
  include 'modes.h'

  real*8 :: check_norm
  character(len=*) type
  integer :: nord,l
  real*8 :: wcom,u(NL),v(NL)
  
  character(len=150) model_file
  integer :: n,iomod,junk1,i,j,ios,ndisc,disc(NR)
  real*8 :: angunorm,radius(NR),rho_all(NR),r(NL),rho(NL),kernel(NL),norm,rdisc(NR)
  
  n = NL
  angunorm = dsqrt (PI * GRAV * RHOAV)

  ! reading model file
  iomod = 10
  model_file = '/opt/seismo-util/Modes/nmcat/aniprem808.dk'
  open(iomod, file = model_file, status = 'old',iostat = ios)
  do i = 1 , NR
     if (ios .eq. 0)  read(iomod,*,iostat=ios)  junk1, radius(i),rho_all(i)
     j = i - NR + NL
     if ( j > 0 ) then 
        r(j) = radius(i) / RA
        rho(j) = rho_all(i) / RHOAV
     endif
  enddo
  close(iomod)


  ! set up kernel array  
  do i = 1, n
     if (type .eq. 'S' .or. type .eq. 's') then
        kernel(i) = rho(i)*(u(i)*u(i)+v(i)*v(i))*r(i)*r(i)
     else if (type .eq. 'T' .or. type .eq. 't') then
        kernel(i) = rho(i) * u(i) * u(i) * r(i) * r(i)
     else
        stop 'Incorrect type'
     endif
  enddo
  call find_disc(model_file,disc,rdisc,ndisc)

  call intgrl_disc(norm,n,r,disc,ndisc,1,n,kernel)
  norm = norm * wcom * wcom / (angunorm * angunorm)
  check_norm = norm

end function check_norm
!===============================================================================  

