program tester

use xyz_parsing_module

type(xyz_file_type) :: xyz_file

call xyz_OpenFile (1, "temp.xyz", xyz_file)
call xyz_LoadNextFrame(xyz_file)

write (*,*) xyz_file%num_atoms, xyz_file%atoms(4)

end program tester
