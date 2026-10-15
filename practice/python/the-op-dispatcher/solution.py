def apply_transform(records, op_name):
  for x in records:
    if op_name=='double':
      x['result']=x['value']*2
    elif op_name=='square':
      x['result']=x['value']*x['value']
    elif op_name=='abs':
      x['result']=abs(x['value'])
    elif op_name=='upper':
      x['result']=x['value'].upper()
    else:
      x['result']=x['value'].lower()
  return records
