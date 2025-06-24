program main
    use flip, only: flip_subinterval

    ! This is a comment line; it is ignored by the compiler
    integer, parameter :: N = 100
    integer, dimension(N) :: xs
    integer :: a, b, c, d

    print *, 'First bound...'
    read *, a
    print *, 'Second bound...'
    read *, b

    init_lp: do idx = 1,100
    xs(idx) = idx
    end do init_lp

    call flip_subinterval (a, b, xs)

    call output
contains
    subroutine output
        print_lp: do idx = 1,100
        print *, xs(idx)
        end do print_lp
    end subroutine output
end program main
