
!use xyz_parsing_module, only : xyz_OpenFile,      &
                               !xyz_LoadNextFrame, &
                               !xyz_atoms, xyz_num_atoms

module xyz_parsing_module

  implicit none

  character(100) :: xyz_file_name
  integer :: xyz_file_stat, xyz_file_unit 
  integer,target :: xyz_num_atoms

  type xyz_atom_type
    character(len=5) :: name
    real*8 :: x, y, z
  end type xyz_atom_type

  type(xyz_atom_type),pointer :: xyz_atoms(:)

contains 

  ! open the file and read the first frame
  subroutine xyz_OpenFile (fileUnit, fileName)

    character(len=100),intent(in) :: fileName
    integer,intent(in) :: fileUnit
    integer :: stat

    xyz_file_unit = fileUnit
    xyz_file_name = fileName
    open(xyz_file_unit,file=xyz_file_name,status='old',iostat=stat)

  end subroutine xyz_OpenFile


  subroutine xyz_ReadHeader ()
    read(xyz_file_unit,*) xyz_num_atoms
    read(xyz_file_unit,*)  !! skip a line
  end subroutine xyz_ReadHeader


  subroutine xyz_ReadFrame ()
    integer :: i

    nullify(xyz_atoms)
    allocate( xyz_atoms (xyz_num_atoms) )
    do i=1,xyz_num_atoms
      read(xyz_file_unit,*) xyz_atoms(i)%name, xyz_atoms(i)%x, xyz_atoms(i)%y, xyz_atoms(i)%z
    end do
  end subroutine xyz_ReadFrame


  subroutine xyz_LoadNextFrame ()
    call xyz_ReadHeader()
    call xyz_ReadFrame
  end subroutine xyz_LoadNextFrame


end module xyz_parsing_module

