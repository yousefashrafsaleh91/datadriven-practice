def run_length_encoding(s: str):
  from itertools import groupby
  if not s:
    return ''
  appears=[]
  for char,group in groupby(s):
    appears.extend([char,str(len(list(group)))])  
  return ''.join(appears)
