%builtins output pedersen

from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.cairo.common.hash import hash2
from starkware.cairo.common.alloc import alloc

func main{output_ptr, pedersen_ptr : HashBuiltin*}():
    alloc_locals
    #let (_, res_1) = hash_func_v1(cast(pedersen_ptr, felt), 2, 4, 18)
    let (res_2) = hash_func_v2{hash_ptr=pedersen_ptr}(2, 4, 18)

    #assert [output_ptr] = res_1
    #assert [output_ptr + 1] = res_2
    assert [output_ptr] = res_2
    let output_ptr = output_ptr + 1
    #let output_ptr = output_ptr + 2

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

func hash_array{hash_ptr : HashBuiltin*}(items_len : felt, items : felt*) -> (res : felt):
    alloc_locals
    if items_len == 1:
        return (res = [items])
    end

    tempvar x = [items]
    tempvar y = [items + 1]
    tempvar z = [items + 2]
    let (hashed) = hash_func_v2(x,y,z)

    # call hash_array recursively by appending at the start hashed value
    let (local new_array) = alloc()
    assert [new_array] = hashed
    new_array = new_array + 1
    new_array = items + 3

    return hash_array(items_len = items_len - 2,items=new_array)
   # jmp hash_body if items_len != 0
   # [ap] = 
   #ret

   # hash_body:
   # [ap] = [items]; ap++
   # [ap] = [items + 1]; ap++
   # [ap] = [items + 2]; ap++
   # call hash_func_v2

   # [ap] = items_len - 3; ap++
   # [ap] = items + 3; ap++
   # call hash_array
   # ret
end