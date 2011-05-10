module md_system_module
  
  type md_pbc_type
    logical :: pbc_set
    real*8, dimension(3) :: system_size
  end type md_pbc_type

contains

  function md_minimum_pbc_distance (pos1, pos2, pbc) result (distance)
    real*8, dimension(3) :: pos1, pos2, distance
    type(md_pbc_type) :: pbc
  end function md_minimum_pbc_distance

end module md_system_module
