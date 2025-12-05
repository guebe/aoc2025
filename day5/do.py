import itertools
import re

ranges = list()
ingridients = list()

state = 0
for line in [line.strip() for line in open(0).readlines()]:
    
    if (line == ""):
        state = 1
    elif (state == 0):
        ranges.append([int(x) for x in line.split('-')])
    else:
        ingridients.append(int(line))

print(ranges)
print(ingridients)

res = 0

for ing in ingridients:
    print(f"{ing}")
    for fr, to in ranges:
        if ing in range(fr, to+1):
            print("fresh")
            res += 1
            break

print(res)
