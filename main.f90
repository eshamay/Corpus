include 'xyz_parsing.f90'

program readtext

use xyz_parsing_module, only : xyz_OpenFile,      &
                               xyz_LoadNextFrame, &
                               xyz_atoms, xyz_num_atoms
  
  character(100) :: filename
  integer :: i, j
  
  filename = "temp.xyz"
  
  call xyz_OpenFile(1, filename)
  call xyz_LoadNextFrame
  
  !do i=1,xyz_num_atoms
    !write (*,*) xyz_atoms(i)%name, xyz_atoms(i)%x, xyz_atoms(i)%y, xyz_atoms(i)%z
  !end do
  
end program readtext
