from datetime import datetime
def sort_dates(dates: list[str]) -> list[str]:
  SortedDates=[]
  for x in dates:
    year,month,day=int(x.split('-')[0]),int(x.split('-')[1]),int(x.split('-')[2])
    SortedDates.append(str(datetime(year,month,day).date()))
  SortedDates=sorted(SortedDates)    
  return SortedDates
