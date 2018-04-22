      program spherical
!
      implicit none
!
      include "spherical.h"
!
      include "minos.h"
!
      integer yr,jda,ho,mi
      integer yr1,jda1,ho1,mi1
      integer ns,nps,nstn
      integer i,j,ios,iom
      integer is,ir
      integer lnblnk
      integer n,l,lprev
      real elat,elon,depth
      real sphif,sdlt,slnda,moment
      real mrr,mtt,mpp,mrt,mrp,mtp
      real radius,rho,vpv,vph,vsv,vsh,eta,qmu,qkappa
      real r(NL)
      real rs,ws,dws,us,dus,vs,dvs
      real w(NL),dw(NL)
      real u(NL),du(NL),v(NL),dv(NL)
      real rlat,rlon,stele,stbur,stazi,stdip,spsec,sec1
      double precision delta,aze,azr
      double precision k,fac
      double precision a0,a1,a2,b1,b2
      double precision a,dadt,dadp
      double precision amp(3)
      double precision t0,ts,dt,hdur,reclen
      double precision theta,phi
      double precision om,q,av,ah
      double precision sint,cost,p(3),dp(3)
      double precision sinp,cosp,sin2p,cos2p
      double precision T_min,T_max,om_min,om_max
      double precision seismogram(3,NTMAX)
      character*4 stn
      character*2 ntw
      character*80 cmt_file,station_file
      character*80 model_file,toroidal_file,radial_file,spheroidal_file


!       specify the catalogue information

      read(*,'(a)') model_file
      read(*,'(a)') toroidal_file
      read(*,'(a)') radial_file
      read(*,'(a)') spheroidal_file
      print *,' '
      print *,'          model file: ',model_file(1:lnblnk(model_file))
      print *,'  toroidal mode file: ',toroidal_file(1:lnblnk(toroidal_file))
      print *,'    radial mode file: ',radial_file(1:lnblnk(radial_file))
      print *,'spheroidal mode file: ',spheroidal_file(1:lnblnk(spheroidal_file))
!     specify the earthquake location (elat,elon,depth)
!     specify the dip and azimuth of the fault plane and rake of slip
!             and derive the moment tensor (sdlt,slnda,sphif -> Mii)
!             (hiroo class notes)
!     specify the half duration(hdur)
      read(*,*) elat,elon,depth
      read(*,*) sphif,sdlt,slnda,moment
      moment = moment/1e30
      call adr2cmt(sphif,sdlt,slnda,moment,mrr,mtt,mpp,mrt,mrp,mtp)
      print *,' '
      print *,' scaled moment tensor:', mrr,mtt,mpp
      print *,'                      ', mrt,mrp,mtp
!
      read(*,*) hdur


!       specify the shortest period in mode summation

      read(*,*) T_min
      T_max=6000.0d0
      om_max=PI2/T_min
      om_min=PI2/T_max
      print *,' '
      print *,'shortest period in mode sum: ',T_min,' seconds'

!       specify sampliing rate and length of the record in seconds

      read(*,*) dt,reclen
      if (2*dt > T_min) stop ' Sampling rate too large'
      nps=int(reclen/dt) 
      t0=0.0
      print *,' '
      print *,'start time (s): ',t0, '  dt (s): ',dt
      print *,'record length (s): ', reclen,'  npts: ',nps
     


!       get the radii for the upper NL layers at which the eigenfunctions
!       are stored; needed for source radius

      open(unit=1,file=model_file)
      rewind(1)
      j=0
      do i=1,NR
        read(1,*) ir,radius,rho,vpv,vph,vsv,vsh
        if(i.gt.NR-NL) then
          j=j+1
          r(j)=radius/RA
        endif
      enddo
      close(unit=1)
      if(j.ne.NL) call exit(1)


!       get the source radius and index
!
      rs=1.0-depth*1000.0/RA ! non-dimensionalized source radius
      is=NL
      do while(r(is).gt.rs) ! find radius r(is) just below source radius rs
        is=is-1
      enddo
      if(is.lt.1) call exit(1)

!
!       read the station information and loop over stations
!
      
       station_file='STATIONS'
       open(unit=1,file=station_file,status='old',iostat=ios)
       if (ios.ne.0) stop 'Error opening station file STATIONS'
       read(1,*,iostat=ios) nstn
       print *,' '
       print *,'number of stations: ', nstn
       read(1,*,iostat=ios) stn,ntw,rlat,rlon,stele,stbur
       do while (ios .eq. 0) 
          ns=1
          ts=t0
!
!           epicentral distance and azimuth
!
          call delaz(elat,elon,rlat,rlon,delta,aze,azr)
!
          print *,' '
          print *,'station: ',stn(1:lnblnk(stn))
          print *,'epicentral distance: ',delta,' degrees'
!
!           aze is measured clockwise from due North by delaz; convert this
!           to a counterclockwise measurement from due South, which is the
!           Dahlen & Tromp convention
!
          aze=180.0d0-aze
          if(aze.lt.0.0d0) aze=aze+360.0d0
          print *,'source azimuth: ',aze,' degrees (c.c. from due South)'
!
!           initialize information for Legendre calculations
!
          theta=delta*PI/180.0d0
          sint=dsin(theta)
          if(sint.lt.1.0d-09) sint=1.0d-09
          cost=dcos(theta)
          phi=aze*PI/180.0d0
          sinp=dsin(phi)
          cosp=dcos(phi)
          sin2p=dsin(2.0d0*phi)
          cos2p=dcos(2.0d0*phi)
!
!           initialize the three-component mode sum
!
          do i=1,nps
            do j=1,3
              seismogram(j,i)=0.0d0
            enddo
          enddo
          print *,' '
	  print *,'Start mode summation ....'
!
!           start toroidal mode sum
!
          open(unit=2,file=toroidal_file,status='old',form='unformatted')
          rewind(2)
          iom=0
          lprev=0
          do while(iom.eq.0)
            read(2,iostat=iom)n,l,om,q,av,ah,(w(i),i=1,NL),(dw(i),i=1,NL)
           if(iom.eq.0) then
              if(om.ge.om_min.and.om.le.om_max) then
!                 minos calculates and stores all the overtones for a give
!                 degree, so Legendre polynomials have to be calculated
!                 only once per degree
!
                if(l.ne.lprev) then
                  call plm(l,cost,sint,p,dp)
                  k=dsqrt(dble(l*(l+1)))
                  fac=dble(2*l+1)/(4.0d0*PI)
                  lprev=l
                endif
!
!                 get w and dw at the source radius rs
!
                if(r(is).eq.rs) then
                  ws=w(is)
                  dws=dw(is)
                else
                  call interpolate(r(is),w(is),dw(is),r(is+1),w(is+1),dw(is+1),rs,ws,dws)
                endif
!
!                 Dahlen & Tromp (10.56-10.59) for toroidal modes,
!                 but with minos modes: W_DT=om*W_minos
!
                a1=dble(-mrp*(dws-ws/rs)/k)
                b1=dble(mrt*(dws-ws/rs)/k)
                a2=dble(-mtp*ws/(k*rs))
                b2=dble(0.5*(mtt-mpp)*ws/(k*rs))
!
                dadt=dp(2)*(a1*cosp+b1*sinp)+dp(3)*(a2*cos2p+b2*sin2p)
                dadp=p(2)*(-a1*sinp+b1*cosp)+2.0d0*p(3)*(-a2*sin2p+b2*cos2p)
!
!                 longitudinal and transverse components
!
                amp(1)=0.0d0                !vertical
                amp(2)=fac*ah*dadp/sint     !longitudinal
                amp(3)=-fac*ah*dadt         !transverse
!
                call time_series(ns,ts,nps,dt,om,q,hdur,amp,seismogram)
!
              endif
            endif
          enddo
          close(unit=2)
          print *,'Finishing toroidal modes....'
!
!           start radial mode sum
!
          open(unit=2,file=radial_file,status='old',form='unformatted')
          rewind(2)
          iom=0
          do while(iom.eq.0)
            read(2,iostat=iom)n,l,om,q,av,ah,(u(i),i=1,NL),(du(i),i=1,NL)

            if(iom.eq.0) then
              if(om.ge.om_min.and.om.le.om_max) then
                if(n.eq.0) then
                  fac=1.0d0/(4.0d0*PI)
                  p(1)=1.0d0
                endif
!
!                 get u and du at the source radius rs
!
                if(r(is).eq.rs) then
                  us=u(is)
                  dus=du(is)
                else
                  call interpolate(r(is),u(is),du(is),r(is+1),u(is+1),du(is+1), &
                  rs,us,dus)
                endif
!
!                 Dahlen & Tromp (10.54) for radial modes,
!                 but with minos modes: U_DT=om*U_minos
!
                a0=dble(mrr*dus+(mtt+mpp)*us/rs)
!
                a=p(1)*a0
!
!               vertical component
!
                amp(1)=fac*av*a
                amp(2)=0.0d0
                amp(3)=0.0d0
!
                call time_series(ns,ts,nps,dt,om,q,hdur,amp,seismogram)
!
              endif
            endif
          enddo
          close(unit=2)
          print *,'Finishing radial modes....'
!
!           start spheroidal mode sum
!
          open(unit=2,file=spheroidal_file,status='old',form='unformatted')
          rewind(2)
          iom=0
          lprev=0
          do while(iom.eq.0)
            read(2,iostat=iom)n,l,om,q,av,ah,(u(i),i=1,NL),(du(i),i=1,NL),      &
            (v(i),i=1,NL),(dv(i),i=1,NL)
            if(iom.eq.0) then
              if(om.ge.om_min.and.om.le.om_max) then
                if(l.ne.lprev) then
                  call plm(l,cost,sint,p,dp)
                  k=dsqrt(dble(l*(l+1)))
                  fac=dble(2*l+1)/(4.0d0*PI)
                  lprev=l
                endif
!
!                 get u, du, v, and dv at the source radius rs
!
                if(r(is).eq.rs) then
                  us=u(is)
                  dus=du(is)
                  vs=v(is)
                  dvs=dv(is)
                else
                  call interpolate(r(is),u(is),du(is),r(is+1),u(is+1),du(is+1), &
                  rs,us,dus)
                  call interpolate(r(is),v(is),dv(is),r(is+1),v(is+1),dv(is+1), &
                  rs,vs,dvs)
                endif
!
!                 Dahlen & Tromp (10.54-10.59) for spheroidal modes,
!                 with U_DT=om*U_minos and V_DT=om*V_minos
!
                a0=dble(mrr*dus+(mtt+mpp)*(us-0.5*k*vs)/rs)
                a1=dble(mrt*(dvs-vs/rs+k*us/rs)/k)
                b1=dble(mrp*(dvs-vs/rs+k*us/rs)/k)
                a2=dble(0.5*(mtt-mpp)*vs/(k*rs))
                b2=dble(mtp*vs/(k*rs))
!
                a=p(1)*a0+p(2)*(a1*cosp+b1*sinp)+p(3)*(a2*cos2p+b2*sin2p)
                dadt=dp(1)*a0+dp(2)*(a1*cosp+b1*sinp)+dp(3)*(a2*cos2p+b2*sin2p)
                dadp=p(2)*(-a1*sinp+b1*cosp)+2.0d0*p(3)*(-a2*sin2p+b2*cos2p)
!
!                 vertical, longitudinal, and transverse components
!
                amp(1)=fac*av*a           !vertical
                amp(2)=fac*ah*dadt        !longitudinal
                amp(3)=fac*ah*dadp/sint   !transverse
!
                call time_series(ns,ts,nps,dt,om,q,hdur,amp,seismogram)
!
              endif
            endif
          enddo
          close(unit=2)
          print *,'Finishing spheroidal modes....'

          call write_record(elat,elon,rlat,rlon,stn,ntw,dt,nps,seismogram)
!
          read(1,*,iostat=ios) stn,ntw,rlat,rlon,stele,stbur

      enddo
      close(unit=1)
!
      print *,' '
      print *,'       DONE        '
      print *,' '
!
      end
!
      subroutine interpolate(r1,f1,df1,r2,f2,df2,rs,fs,dfs)
!
      implicit none
!
!     interpolate finds the value of a function fs and its derivative dfs
!     at the radius rs by interpolating given values of the function and its
!     derivative just below the source at radius r1, given by f1 and df1,
!     and values just above the source ar radius r2, given by f2 and df2.
!     Note that we should have r2 > rs > r1.
!
      real r1,f1,df1,r2,f2,df2,rs,fs,dfs
!
      real h,dr
!
      h=rs-r1
      dr=r2-r1
      if((h.lt.0.0).or.(dr.lt.0.0)) then
        write(6,"('wrong input in interpolate')")
        call exit(1)
      endif
!
      fs=f1+h*df1+0.5*h*h*(df2-df1)/dr
      dfs=df1+h*(df2-df1)/dr
      return
      end
!

