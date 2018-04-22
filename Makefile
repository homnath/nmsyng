FC = gfortran   # fortran compiler
FFLAGS =  -O3 -funroll-loops -ffixed-line-length-132

xnmsyn: delaz.f90 get_cmt.f90 mnam.f90 plm.f90 timeseries.f90 nmsyn.f90 tdiffer.f90 write_record.f90 get_mode.f90 check_norm.f90 intgrl_disc.f90 find_disc.f90
	$(FC) $(FFLAGS) -g -o xnmsyn delaz.f90 get_cmt.f90 mnam.f90 plm.f90 nmsyn.f90 tdiffer.f90 timeseries.f90 write_record.f90 get_mode.f90 check_norm.f90 intgrl_disc.f90 find_disc.f90

xnmsyn2: delaz.f90 get_cmt.f90 mnam.f90 plm.f90 nmsyn2.f90 tdiffer.f90 timeseries.f90 write_record.f90 adr2cmt.f90
	$(FC) $(FFLAGS) -g -o xnmsyn2 delaz.f90 get_cmt.f90 mnam.f90 plm.f90 nmsyn2.f90 tdiffer.f90 timeseries.f90 write_record.f90 adr2cmt.f90

clean:
	\rm -f *.o xnmsyn *~
