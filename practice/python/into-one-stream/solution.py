def flatten_the_nest(items: list):
  flattened=[]
  for x in items:
    if type(x) !=list:
      flattened.append(x)
    else:
      for y in x:
        flattened.append(y)
        
  return flattened
