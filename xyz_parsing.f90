
!use xyz_parsing_module, only : xyz_OpenFile,      &
                               !xyz_LoadNextFrame, &
                               !xyz_atoms, xyz_num_atoms

module xyz_parsing_module

  implicit none

  !! An atom (i.e. a row of an xyz file) is represented by the atomic name, and
  ! the x,y,z coordinates in 4 rows
  type xyz_atom_type
    character(len=5) :: name
    real*8,dimension(3) :: position
  end type xyz_atom_type

  !! This holds all the information of an xyz file
  type xyz_file_type
    character(1000) :: file_name
    integer :: file_stat, file_unit 
    integer :: num_atoms
    type(xyz_atom_type),allocatable :: atoms(:)
    logical :: atoms_set    ! whether or not the container for the atoms has
                             ! already been set or not - do we need to allocate it?
    logical :: file_eof
  end type xyz_file_type


contains 

  ! opens the given file and packs the resulting info into the xyz_file argument
  subroutine xyz_OpenFile (fileUnit, fileName, xyz_file)

    character(*),intent(in) :: fileName
    integer,intent(in) :: fileUnit
    type(xyz_file_type),intent(out) :: xyz_file

    xyz_file%file_unit = fileUnit
    xyz_file%file_name = fileName
    open(xyz_file%file_unit,file=xyz_file%file_name,status='old',iostat=xyz_file%file_stat)

    xyz_file%atoms_set = .false.

    if (xyz_file%file_stat < 0) then
      xyz_file%file_eof = .true.
    else 
      xyz_file%file_eof = .false.
    end if

  end subroutine xyz_OpenFile


  subroutine xyz_CloseFile (xyz_file)
    type(xyz_file_type),intent(inout) :: xyz_file
    close(xyz_file%file_unit)
  end subroutine xyz_CloseFile

  subroutine xyz_ReadHeader (xyz_file)
    type(xyz_file_type),intent(inout) :: xyz_file

    !! parses the number of atoms in the upcoming frame
    read(xyz_file%file_unit,*,iostat=xyz_file%file_stat) xyz_file%num_atoms
    if (xyz_file%file_stat < 0) then
      xyz_file%file_eof = .true.
    else 
      xyz_file%file_eof = .false.
      !! skip a line, although there is often some good information in this line
      !that may be useful later... (i.e. timestep, step number, energy values...)
      read(xyz_file%file_unit,*)  
    end if
  end subroutine xyz_ReadHeader

  ! parses all the atoms (name, x,y,z) into the xyz_atoms container for a single
  ! frame.
  subroutine xyz_ReadFrame (xyz_file)
    type(xyz_file_type),intent(inout) :: xyz_file
    integer :: i

    ! if the atom list hasn't yet been created, then allocate the space for it
    if (.not. xyz_file%atoms_set) then
      allocate( xyz_file%atoms (xyz_file%num_atoms) )
      xyz_file%atoms_set = .true.
    end if

    if (.not. xyz_file%file_eof) then
      ! parse each atom (one per row) from the xyz file
      do i=1,xyz_file%num_atoms
        read(xyz_file%file_unit,*) xyz_file%atoms(i)%name, xyz_file%atoms(i)%position
      end do
    end if
  end subroutine xyz_ReadFrame

  subroutine xyz_LoadNextFrame (xyz_file)
    type(xyz_file_type),intent(inout) :: xyz_file
    call xyz_ReadHeader(xyz_file)
    call xyz_ReadFrame(xyz_file)
  end subroutine xyz_LoadNextFrame

  ! Returns a flat array of atomic positions parsed from the xyz file
  function xyz_positions (xyz_file)
    type(xyz_file_type),intent(inout) :: xyz_file
    real, dimension(xyz_file%num_atoms*3) :: xyz_positions
    integer :: i

    do i=0,xyz_file%num_atoms-1
      xyz_positions(3*i+1:3*i+3) = xyz_file%atoms(i+1)%position
    end do
  end function xyz_positions


end module xyz_parsing_module
