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
print(len(ranges))

res = 0
fresh = set()

#i = 0
#for fr, to in ranges:
#    print(i)
#    i+=1
#    for ing in range(fr, to+1):
#        fresh.add(ing)

ranges.sort()
print(ranges)
fresh = list()
fresh.append(ranges[0])

# fresh
#    3 5
# input
# 3 4 inside
# 4 10 extend
# 7 10 new
#
# next 

for fr, to in ranges:

    fr1, to1 = fresh[-1]

    assert(fr >= fr1)

    if fr <= to1:
        fresh[-1] = [fr1, max(to, to1)]
    else:
        fresh.append([fr, to])

for fr, to in fresh:
    res += to - fr + 1

print(len(fresh))
print(fresh)
print(res)
