module timeseries
implicit none

contains
!-------------------------------------------------------------------------------

      subroutine get_start(t0,dt,ns,ts)
!
      implicit none
!
!       get_start gets the first non-zero sample of the time series ns
!       and the associated time ts
!
!       t0 is time of first sample w.r.t. CMT origin time, dt the sampling rate
!
      integer ns
      double precision t0,dt,ts
!
      ns=1
      ts=t0
      if(t0.lt.0.0d0) then
!         first sample of record ns
        ns=2+int(-t0/dt)
!         time associated with first sample in record
        ts=t0+dble(ns-1)*dt
      endif
      return
      end subroutine get_start
!=================================================================

      subroutine time_series(ns,ts,nps,dt,om,q,hdur,amp,seismogram)
!
      implicit none
!
      include "spherical.h"
!
      integer :: ns,nps
      double precision :: ts,dt,om,q,hdur,amp(4)
      double precision :: seismogram(:,:)
!
      integer :: i,j,iamp1,iamp2,istat
      double precision :: scale0,mrw,alpha
      complex*16 :: de
      complex*16,allocatable :: sinusoid(:)
      
      !print*,size(seismogram),ubound(seismogram)

      if(ubound(seismogram,1).ne.NCOMP.and.ubound(seismogram,2).ne.nps)then
        write(*,*)'ERROR: inconsistent "seismogram" array!'
        stop
      endif
!
!       scaling factor to make displacement in meters
!       non-dimensionalization of the moment tensor,
!       assumed to be in dynes-cm (=10^7 Nm), is
!       1/((RA**5)*PI*GRAV*(RHOAV**2)*10^7)
!       to make displacement in meters you need to multiply
!       by RA, and the 10^{30} undoes the initial
!       scaling of the moment tensor by get_cmt
!
       scale0=1.0d30/((RA**4)*PI*GRAV*(RHOAV**2)*1.0d7)
       
      allocate(sinusoid(nps),stat=istat)
      if(istat/=0)then
        write(*,*)'ERROR: cannot allocate memory for "sinusoid"!'
        stop
      endif
      
       mrw=1
!      mrw --- moment rate function of omega
!
!       the half duration is accounted for in the mode summation
!
!       boxcar
!
!      if(hdur.gt.0.0d0) mrw=dsin(om*hdur)/(om*hdur)
!
!       triangle
!
!      if(hdur.gt.0.0d0) mrw=2.0d0*(1.0d0-dcos(om*hdur))/((om*hdur)**2)
!
!       Hanning
!
!      if(hdur.gt.0.0d0) mrw=dsin(om*hdur)*PI**2/(om*hdur*(PI**2-om*hdur**2))
!
!       Gaussian with half-width 1.628
!
!     if(hdur.gt.0.0d0) mrw=dexp(-0.25d0*(om*hdur/1.628d0)**2)
      if(hdur.gt.0.0d0) mrw=dexp(-0.25d0*(om*hdur/1.628d0)**2)
!
      alpha=om/(2.0d0*q)
      do i=1,ns-1
         sinusoid(i)=dcmplx(0.0d0,0.0d0)
      enddo
      de=dcmplx(dcos(om*dt),dsin(om*dt))
      de=de*dexp(-alpha*dt)
      sinusoid(ns)=dcmplx(dcos(om*ts),dsin(om*ts))
      sinusoid(ns)=sinusoid(ns)*dexp(-alpha*ts)
!      print *,sinusoid(ns)
      if(amp(1).eq.0.0d0) then !toroidal modes
        iamp1=2
        iamp2=3
      elseif(amp(2).eq.0.0d0.and.amp(3).eq.0.0d0) then ! radial modes
        iamp1=1
        iamp2=1
      else !spheroidal modes
        iamp1=1
        iamp2=4
      endif
      do i=ns+1,nps
        sinusoid(i)=de*sinusoid(i-1)
        do j=iamp1,iamp2
         seismogram(j,i)=seismogram(j,i)+scale0*amp(j)*(1-mrw*dreal(sinusoid(i)))
!         seismogram(j,i)=seismogram(j,i)+scale0*om*amp(j)*mrw*dimag(sinusoid(i))
       enddo
      enddo
!
      deallocate(sinusoid)
      return
      end subroutine time_series
!=================================================================
end module timeseries
