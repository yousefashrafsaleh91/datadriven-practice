def remove_kth_from_end(lst: list, k: int) -> list:
  ind=len(lst)-k
  result=[]
  for x in range(len(lst)):
    if x==ind:
      continue
    
    result.append(lst[x])
    
  return result
