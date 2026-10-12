def string_to_number_mapping(s: str) -> dict:
  d={}
  cnt=0
  for x in s:
    if(x not in d.keys()):
      d[x]=cnt
    cnt+=1
  return d
