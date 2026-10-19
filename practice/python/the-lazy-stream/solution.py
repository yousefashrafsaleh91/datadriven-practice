def lazy_flatten(data: list) -> list:
  result=[]
  for x in data:
    if type(x)==list:
      for y in x:
        result.append(y)
    else:
      result.append(x)

  return result
