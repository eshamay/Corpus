module linear_algebra_ops

  type matrix
    real :: elem
end type matrix

  interface assignment ( = )
    module procedure vector_from_real, vector_from_vector
  end interface assignment ( = )

  interface operator ( * )
    module procedure vector_inner_product!, vector_scaling
  end interface operator ( * )

  interface operator ( + )
    module procedure vector_add, matrix_add
  end interface operator ( + )

  interface operator ( - )
    module procedure vector_sub, matrix_sub
  end interface operator ( - )

contains
  

subroutine vector_from_real(X, Y)
  ! copy a 1D array of reals to a 1D array of type matrix
  real, intent(in), dimension(:) :: Y
  type(matrix), intent(out), dimension(size(Y,1)) :: X

  X(:)%elem = Y(:)
end subroutine vector_from_real


subroutine vector_from_vector(X, Y)
  ! copy a 1D array of type matrix
  type(matrix), intent(in), dimension(:) :: Y
  type(matrix), intent(out), dimension(size(Y,1)) :: X

  X(:)%elem = Y(:)%elem
end subroutine vector_from_vector




function vector_inner_product (Y, Z) result (X)
  type(matrix), intent(in), dimension(:) :: Y
  type(matrix), intent(in), dimension(size(Y,1)) :: Z
  real :: X
  X = ddot(size(Y,1), Y, 1, Z, 1)
end function vector_inner_product

  !
  ! ADDITION OPERATORS: X = Y + Z
  !

function matrix_add(Y, Z) result(X)
  ! add 2D arrays of type matrix
  type(matrix), intent(in), dimension(:,:) :: Y
  type(matrix), intent(in), dimension(size(Y,1),size(Y,2)) :: Z
  type(matrix), dimension(size(Y,1),size(Y,2)) :: X

  X(:,:)%elem = Y(:,:)%elem + Z(:,:)%elem
end function matrix_add

function vector_add(Y, Z) result(X)
  ! add 1D arrays of type matrix
  type(matrix), intent(in), dimension(:) :: Y
  type(matrix), intent(in), dimension(size(Y,1)) :: Z
  type(matrix), dimension(size(Y,1)) :: X

  X(:)%elem = Y(:)%elem + Z(:)%elem
end function vector_add

  !
  ! SUBTRACTION OPERATORS: X = Y - Z
  !

function matrix_sub(Y, Z) result(X)
  ! subtract 2D arrays of type matrix
  type(matrix), intent(in), dimension(:,:) :: Y
  type(matrix), intent(in), dimension(size(Y,1),size(Y,2)) :: Z
  type(matrix), dimension(size(Y,1),size(Y,2)) :: X

  X(:,:)%elem = Y(:,:)%elem - Z(:,:)%elem
end function matrix_sub

function vector_sub(Y, Z) result(X)
  ! subtract 1D arrays of type matrix
  type(matrix), intent(in), dimension(:) :: Y
  type(matrix), intent(in), dimension(size(Y,1)) :: Z
  type(matrix), dimension(size(Y,1)) :: X

  X(:)%elem = Y(:)%elem - Z(:)%elem
end function vector_sub



end module linear_algebra_ops
