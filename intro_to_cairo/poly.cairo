

func main():
    [ap] = 100; ap++
    [ap] = [ap - 1] * [ap - 1] * [ap - 1]; ap++
    [ap] = [ap - 2] * [ap - 2] * 23; ap++
    [ap] = [ap - 3] * 45; ap++
    [ap] = 67; ap++
    [ap] = [ap - 4] + [ap - 3] + [ap - 2] + [ap - 1]; ap++
    ret
end