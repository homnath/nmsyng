subroutine delaz(eplat,eplong,stlat,stlong,delta,azep,azst)
implicit none
!implicit real*8(a-h,o-z)
double precision :: a,as,aze,azs,azep,azst,b,bs,c,caze,cazs,cdel,zdel,cs,d,delt,&
delta,dif,ds,el,elon,geoco,hpi,rad,reprad,sdel,slon,stl,twopi,x
double precision :: arcos!,tan ! internal functions
real :: eplat,eplong,stlat,stlong
data geoco/0.993277d0/

! internal functions
!tan(x)=dsin(x)/dcos(x)
arcos(x)=datan2(dsqrt(1.-x*x),x)

hpi=3.14159265358979d0/2.0d0
twopi=6.28318530717958d0
rad=twopi/360.0d0
reprad=1.0d0/rad
el=datan(geoco*dtan(eplat*rad))
el=hpi-el
stl=datan(geoco*dtan(stlat*rad))
stl=hpi-stl
elon=eplong*rad
slon=stlong*rad
as=dcos(stl)
bs=dsin(stl)
cs=dcos(slon)
ds=dsin(slon)
a=dcos(el)
b=dsin(el)
c=dcos(elon)
d=dsin(elon)
cdel=a*as+b*bs*(c*cs+d*ds)
if(dabs(cdel).gt.1.d0) cdel=dsign(1.d0,cdel)
delt=arcos(cdel)
delta=delt*reprad
sdel=dsin(delt)
caze=(as-a*cdel)/(sdel*b)
if(dabs(caze).gt.1.d0) caze=dsign(1.d0,caze)
aze=arcos(caze)
if(bs.gt.0.) cazs=(a-as*cdel)/(bs*sdel)
if(bs.eq.0.) cazs=sign(1.d0,cazs)
if(dabs(cazs).gt.1.d0) cazs=dsign(1.d0,cazs)
azs=arcos(cazs)
dif=ds*c-cs*d
if(dif.lt.0.) aze=twopi-aze
azep=reprad*aze
if(dif.gt.0.) azs=twopi-azs
azst=reprad*azs
return
end subroutine delaz
!===============================================================================
