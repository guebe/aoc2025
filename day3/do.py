import itertools
import re

lines = list()

for line in [line.strip() for line in open(0).readlines()]:
    x = [int(x) for x in line]
    lines.append(x)

print(lines)

res = 0

for line in lines:
    m = max(line[:-1])
    i = line.index(m)
    n = max(line[i+1:])
    print(f"{m}{n}")
    res += m*10+n

print(res)
