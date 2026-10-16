def make_change_greedy(amount: int, coins: list) -> int:
  SortedCoins=sorted(coins,reverse=True)
  cnt=0
  for x in SortedCoins:
    if amount==0:
      return cnt
    if x <= amount:
      z=int(amount/x)
      cnt+=z
      amount=amount-(z*x)
  if amount==0: return cnt
  else: return -1
