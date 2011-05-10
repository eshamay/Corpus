module md_math_module
implicit none

contains
  
  ! returns a minimum image vector pointing from position 1 to position 2
  ! by wrapping the calculated result into a periodic cell
  function md_MinimumVector (position_1, position_2, pbc) result (minvec)
    real*8, dimension(3) :: position_1, position_2, pbc, minvec

    position_1(:) = mod(position_1(:),pbc(:))
    position_2(:) = mod(position_2(:),pbc(:))
    minvec(:) = position_2(:) - position_1(:)
    minvec(:) = minvec(:) - nint(minvec(:)/pbc(:)) * pbc(:)
  end function md_MinimumVector

  function md_VectorNorm (vec) result (norm)
    real*8, dimension(:) :: vec
    real*8 :: norm

    vec = vec * vec
    norm = sum(vec)
    norm = sqrt(norm)
  end function md_VectorNorm

end module md_math_module
