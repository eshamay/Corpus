FC = ifort
INCLUDE = $(PWD)
MKLLIBS		= -lmkl_intel_lp64 -lmkl_sequential -lmkl_core
BLAS = $(MKLLIBS)

LINALG = /home/eric/md/Corpus/linear_algebra_ops.o
MAIN = md_math.o md_system.o xyz_parsing.o main.o 
MDTEST = md_math.o md_system.o bondgraph.o xyz_parsing.o md_test.o 

main : $(MAIN)
	$(FC) -o main $(MAIN)

md_test : $(MDTEST)
	$(FC) -o mdtest $(MDTEST)
clean :
	rm *.o *.mod main a.out test

%.o: %.f90
	$(FC) -c -o $@ $<
