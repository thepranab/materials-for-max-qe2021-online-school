from sys import argv
#
try:
    input = argv[1]
except IndexError:
    print ("please provide as argument the file with the summed pdos: \n")
    print ("e.g.:  integral.py  foo.dat \n")
    raise SystemExit 
#
with open(input, 'r') as f:
    next(f)
    data = [(float(x) for x in l.split()) for l in iter(f)]
e = [next(_) for _ in data]
de = [_[1]-_[0] for _ in zip(e[:-1],e[1:])]
dup = [next(_[0])*_[1] for _ in zip(data[1:],de)]
ddw = [next(_[0])*_[1] for _ in zip(data[1:],de)]
#
def writesums(a,f):
    i = iter(a)
    si=0.0
    sj=0.0
    a_=(0.,0.,0.)
    while i:
        try:
            a_ = next(i)
        except StopIteration:
            break
        f.write(f"{a_[0]:6.3f}   {si:.8e}  {sj:.8e}  {si-sj:.8e}\n") 
        yield None 
        si += a_[1]
        sj += a_[2]
#        
from collections import deque
with open(f"{input}.int",'w') as f:
    deque(writesums(zip(e,dup,ddw),f),maxlen=0)