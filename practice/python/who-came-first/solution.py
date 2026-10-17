def unique_in_order(items):
  checker=dict()
  result=[]
  for x in items:
    flag=checker.get(x,False)
    if flag:
      continue
    else:
      result.append(x)
      checker[x]=True
      
  return result
