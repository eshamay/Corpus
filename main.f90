program tester

use xyz_parsing_module

type(xyz_file_type) :: xyz_file
real, dimension(:), allocatable :: positions

call xyz_OpenFile (1, "temp.xyz", xyz_file)
call xyz_LoadNextFrame(xyz_file)
allocate (positions(xyz_file%num_atoms*3))
do while (.not. xyz_file%file_eof)
  positions = xyz_positions (xyz_file)
  write (*,*) positions(153*3-2:153*3)
  call xyz_LoadNextFrame(xyz_file)
end do

end program tester
