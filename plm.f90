!TODO: get rid of go to statements 
subroutine plm(l,ct,st,z,zp)
!
!     calculates Plm's a la Dahlen & Tromp for degree l
!     and orders m=0, m=1, and m=2, which are stored
!     in z(1), z(2), and z(3). The derivatives are
!     in zp(1), zp(2), and zp(3)
!
implicit real*8(a-h,o-z)
save zz1,zz2
dimension z(3),zp(3)
!
do i=1,3
  z(i)=0.0d0
  zp(i)=0.0d0
enddo
cosec=1./st
m=min0(l,2)
lp1=l+1
mp1=m+1
zl=l
fl3=zl*(zl+1.0d0)
cot=ct/st
if(l.gt.2) go to 20
go to(22,23,24),lp1
22 z(1)=fct
return
23 z(1)=ct
zp(1)=-st
z(2)=-zp(1)
zp(2)=0.5d0*z(1)*fl3
if(l.eq.1)return
24 zz1=1.
zz2=ct
20 z3=((2.0d0*zl-1.0d0)*ct*zz2-(zl-1.0d0)*zz1)/zl
zz1=zz2
zz2=z3
z3=zz2
z(1)=z3
z2=zl*(zz1-ct*zz2)*cosec
zp(1)=-z2
zp(2)=-cot*z2+fl3*z3
z(2)=z2
z2=-z2
z1=z3
do i=3,mp1
  zm=i-1
  ! z3=2.0d0*zm*cot*z2-(zl-zm+1.0d0)*(zl+zm)*z1
  z3=-(2.0d0*(zm-1.0d0)*cot*z2+(zl-zm+2.0d0)*(zl+zm-1.0d0)*z1)
  z(i)=z3
  zp(i)=-((zl+zm)*(zl-zm+1.)*z2+zm*cot*z3)
  z1=z2
  z2=z3
  end do
return
end subroutine plm
!=================================================================
