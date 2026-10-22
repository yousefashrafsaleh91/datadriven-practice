def run_length_encoding(s: str):
  if not s:
    return ''
  appears=[]
  app=1
  for i in range(len(s)-1):
    if(s[i]==s[i+1]):
      app+=1
    else:
      appears.append(s[i])
      appears.append(str(app))
      app=1
  appears.append(s[-1])
  appears.append(str(app))

  return ''.join(appears)
