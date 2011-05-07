!  @(#) Example of overloading operators in Fortran
!
!  The following MODULE  allows for using the syntax
!     L1 == L2
!  where L1 and L2 are LOGICAL 
!  as an alternative to 
!     L1 .EQV. L2
!  (or the function call
!     BOOLEAN_EQUAL (L1, L2)) 
!  or
!     L1 .BOOLEAN_EQUAL. L2
!  for that matter); and likewise allows
!     L1 /= L2
!  as equivalent to
!     L1 .neqv. L2
! 
! This is a simplistic example. Two significant real-world examples of
! operator overloading to look for use operator overloading to provide
! modules that allow many existing Fortran routines to be used with almost
! no source file changes to produce versions using arbitrary precision
! arithmetic, or to provide cumulative error bounds on floating-point
! calculations.
!
! THOSE features would make interesting additions to the Fortran standard.
!
! The other purpose of this example is to point out that 
!    L1 == L2   !! should be L1 .eqv. L2
! and 
!    L1 /= L2   !! should be L1 .neqv. L2
! should NOT work by default; but often do (probably because the compiler
! silently converts LOGICAL to INTEGER when a LOGICAL appears where a
! numeric value is required?). If you can comment out the USE statement
! below and still run this example, your compiler supports this 
! non-standard (but intuitive-looking) syntax. Using it makes your code
! much less portable. 
!
!-----------------------------------------------------
MODULE logical_ops
!-----------------------------------------------------
   INTERFACE OPERATOR ( == )
      MODULE PROCEDURE boolean_equal
   END INTERFACE OPERATOR ( == )
!-----------------------------------------------------
   INTERFACE OPERATOR ( /= )
      MODULE PROCEDURE boolean_notequal
   END INTERFACE OPERATOR ( /= )
!-----------------------------------------------------
CONTAINS
!-----------------------------------------------------
LOGICAL FUNCTION boolean_equal(logical_val1,logical_val2)
   IMPLICIT NONE
   LOGICAL, INTENT (IN) :: logical_val1 
   LOGICAL, INTENT (IN) :: logical_val2 

   IF (logical_val1 .EQV. logical_val2 )THEN
     boolean_equal=.TRUE.
   ELSE
     boolean_equal=.FALSE.
   ENDIF

END FUNCTION boolean_equal
!-----------------------------------------------------
LOGICAL FUNCTION boolean_notequal(logical_val1,logical_val2)
   IMPLICIT NONE
   LOGICAL, INTENT (IN) :: logical_val1 
   LOGICAL, INTENT (IN) :: logical_val2 

   IF (logical_val1 .EQV. logical_val2 )THEN
     boolean_notequal=.FALSE.
   ELSE
     boolean_notequal=.TRUE.
   ENDIF

END FUNCTION boolean_notequal
!-----------------------------------------------------
END MODULE logical_ops
!-----------------------------------------------------

