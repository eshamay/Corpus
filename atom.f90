module atom_module
  implicit none

  type atom_type
    integer         :: element
    real            :: mass
    real*8,pointer  :: x,y,z       ! atomic position
  end type atom_type

