def make_change_greedy(amount: int, coins: list) -> int:
  SortedCoins=sorted(coins,reverse=True)
  cnt=0
  for x in SortedCoins:

    if x <= amount:
      z=int(amount/x)
      cnt+=z
      amount=amount-(z*x)
  return cnt if amount==0 else -1
