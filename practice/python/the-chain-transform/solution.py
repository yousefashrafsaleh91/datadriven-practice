def word_ladder_length(begin_word: str, end_word: str, word_list: list) -> int:
  from collections import deque
  WordSet=set(word_list)
  if not  (end_word in word_list):
    return 0
  queue=deque([(begin_word,1)])
  
  while queue:
    current_word,level=queue.popleft()
    
    if current_word == end_word:
      return level
    
    
    
    for i in range(len(current_word)):
      for char_code in range(97,123):
        next_word=current_word[:i]+chr(char_code)+current_word[i+1:]
        if(next_word in WordSet):
          WordSet.remove(next_word)
          queue.append([next_word,level+1])
  return 0
