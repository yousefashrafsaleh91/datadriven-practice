from datetime import datetime
def sort_dates(dates: list[str]) -> list[str]:
  SortedDates=sorted(dates,key=lambda d:str(datetime.strptime(d, "%Y-%m-%d")))
  return SortedDates
