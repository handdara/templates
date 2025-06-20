program main
    ! This is a comment line; it is ignored by the compiler
    integer, dimension(100) :: xs
    integer :: a, b, c, d

    print *, 'First bound...'
    read *, a
    print *, 'Second bound...'
    read *, b

    c = max(  1, min(a,b))
    d = min(100, max(a,b))

    init_lp: do idx = 1,100
    xs(idx) = idx
    end do init_lp

    rev_lp: do idx = 0, (d-c)/2
    a = xs(c+idx)
    xs(c+idx) = xs(d-idx)
    xs(d-idx) = a
    end do rev_lp

    call output
contains
    subroutine output
        print_lp: do idx = 1,100
        print *, xs(idx)
        end do print_lp
    end subroutine output
end program main
