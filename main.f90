program tester

use xyz_parsing_module

type(xyz_file_type) :: xyz_file

call xyz_OpenFile (1, "temp.xyz", xyz_file)
do i=1,3
  call xyz_LoadNextFrame(xyz_file)
  write (*,*) xyz_file%num_atoms
  write (*,*) xyz_file%atoms(4)
end do

end program tester
