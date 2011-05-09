program tester

use xyz_parsing_module

type(xyz_file_type) :: xyz_file

call xyz_OpenFile (1, "temp.xyz", xyz_file)

do while (.not. xyz_file%file_eof)
  call xyz_LoadNextFrame(xyz_file)
  write (*,*) xyz_file%atoms(4)
end do

call xyz_CloseFile (xyz_file)

end program tester
