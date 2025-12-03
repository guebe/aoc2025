import itertools
import re

lines = list()

for line in [line.strip() for line in open(0).readlines()]:
    x = [int(x) for x in line]
    lines.append(x)

#print(lines)

res = 0

#>>> list(range(-11,1))
#[-11, -10, -9, -8, -7, -6, -5, -4, -3, -2, -1, 0]

for line in lines:
    i = 0
    batteries = list()
    for j in range(-11,1):
        #print(f"{line[i:j]}")
        if j != 0:
            sub = line[i:j]
            m = max(sub)
        else:
            sub = line[i:]
            m = max(sub)
        i = i + sub.index(m) + 1
        #i = line.index(m) + 1
        #print(f"{m}")
        batteries.append(m)

    #print(batteries)
    x = ''.join([str(x) for x in batteries])
    print(f"{x}")
    res += int(x)

print(res)
