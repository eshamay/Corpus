FC = ifort
INCLUDE = $(PWD)
MKLLIBS		= -lmkl_intel_lp64 -lmkl_sequential -lmkl_core
BLAS = $(MKLLIBS)

LINALG = /home/eric/md/Corpus/linear_algebra_ops.o
MAIN = xyz_parsing.o main.o 

main : $(MAIN)
	$(FC) -o main $(MAIN)

clean :
	rm *.o *.mod main a.out test

%.o: %.f90
	$(FC) -c -o $@ $<
