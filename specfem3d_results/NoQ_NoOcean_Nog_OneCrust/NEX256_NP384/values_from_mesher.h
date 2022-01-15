 
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
 ! number of processors =          384
 !
 ! maximum number of points per region =       615729
 !
 ! on NEC SX, make sure "loopcnt=" parameter
 ! in Makefile is greater than max vector length =      1847187
 !
 ! total elements per slice =        10736
 ! total points per slice =       723311
 !
 ! total for full 6-chunk mesh:
 ! ---------------------------
 !
 ! exact total number of spectral elements in entire mesh = 
 !    3958784.00000000     
 ! approximate total number of points in entire mesh = 
 !    267017979.000000     
 ! approximate total number of degrees of freedom in entire mesh = 
 !    749726193.000000     
 !
 ! resolution of the mesh at the surface:
 ! -------------------------------------
 !
 ! spectral elements along a great circle =         1024
 ! GLL points along a great circle =         4096
 ! average distance between points in degrees =   8.7890625E-02
 ! average distance between points in km =    9.772991    
 ! average size of a spectral element in km =    39.09196    
 !
 ! number of time steps =        84300
 !
 ! number of seismic sources =            1
 !
 
 ! approximate static memory needed by the solver:
 ! ----------------------------------------------
 !
 ! size of static arrays per slice =   0.194565262645483       GB
 !
 !   (should be below to 80% or 90% of the memory installed per core)
 !   (if significantly more, the job will not run by lack of memory )
 !
 ! size of static arrays for all slices =    74.7130608558655       GB
 !                                      =   7.296197349205613E-002  TB
 !
 
 integer, parameter :: NEX_XI_VAL =          256
 integer, parameter :: NEX_ETA_VAL =          256
 
 integer, parameter :: NSPEC_CRUST_MANTLE =         9216
 integer, parameter :: NSPEC_OUTER_CORE =          960
 integer, parameter :: NSPEC_INNER_CORE =          560
 integer, parameter :: NSPEC_TRINFINITE =            0
 integer, parameter :: NSPEC_INFINITE =            0
 
 integer, parameter :: NGLOB_CRUST_MANTLE =       615729
 integer, parameter :: NGLOB_OUTER_CORE =        66833
 integer, parameter :: NGLOB_INNER_CORE =        40749
 integer, parameter :: NGLOB_TRINFINITE =            0
 integer, parameter :: NGLOB_INFINITE =            0
 
 integer, parameter :: NSPECMAX_ANISO_IC =            1
 
 integer, parameter :: NSPECMAX_ISO_MANTLE =         9216
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
 
 logical, parameter :: FULL_GRAVITY_VAL = .false.
 
 logical, parameter :: OCEANS_VAL = .false.
 
 logical, parameter :: ROTATION_VAL = .false.
 integer, parameter :: NSPEC_OUTER_CORE_ROTATION =            1
 
 integer, parameter :: NPROC_XI_VAL =            8
 integer, parameter :: NPROC_ETA_VAL =            8
 integer, parameter :: NCHUNKS_VAL =            6
 integer, parameter :: NPROCTOT_VAL =          384
 
 integer, parameter :: ATT1 =            1
 integer, parameter :: ATT2 =            1
 integer, parameter :: ATT3 =            1
 integer, parameter :: ATT4 =            1
 integer, parameter :: ATT5 =            1
 
 integer, parameter :: NSPEC2DMAX_XMIN_XMAX_CM =          528
 integer, parameter :: NSPEC2DMAX_YMIN_YMAX_CM =          528
 integer, parameter :: NSPEC2D_BOTTOM_CM =           64
 integer, parameter :: NSPEC2D_TOP_CM =         1024
 integer, parameter :: NSPEC2DMAX_XMIN_XMAX_IC =          140
 integer, parameter :: NSPEC2DMAX_YMIN_YMAX_IC =          140
 integer, parameter :: NSPEC2D_BOTTOM_IC =           16
 integer, parameter :: NSPEC2D_TOP_IC =           16
 integer, parameter :: NSPEC2DMAX_XMIN_XMAX_OC =          144
 integer, parameter :: NSPEC2DMAX_YMIN_YMAX_OC =          144
 integer, parameter :: NSPEC2D_BOTTOM_OC =           16
 integer, parameter :: NSPEC2D_TOP_OC =           64
 integer, parameter :: NSPEC2DMAX_XMIN_XMAX_TRINF =            0
 integer, parameter :: NSPEC2DMAX_YMIN_YMAX_TRINF =            0
 integer, parameter :: NSPEC2D_BOTTOM_TRINF =            0
 integer, parameter :: NSPEC2D_TOP_TRINF =            0
 integer, parameter :: NSPEC2DMAX_XMIN_XMAX_INF =            0
 integer, parameter :: NSPEC2DMAX_YMIN_YMAX_INF =            0
 integer, parameter :: NSPEC2D_BOTTOM_INF =            0
 integer, parameter :: NSPEC2D_TOP_INF =            0
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
