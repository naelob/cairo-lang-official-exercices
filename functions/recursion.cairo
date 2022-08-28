func main():
    #call exp(2,7)
    [ap] = 2; ap++
    [ap] = 7; ap++
    call exp

    [ap - 1] = 128
    ret
end

func exp(x,n) -> (res : felt):
    jmp exp_body if n != 0
    [ap] = 1; ap++
    ret

    exp_body:   
    [ap] = x; ap++
    [ap] = n - 1; ap++
    call exp
    [ap] = [ap - 1] * x; ap++
    ret
end