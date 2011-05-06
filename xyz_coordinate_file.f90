module XYZ_coordinate_file

implicit none

  type atom
    character(len=5) :: name
    real*8 :: x, y, z
  end type atom

contains 

  function test (x,y)
    integer :: test
    integer, intent(in) :: x
    integer, intent(out) :: y

    y = x + 3
    test = y
    write (*,*) x, y, test
  end function test

  subroutine ReadXYZFrame (fileUnit, numAtoms, atoms, step)
  
    integer, intent(in) :: fileUnit
    integer, intent(out) :: numAtoms, step
    type(atom), intent(out), pointer :: atoms(:)
    integer :: i
  
    read(fileUnit,*) numAtoms
    allocate( atoms(numAtoms) )
  
    read(fileUnit,*)  !! skip a line
  
    do i=1,numAtoms
      read(fileUnit,*) atoms(i)%name, atoms(i)%x, atoms(i)%y, atoms(i)%z
    end do
  
  end subroutine ReadXYZFrame

end module XYZ_coordinate_file

