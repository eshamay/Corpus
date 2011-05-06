include 'xyz_coordinate_file.f90'

program readtext

use xyz_coordinate_file

character(100) :: filename
type(atom), dimension(:),pointer :: atoms
integer :: i, j, stat, numAtoms, stepnum

filename = "malonic-cluster-md-1-pos-1.xyz"
! open the file
open(1,file=filename,status='old',iostat=stat)

call ReadXYZFrame (1, numAtoms, atoms, stepnum)
call ReadXYZFrame (1, numAtoms, atoms, stepnum)

write (*,*) "found ", numAtoms, " atoms"

do i=1,numAtoms
  write (*,*) atoms(i)%name, char(9), atoms(i)%x, atoms(i)%y, atoms(i)%z
end do

end program readtext
