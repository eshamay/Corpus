! a simple connectivity matrix to keep track of the interconnections
! between atoms of an MD system
module bond_graph_module

  use md_system_module, only : md_pbc_type

  !! All bondlengths are given in angstroms
  real*8, parameter ::  bg_oh_bond_length = 1.1,               &
                        bg_hbond_length = 2.46,                &
                        bg_ch_bond_length = 1.7,               &
                        bg_co_bond_length = 1.7,               &
                        bg_so_bond_length = 1.7

  ! The different types of bonds in the system
  integer, parameter :: bg_unbound = 0,           &
                        bg_covalent = 1,          &
                        bg_hbond = 2

  ! represents a node in the graph and holds information regarding bonding and
  ! distance between atoms
  type bg_node_type
    integer :: bond_type
    real*8 :: distance
  end type bg_node_type

  type bg_graph_type
    integer :: graph_size
    type(bg_node_type), allocatable, dimension(:,:) :: graph
  end type bg_graph_type

contains


  function bg_InitializeGraph (positions, num_atoms, pbc) result (graph)
    type(bg_graph_type) :: graph
    integer :: num_atoms
    ! the positions of all the atoms in the graph have to be given in this
    ! format: one long array...
    real*8, dimension(num_atoms * 3) :: positions
    type(md_pbc_type) :: pbc

    graph%graph_size = num_atoms
    allocate (graph%graph (num_atoms,num_atoms))
    call bg_ClearGraph(graph)
    call bg_UpdateGraphDistances(positions, graph, pbc)
  end function bg_InitializeGraph


  ! goes through each pair of position vectors and calculates the distance
  ! between them
  subroutine bg_UpdateGraphDistances (positions, graph, pbc)
    type(bg_graph_type) :: graph
    real*8, dimension(graph%graph_size * 3) :: positions
    type(md_pbc_type) :: pbc

    ! this populates the upper triangle of the matrix with the distances between
    ! the element pairs
    do i=0,graph%graph_size-1
      do j=i+1,graph%graph_size

        if (pbc%pbc_set) then
          graph%graph(i,j)%distance =       &
          md_minimum_distance (positions(3*i+1:3*i+3), &
                               positions(3*j+1:3*j+3), &
                               pbc)
        else
          graph%graph(i,j)%distance =       &
          linalg_distance(  &
                positions(3*i+1:3*i+3), &
                positions(3*j+1:3*j+3))
        end if

      end do
    end do

  end subroutine bg_UpdateGraphDistances




  ! sets all the nodes to clear (unbound) values -- does not deallocate the
  ! graph
  subroutine bg_ClearGraph (graph)
    type(bg_graph_type),intent(inout) :: graph
    type(bg_node_type) :: clear_node 
    clear_node = bg_node_type(bg_unbound, 0.0d0)
    graph%graph(:,:) = clear_node
  end subroutine bg_ClearGraph


end module bond_graph_module

