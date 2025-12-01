import itertools

lines = list()

for line in [line.strip() for line in open(0).readlines()]:
    x = line.split(' ')
    a = int(x[2][0:-1])
    b = int(x[4][0:-1])
    c = int(x[6][0:-1])
    d = int(x[8][0:-1])
    e = int(x[10])
    lines.append((a,b,c,d,e))

print(lines)

res = 0

for line in lines:
    pass

print(res)
