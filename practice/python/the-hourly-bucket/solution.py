def group_by_hour(events):
  dic={}
  for x in events:
        key=x["ts"][:13]
        if key in dic.keys():
            dic[key].append(x['type'])
        else:
          dic[key]=[]
          dic[key].append(x['type'])
  return dic
