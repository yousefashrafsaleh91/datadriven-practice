def flatten_the_nest(items: list):
  flattened=[]
  for x in items:
    if type(x) !=list:
      flattened.append(x)
    else:
      flattened.extend(flatten_the_nest(x))
        
  return flattened
