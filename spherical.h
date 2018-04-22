!
!       LMAX: largest angular degree in mode sum
!
      integer,parameter :: LMAX=1700
! NCOMP: number of seimogram components, e.g., 4 for including gravity
      integer,parameter :: NCOMP=4
!
!       NTMAX: maximum number of samples in the time series
!
      integer,parameter :: NTMAX=10000
!
!       PI: pi
!       PI2: 2 * pi
!
      double precision,parameter :: PI=3.14159265358979d0,PI2=6.28318530717958d0
!
!       RA: radius of Earth (m)
!       GRAV: gravitational constant (N m^2 / kg^2)
!       RHOAV: average density of the Earth (kg / m^3)
!
      double precision,parameter :: RA=6371000.0d0,GRAV=6.6723d-11,RHOAV=5515.0d0

