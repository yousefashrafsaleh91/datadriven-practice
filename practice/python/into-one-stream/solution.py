def flatten_the_nest(items: list):
  result=[]
  for item in items:
    if isinstance(item, list):
        result.extend(flatten_the_nest(item))
    else:
        result.append(item)   
  return result
