program md_tester

use xyz_parsing_module
use md_system_module
use bond_graph_module

implicit none

type(xyz_file_type) :: xyz_file
real*8, dimension(:), allocatable :: positions
type(md_pbc_type) :: pbc
type(bg_graph_type) :: graph
integer :: j

! open an xyz file
call xyz_OpenFile(1, "temp.xyz", xyz_file)
call xyz_LoadNextFrame(xyz_file)
allocate (positions(xyz_file%num_atoms*3))
positions = xyz_positions (xyz_file)

! set the periodic boundaries
pbc%system_size = (/ 10.0, 10.0, 15.0 /)

! create the graph
graph = bg_InitializeGraph (positions, xyz_file%num_atoms, pbc)
call bg_UpdateGraphDistances (positions, graph, pbc)

do j=2,5
  write (*,*) graph%graph(1,j)%bond(:)
end do

end program md_tester
