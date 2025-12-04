import itertools
import re

lines = list()

for line in [line.strip() for line in open(0).readlines()]:
    x = list(line)
    lines.append(x)


for l in lines:
    assert(len(l) == len(lines[0]))


grid = lines

directions=[(-1,-1), (-1,0), (-1,1),
            (0, -1), (0, 1),
            (1, -1), (1, 0), (1, 1)]

assert(len(directions) == 8)


def is_roll(h,w):
    if w >= 0 and h >= 0 and w < len(grid[0]) and h < len(grid):
        if grid[h][w] == '@':
            return True
    return False

def count_remove():
    rolls = set()
    for h in range(len(grid)):
        for w in range(len(grid[0])):
            if grid[h][w] == '@':
                #print(f"processing [{h}][{w}]")
                c = 0
                for dh,dw in directions:
                    h_ = h + dh
                    w_ = w + dw
                    if (is_roll(h_,w_)):
                        c += 1
                        #print(f"found {c} roll at [{h_}][{w_}]")
                if c < 4:
                    #print(f"taking [{h}][{w}]")
                    rolls.add((h,w))
    for h,w in rolls:
        grid[h][w] = 'x'
    return len(rolls)

res = 0

while True:
    x = count_remove()
    print(x)
    res += x
    if x == 0:
        break
print(res)
