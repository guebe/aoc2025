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

for start,end in lines:
    for id_ in range(start,end+1):
        ids = str(id_)
        #print(ids)
        if ((len(ids) % 2) == 0):
            half = len(ids) // 2
            first = ids[:half]
            second = ids[half:]
            #print(f"{first} {second}")
            if first == second:
                # wrong id
                res += id_

print(res)
