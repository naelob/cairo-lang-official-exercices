%builtins output pedersen

from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.cairo.common.hash import hash2

func main{output_ptr, pedersen_ptr : HashBuiltin*}():
    alloc_locals
    let (_, res_1) = hash_func_v1(cast(pedersen_ptr, felt), 2, 4, 18)
    let (res_2) = hash_func_v2{hash_ptr=pedersen_ptr}(2, 4, 18)

    assert [output_ptr] = res_1
    assert [output_ptr + 1] = res_2

    let output_ptr = output_ptr + 2

    return ()
end

func hash_func_v1(hash_ptr, x, y, z) -> (hash_ptr, w):
    let u = z
    x = [hash_ptr]
    y = [hash_ptr + 1]
    z = [hash_ptr + 2]
    hash_ptr = hash_ptr + 3
    z = [hash_ptr]
    u = [hash_ptr + 1]

    return (hash_ptr=hash_ptr + HashBuiltin.SIZE, w=[hash_ptr + 2])
end

func hash_func_v2{hash_ptr : HashBuiltin*}(x : felt, y : felt, z : felt ) -> (res : felt):
    let (u) = hash2(x,y)
    let (r) = hash2(u,z)
    return (res = r)
end