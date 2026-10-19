def count_key_occurrences(records, key):
    result=dict()
    for dic in records:
      if key not in dic.keys():
         continue
      else:
          try:
            result[dic[key]]+=1
          except KeyError:
            result[dic[key]]=1
    return result
