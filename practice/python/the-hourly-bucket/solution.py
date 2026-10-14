def group_by_hour(events):
  from collections import defaultdict
  from typing import List, Dict, Any
  buckets:Dict[str,List[str]]=defaultdict(list)
  for event in events:
        hour = event["ts"][:13]  # YYYY-MM-DDTHH
        buckets[hour].append(event["type"])
  return dict(buckets)
