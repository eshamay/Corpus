module md_system_module
  
  type md_pbc_type
    logical :: pbc_set
    real*8, dimension(3) :: system_size
  end type md_pbc_type

end module md_system_module
