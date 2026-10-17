def parse_address(address):
  d={
    'street':address.split(',')[0].strip(),
    'city':address.split(',')[1].strip(),
    'state':address.split(',')[2].strip().split(' ')[0],
    'zip':address.split(',')[2].strip().split(' ')[1]
    }  
  return d
