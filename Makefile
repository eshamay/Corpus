FC = ifort
MKLLIBS		= -lmkl_intel_lp64 -lmkl_sequential -lmkl_core
BLAS = $(MKLLIBS)

LINALG = /home/eric/md/Corpus/linear_algebra_ops.o

main : $(LINALG)
	$(FC) -o main $(LINALG) $(BLAS) main.f90

clean :
	rm *.o *.mod main a.out test

%.o: %.f90
	$(FC) -c -o $@ $<
