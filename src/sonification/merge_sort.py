def recursion(unsorted: list[int], cb) -> list[int]:
    if len(unsorted) < 2:
        return unsorted
    mid = len(unsorted) // 2
    left = recursion(unsorted[0:mid], cb)
    right = recursion(unsorted[mid:], cb)

    cb(left[0])
    cb(right[0])
    cb(right[-1])

    merged = []
    li = 0
    ri = 0
    while li < len(left) and ri < len(right):
        if left[li] < right[ri]:
            merged.append(left[li])
            li += 1
        else:
            merged.append(right[ri])
            ri += 1

    while li < len(left):
        merged.append(left[li])
        li += 1
    while ri < len(right):
        merged.append(right[ri])
        ri += 1

    return merged
