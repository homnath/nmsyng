 
 !
 ! this is the parameter file for static compilation of the solver
 !
 ! mesh statistics:
 ! ---------------
 !
 !
 ! number of chunks =            6
 !
 ! these statistics include the central cube
 !
 ! number of processors =          726
 !
 ! maximum number of points per region =       158305
 !
 ! on NEC SX, make sure "loopcnt=" parameter
 ! in Makefile is greater than max vector length =       474915
 !
 ! total elements per slice =         5460
 ! total points per slice =       378781
 !
 ! total for full 6-chunk mesh:
 ! ---------------------------
 !
 ! exact total number of spectral elements in entire mesh = 
 !    3910720.00000000     
 ! approximate total number of points in entire mesh = 
 !    271470161.000000     
 ! approximate total number of degrees of freedom in entire mesh = 
 !    788354343.000000     
 !
 ! resolution of the mesh at the surface:
 ! -------------------------------------
 !
 ! spectral elements along a great circle =          704
 ! GLL points along a great circle =         2816
 ! average distance between points in degrees =   0.1278409    
 ! average distance between points in km =    14.21526    
 ! average size of a spectral element in km =    56.86104    
 !
 ! number of time steps =        84300
 !
 ! number of seismic sources =            1
 !
 
 ! approximate static memory needed by the solver:
 ! ----------------------------------------------
 !
 ! size of static arrays per slice =   5.054238066077232E-002  GB
 !
 !   (should be below to 80% or 90% of the memory installed per core)
 !   (if significantly more, the job will not run by lack of memory )
 !
 ! size of static arrays for all slices =    36.6937683597207       GB
 !                                      =   3.583375816378975E-002  TB
 !
 
 integer, parameter :: NEX_XI_VAL =          176
 integer, parameter :: NEX_ETA_VAL =          176
 
 integer, parameter :: NSPEC_CRUST_MANTLE =         2304
 integer, parameter :: NSPEC_OUTER_CORE =          240
 integer, parameter :: NSPEC_INNER_CORE =          100
 integer, parameter :: NSPEC_TRINFINITE =         2560
 integer, parameter :: NSPEC_INFINITE =          256
 
 integer, parameter :: NGLOB_CRUST_MANTLE =       158305
 integer, parameter :: NGLOB_OUTER_CORE =        17945
 integer, parameter :: NGLOB_INNER_CORE =         8181
 integer, parameter :: NGLOB_TRINFINITE =       173225
 integer, parameter :: NGLOB_INFINITE =        21125
 
 integer, parameter :: NSPECMAX_ANISO_IC =            1
 
 integer, parameter :: NSPECMAX_ISO_MANTLE =         2304
 integer, parameter :: NSPECMAX_TISO_MANTLE =            1
 integer, parameter :: NSPECMAX_ANISO_MANTLE =            1
 
 integer, parameter :: NSPEC_CRUST_MANTLE_ATTENUAT =            1
 integer, parameter :: NSPEC_INNER_CORE_ATTENUATION =            1
 
 integer, parameter :: NSPEC_CRUST_MANTLE_STR_OR_ATT =            1
 integer, parameter :: NSPEC_INNER_CORE_STR_OR_ATT =            1
 
 integer, parameter :: NSPEC_CRUST_MANTLE_STR_AND_ATT =            1
 integer, parameter :: NSPEC_INNER_CORE_STR_AND_ATT =            1
 
 integer, parameter :: NSPEC_CRUST_MANTLE_STRAIN_ONLY =            1
 integer, parameter :: NSPEC_INNER_CORE_STRAIN_ONLY =            1
 
 integer, parameter :: NSPEC_CRUST_MANTLE_ADJOINT =            1
 integer, parameter :: NSPEC_OUTER_CORE_ADJOINT =            1
 integer, parameter :: NSPEC_INNER_CORE_ADJOINT =            1
 integer, parameter :: NSPEC_TRINFINITE_ADJOINT =            1
 integer, parameter :: NSPEC_INFINITE_ADJOINT =            1
 integer, parameter :: NGLOB_CRUST_MANTLE_ADJOINT =            1
 integer, parameter :: NGLOB_OUTER_CORE_ADJOINT =            1
 integer, parameter :: NGLOB_INNER_CORE_ADJOINT =            1
 integer, parameter :: NGLOB_TRINFINITE_ADJOINT =            1
 integer, parameter :: NGLOB_INFINITE_ADJOINT =            1
 integer, parameter :: NSPEC_OUTER_CORE_ROT_ADJOINT =            1
 
 integer, parameter :: NSPEC_CRUST_MANTLE_STACEY =            1
 integer, parameter :: NSPEC_OUTER_CORE_STACEY =            1
 
 integer, parameter :: NGLOB_CRUST_MANTLE_OCEANS =            1
 
 logical, parameter :: TRANSVERSE_ISOTROPY_VAL = .false.
 
 logical, parameter :: ANISOTROPIC_3D_MANTLE_VAL = .false.
 
 logical, parameter :: ANISOTROPIC_INNER_CORE_VAL = .false.
 
 logical, parameter :: ATTENUATION_VAL = .false.
 
 logical, parameter :: ATTENUATION_NEW_VAL = .false.
 
 logical, parameter :: ATTENUATION_3D_VAL = .true.
 
 logical, parameter :: ELLIPTICITY_VAL = .false.
 
 logical, parameter :: GRAVITY_VAL = .true.
 
 logical, parameter :: FULL_GRAVITY_VAL = .true.
 
 logical, parameter :: OCEANS_VAL = .false.
 
 logical, parameter :: ROTATION_VAL = .false.
 integer, parameter :: NSPEC_OUTER_CORE_ROTATION =            1
 
 integer, parameter :: NPROC_XI_VAL =           11
 integer, parameter :: NPROC_ETA_VAL =           11
 integer, parameter :: NCHUNKS_VAL =            6
 integer, parameter :: NPROCTOT_VAL =          726
 
 integer, parameter :: ATT1 =            1
 integer, parameter :: ATT2 =            1
 integer, parameter :: ATT3 =            1
 integer, parameter :: ATT4 =            1
 integer, parameter :: ATT5 =            1
 
 integer, parameter :: NSPEC2DMAX_XMIN_XMAX_CM =          264
 integer, parameter :: NSPEC2DMAX_YMIN_YMAX_CM =          264
 integer, parameter :: NSPEC2D_BOTTOM_CM =           16
 integer, parameter :: NSPEC2D_TOP_CM =          256
 integer, parameter :: NSPEC2DMAX_XMIN_XMAX_IC =           50
 integer, parameter :: NSPEC2DMAX_YMIN_YMAX_IC =           50
 integer, parameter :: NSPEC2D_BOTTOM_IC =            4
 integer, parameter :: NSPEC2D_TOP_IC =            4
 integer, parameter :: NSPEC2DMAX_XMIN_XMAX_OC =           72
 integer, parameter :: NSPEC2DMAX_YMIN_YMAX_OC =           72
 integer, parameter :: NSPEC2D_BOTTOM_OC =            4
 integer, parameter :: NSPEC2D_TOP_OC =           16
 integer, parameter :: NSPEC2DMAX_XMIN_XMAX_TRINF =          160
 integer, parameter :: NSPEC2DMAX_YMIN_YMAX_TRINF =          160
 integer, parameter :: NSPEC2D_BOTTOM_TRINF =          256
 integer, parameter :: NSPEC2D_TOP_TRINF =          256
 integer, parameter :: NSPEC2DMAX_XMIN_XMAX_INF =           16
 integer, parameter :: NSPEC2DMAX_YMIN_YMAX_INF =           16
 integer, parameter :: NSPEC2D_BOTTOM_INF =          256
 integer, parameter :: NSPEC2D_TOP_INF =          256
 integer, parameter :: NSPEC2D_MOHO =            1
 integer, parameter :: NSPEC2D_400 =            1
 integer, parameter :: NSPEC2D_670 =            1
 integer, parameter :: NSPEC2D_CMB =            1
 integer, parameter :: NSPEC2D_ICB =            1
 
 logical, parameter :: USE_DEVILLE_PRODUCTS_VAL = .true.
 logical, parameter :: USE_ATTENUATION_MIMIC = .false.
 logical, parameter :: COMPUTE_AND_STORE_STRAIN = .false.
 
 integer, parameter :: NSPEC_CRUST_MANTLE_3DMOVIE = 1
 integer, parameter :: NGLOB_CRUST_MANTLE_3DMOVIE = 1
