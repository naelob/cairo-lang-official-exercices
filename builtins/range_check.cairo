%builtins output pedersen

from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.cairo.common.hash import hash2
from starkware.cairo.common.alloc import alloc


func foo{range_check_ptr}(x : felt):
    [range_check_ptr] = x
    assert [range_check_ptr + 1] = 1000 - x

    return ()
end

func foo2{range_check_ptr}(x, y, z, w): 
    # make sure all 4 numbers are < 2**128
    [range_check_ptr] = x
    [range_check_ptr + 1] = y
    [range_check_ptr + 2] = z
    [range_check_ptr + 3] = w
    let range_check_ptr = range_check_ptr + 4
    # make sure z <= w
    assert [range_check_ptr] = [range_check_ptr - 1] - [range_check_ptr - 2]
    # make sure y <= z
    assert [range_check_ptr + 1] = [range_check_ptr - 2] - [range_check_ptr - 3]
    # make sure x <= y
    assert [range_check_ptr + 2] = [range_check_ptr - 3] - [range_check_ptr - 4]
    
    let range_check_ptr = range_check_ptr + 3

    return ()
end