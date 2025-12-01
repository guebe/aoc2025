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
    x = (x + r) % 100
    #print(x)
    if x == 0:
        res += 1

print(res)



