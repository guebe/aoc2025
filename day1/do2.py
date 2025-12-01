rots = list()

for line in [line.strip() for line in open(0).readlines()]:
    d = line[0]
    n = int(line[1:])
    if (d == 'L'):
        n = -n
    rots.append(n)

#print(rots)

x = 50
res = 0

for r in rots:
    x_ = x
    x__ = x + r
    x = (x + r) % 100
    #print(r)
    #assert(r < 100)
    #print(x)
    if x__ <= 0:
        res = res + (-x__ // 100)
        if x_ != 0:
            res += 1
    elif x__ >= 100:
        res = res + (x__ // 100)

print(res)



