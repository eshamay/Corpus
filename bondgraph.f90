! a simple connectivity matrix to keep track of the interconnections
! between atoms of an MD system
module bond_graph_module

  type bondgraph_type
    integer :: graph_size
    real*8, allocatable, dimension(:,:) :: graph
  end type bondgraph_type

contains

  function bondgraph_CreateBondGraph (positions, num_atoms) result (graph)
    type(bondgraph_type) :: graph
    integer :: num_atoms
    real*8, dimension(num_atoms * 3) :: positions

    allocate (graph%graph (num_atoms,num_atoms))
    graph(:,:) = 0.0d0

  end function bondgraph_CreateBondGraph

end module bond_graph_module

