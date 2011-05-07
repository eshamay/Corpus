program testit

   USE linear_algebra_ops

  real, dimension(3) :: a,b
  type(matrix), dimension(3) :: c,d
  integer :: i

do i=1,3
  a(i) = 1.0*i
  b(i) = 3.5*i
end do

c = a
d = b
write (*,*) c
write (*,*) d
write (*,*) c-d

end program testit
