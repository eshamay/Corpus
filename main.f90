program test

integer, parameter :: dp = kind(1.0d0)

real(dp), external :: ddot
real, external :: sdot

real, dimension(3) :: a,b
real(dp), dimension(3) :: d,e

integer :: i


do i = 1,3
  a(i) = 1.0*i
  b(i) = 3.5*i
  d(i) = 1.0d0*i
  e(i) = 3.5d0*i
end do
a(:) = b(1)
print *, a

write (*,200) "sdot real(4) = ", sdot(3,a,1,b,1)  ! should work and return 49.0
write (*,200) "sdot real(8) = ", sdot(3,d,1,e,1)  ! should work and return 49.0
write (*,200) "ddot real(4) = ", ddot(3,a,1,b,1)  ! should work and return 49.0
write (*,200) "ddot real(8) = ", ddot(3,d,1,e,1)  ! should work and return 49.0
200 format(a,f9.2)

end program test
