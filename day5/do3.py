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

#print(ranges)
#print(len(ranges))

# idea:
# two optimation passes:
# pass1:
# look if first range in ranges is fully contained in any other range.
# if so: build a new list without the range
# otherwise:  move the range to the last item. this is needed to make recursion work
# do pass1 until no more reductions are possible
# pass2:
# look if first range is partially contained in any other range.
# if so: build a new list with appends the new bigger range.
# otherwise: move range to the last item. this is needed to make recursion work
# do pass1 and pass2 until no more reductions are possible!
# this gives optimal ranges without sorting beforehand

def is_inside(a, b):
    fr, to = a
    fr_, to_ = b
    return (fr >= fr_ and to <= to_)

def pass1():
    a = ranges.pop(0)
    for b in ranges:
        if is_inside(a, b):
            return
    ranges.append(a)

def pass2():
    fr, to = ranges.pop(0)
    #    44
    #2 3 4 5 6 7 8
    #2 3 4 
    #    4 5 6 7
    #          7 8
    for fr_, to_ in ranges:
        old1 = [fr, to]
        old2 = [fr_, to_]
        new = None
        if fr < fr_ and to >= fr_:
            new = [fr, to_]
        elif fr <= to_ and to > to_:
            new = [fr_, to]
        if new:
            # check if new range contains both ranges
            assert(is_inside(old1, new))
            assert(is_inside(old2, new))
            ranges.append(new)
            return
    ranges.append([fr, to])

for _ in range(len(ranges)*2):
    pass2()
    for i in range(len(ranges)):
        pass1()
    #print(len(ranges))

res = 0
for fr, to in ranges:
    res += to - fr + 1
print(res)

