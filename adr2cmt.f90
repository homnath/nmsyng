subroutine adr2cmt(sphif,sdlt,slmda,moment,mrr,mtt,mpp,mrt,mrp,mtp)
implicit none
!
!  this subroutine converts eqk fault parameters to moment tensors
!  for definitions see hiroo''s class notes
!
real sphif,sdlt,slmda,moment
real mrr,mtt,mpp,mrt,mrp,mtp
real pi,phif,dlt,lmda
!
pi=3.1415926
phif=sphif*pi/180
dlt=sdlt*pi/180
lmda=slmda*pi/180
mrr=(sin(2*dlt)*sin(lmda))*moment
mtt=(-(sin(phif))**2*sin(2*dlt)*sin(lmda)-sin(2*phif)*cos(lmda)*sin(dlt))*moment
mpp=(-(cos(phif))**2*sin(2*dlt)*sin(lmda)+sin(2*phif)*cos(lmda)*sin(dlt))*moment
mrt=-(cos(phif)*cos(dlt)*cos(lmda)+sin(phif)*sin(lmda)*cos(2*dlt))*moment
mrp=-(-sin(phif)*cos(dlt)*cos(lmda)+cos(phif)*sin(lmda)*cos(2*dlt))*moment
mtp=(-0.5*sin(2*phif)*sin(2*dlt)*sin(lmda)-cos(2*phif)*cos(lmda)*sin(dlt))*moment
return
end
