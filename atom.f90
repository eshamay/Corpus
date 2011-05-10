module atom_module
  implicit none

  integer, parameter :: atom_H = 1, atom_He = 2, atom_B = 5, &
                        atom_C = 6, atom_N = 7, atom_O = 8,  &
                        atom_F = 9, atom_Na = 11, atom_Cl = 17

  type atom_type
    integer         :: element
    real            :: mass
    real*8,pointer  :: x,y,z       ! atomic position
  end type atom_type

