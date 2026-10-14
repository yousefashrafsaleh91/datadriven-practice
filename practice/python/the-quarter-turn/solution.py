def rotate_90_clockwise(matrix: list) -> list:
  y=len(matrix)
  res=[]
  ind=0
  for x in range(y):
    sub=[]
    for x in reversed(matrix):
      sub.append(x[ind])
    ind+=1
    res.append(sub)
  return res
