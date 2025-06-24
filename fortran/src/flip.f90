module flip
    implicit none
contains
    subroutine flip_subinterval (a, b, array)
        integer :: a, b, narray
        integer :: c, d, tmp, idx
        integer, dimension(:) :: array
        c = max(  1, min(a,b))
        d = min(size(array), max(a,b))
        do idx = 0, (d-c)/2
            tmp = array(c+idx)
            array(c+idx) = array(d-idx)
            array(d-idx) = tmp
        end do
    end subroutine flip_subinterval
end module flip
