import sys

dosfile = sys.argv[1]
f = open(dosfile,'r')
lines = f.readlines()
f.close()

E = []
pdossumup = []
pdossumdw = []
dE = float(lines[2].split()[0])-float(lines[1].split()[0])
U,D = 0,0
for line in lines[1:]:
    e,u,d = line.split()
    e,u,d = float(e),float(u),float(d)
    U += u*dE
    D += d*dE
    E.append(e)
    pdossumup.append(U)
    pdossumdw.append(D)

f = open(dosfile+'.integral','w')
for e,u,d in zip(E,pdossumup,pdossumdw):
    f.write(" %.6f  %.10e  %.10e \n"%(e,u,d))
f.close()
