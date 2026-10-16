def the_missing_number(nums: list[int], n: int):
  for x in nums:
    if x <=n:
      n+=1
    else:
      break
  return n
