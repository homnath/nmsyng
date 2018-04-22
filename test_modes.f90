program test_modes

  implicit none

  integer :: n,l,nl
  real*8 :: wcom,qmod,r(1000),rho(1000),u(1000),du(1000),v(1000),dv(1000)
  character(len=1) :: type
  integer i
  real*8 :: check_norm, norm

  print *, 'Enter n and l'
  read(*,*) n,l
  print *, 'Enter Type'
  read(*,'(a)') type

  call get_mode(type,n,l,wcom,qmod,nl,r,u,du,v,dv)
  open(11,file='mode.data')
  do i = 1, nl
     write(11,'(6e13.4)') r(i),u(i),du(i),v(i),dv(i)
  enddo
  close(11)

  norm = check_norm(type,n,l,wcom,u,v)
  print *, 'norm = ', norm

end program test_modes
