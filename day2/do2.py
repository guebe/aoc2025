import itertools

lines = list()

for line in [line.strip() for line in open(0).readlines()]:
    ranges = line.split(',')
    for r in ranges:
        nums = r.split('-')
        assert(len(nums) == 2)
        lines.append((int(nums[0]),int(nums[1])))

#print(lines)

res = 0
inv = set()

for start,end in lines:
    for id_ in range(start,end+1):
        ids = str(id_)
        #print(ids)

        for n in range(1, len(ids)//2+1):
            rest = len(ids) % n
            if (rest != 0):
                continue

            split = [(ids[i:i+n]) for i in range(0, len(ids), n)]

            #print(split)

            if all(x == split[0] for x in split):
                print(split)
                print(id_)
                inv.add(id_)

for id_ in inv:
    res += id_
print(res)
