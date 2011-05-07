program test

use linear_algebra_module

type(matrix_type),dimension(3) :: a, b
double precision, dimension(3) :: c
integer :: i

do i = 1,3
  c(i) = i
end do

a = c
b = a

write (*,*) c, a, b


end program test
