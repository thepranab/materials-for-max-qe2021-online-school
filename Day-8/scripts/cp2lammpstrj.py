#!/usr/bin/python3
# coding=utf-8

import numpy as np
import argparse

BOHR = 0.529177249    # Bohr constant in Angstrom
TAU  = 0.5*4.8378e-5  # tau_CP constant in ps
HARTREE = 27.211383860484776  # Hartree (a.u.) in eV
RYDBERG = HARTREE / 2.0

# NOTICE: CP cells in output are transposed -- this program takes care of that

#########################################################################
########### QUESTA FUNZIONE SEMBRA SBAGLIATA / DARE DEGLI ANGOLI CHE SALTANO DURANTE LA DINAMICA ################################################################################
def cellmatrix_to_cellpar(cell, radians=False):
    """Returns the cell parameters [a, b, c, alpha, beta, gamma].

    Angles are in degrees unless radian=True is used.
    """
    lengths = np.linalg.norm(cell, axis=1)
    angles = []
    for i in range(3):
        j = i - 1
        k = i - 2
        ll = lengths[j] * lengths[k]
        if ll > 1e-16:
            x = np.dot(cell[j], cell[k]) / ll
            angle = 180.0 / np.pi * np.arccos(x)
        else:
            angle = 90.0
        angles.append(angle)
    if radians:
        angles = [angle * np.pi / 180 for angle in angles]
    return np.concatenate((lengths, angles))

def read_file_pos_vel(prefix, natoms, nstep=None, cell=None, method='full'):
    """
    Legge i file di output di quantum espresso (cartella dove sono posizionati i vari restart)
    Per esempio, se il prefisso è KCl-512:
    namepos è KCl-512.pos
    namevel è KCl-512.vel
    nstep è il numero di timestep da leggere (NON è determinato automaticamente!)
    natoms è il numero di atomi nella simulazione (NON è determinato automaticamente!)
    
    ritorna una lista, una per ogni timestep, con il contenuto:
        [timestep,tempo]       [ posizioni ]               [velocità]
    dove [timestep,tempo] è una coppia di numeri, posizioni è un array numpy con le posizioni,
    e velocità è un array numpy

    Trasforma pos in A, vel in A/ps, energy in eV, pressure in GPa
    """

    def file_length( filename ):
      i = -1
      blank = 0
      with open(filename) as f:
        for i, l in enumerate(f,1):
          if len(l) == 1:
            blank += 1
          pass
      return i - blank

    if nstep is None:
       # check if first line of evp file is text
       try:
          np.array(open(prefix + '.evp').readline().split(), dtype=float)
       except ValueError:
          nstep = file_length(prefix + '.evp') - 1
       else:
          nstep = file_length(prefix + '.evp')
       print("nstep = ", nstep)

    data = {}
    if cell is None:
        readcell = True
        data['cell'] = np.zeros((nstep,3,3), dtype=np.float64)
        print("CELL: Reading {}.cel".format(prefix))
    else:
        readcell = False
        data['cell'] = np.array([np.identity(3)]*nstep, dtype=np.float64) * cell
        print("CELL: Using cubic cell size: {:f}".format(cell))

    if (method == 'minimal'):
      data['step']  = np.arange(nstep, dtype=np.int64)
      data['pos']  = np.zeros((nstep,natoms,3), dtype=np.float64)
      data['vel']  = np.zeros((nstep,natoms,3), dtype=np.float64)
      filepos = open(prefix + '.pos')
      filevel = open(prefix + '.vel')
      filecel = open(prefix + '.cel')
      istep = 0
      while (istep < nstep):
          linepos = filepos.readline()
          linevel = filevel.readline()
          if readcell:
              linecel = filecel.readline()
          if ((len(linepos)==0) or (len(linevel)==0)):  # EOF
              raise RuntimeError("End Of file")

          # lettura posizioni
          values = np.array(linepos.split())
          #print linepos
          #print values, data['step'][istep]
          if len(values):
              for iatom in range(natoms):
                  linepos = filepos.readline()
                  values = np.array(linepos.split(), dtype=np.float64)
                  if (values.size == 3):
                    data['pos'][istep,iatom,:] = values[:] * BOHR
                  else:
                    data['pos'][istep,iatom,:] = values[1:4] * BOHR
              
          #lettura velocità
          values = np.array(linevel.split())
          #print values,data[0][istep]
          if len(values):
              for iatom in range(natoms):
                  linevel = filevel.readline()
                  values = np.array(linevel.split(), dtype=np.float64)
                  if values.size == 3:
                    data['vel'][istep,iatom,:] = values[:] * BOHR / TAU
                  else:
                    data['vel'][istep,iatom,:] = values[1:4] * BOHR / TAU

          if readcell:
              #lettura cella
              values = np.array(linecel.split())
              #print values, data['step'][istep]
              if len(values):
                  for i in range(3):
                      values = np.array(filecel.readline().split(), dtype=np.float64)
                      data['cell'][istep,:,i] = values * BOHR # MATRIX MUST BE TRANSPOSED (stupid CP convention)

          istep += 1

    elif (method == 'full'):
      data['step']  = np.zeros(nstep, dtype=np.int64)
      data['time']  = np.zeros(nstep, dtype=np.float64)
      data['ekinc'] = np.zeros(nstep, dtype=np.float64)
      data['Tcell'] = np.zeros(nstep, dtype=np.float64)
      data['Tion']  = np.zeros(nstep, dtype=np.float64)
      data['etot'] = np.zeros(nstep, dtype=np.float64)
      data['enthal'] = np.zeros(nstep, dtype=np.float64)
      data['econs'] = np.zeros(nstep, dtype=np.float64)
      data['econt'] = np.zeros(nstep, dtype=np.float64)
      data['volume'] = np.zeros(nstep, dtype=np.float64)
      data['pressure'] = np.zeros(nstep, dtype=np.float64)
      data['pos']  = np.zeros((nstep,natoms,3), dtype=np.float64)
      data['vel']  = np.zeros((nstep,natoms,3), dtype=np.float64)
      data['for']  = np.zeros((nstep,natoms,3), dtype=np.float64)
      print('WARNING: forces units not converted.')

      filethe = open(prefix + '.evp')
      # check if first line is text - in that case skip it
      try:
         np.array(filethe.readline().split(), dtype=float)
      except ValueError:
         pass
      else:
         filethe.seek(0)
      filepos = open(prefix + '.pos')
      filevel = open(prefix + '.vel')
      filecel = open(prefix + '.cel')
      filefor = open(prefix + '.for')
      istep = 0
      while (istep < nstep):
          linethe = filethe.readline()
          linepos = filepos.readline()
          linevel = filevel.readline()
          linefor = filefor.readline()
          if readcell:
              linecel = filecel.readline()
          if (len(linethe)==0) or (len(linepos)==0) or (len(linevel)==0) or (len(linecel)==0) or (len(linefor)==0):  # EOF
              raise RuntimeError("End Of file")

          # lettura thermo
          values = np.array(linethe.split(), dtype=np.float64())
          #print 'thermo', values
          if len(values):
              #print istep, values[0], len(data['step'])
              data['step'][istep]  = values[0]
              data['time'][istep]  = values[1]
              data['ekinc'][istep] = values[2] * HARTREE
              data['Tcell'][istep] = values[3]
              data['Tion'][istep]  = values[4]
              data['etot'][istep] = values[5] * HARTREE
              data['enthal'][istep] = values[6] * HARTREE
              data['econs'][istep] = values[7] * HARTREE
              data['econt'][istep] = values[8] * HARTREE
              data['volume'][istep] = values[9] * BOHR**3
              data['pressure'][istep] = values[10]
          else:
              istep -= 1

          # lettura posizioni
          values = np.array(linepos.split())
          #print linepos
          #print values, data['step'][istep]
          if len(values):
              if (data['step'][istep] != int(values[0]) ):
                  raise RuntimeError("Different timesteps between files of positions and thermo")
              for iatom in range(natoms):
                  linepos = filepos.readline()
                  values = np.array(linepos.split(), dtype=np.float64)
                  data['pos'][istep,iatom,:] = values[:] * BOHR
              
          #lettura velocità
          values = np.array(linevel.split())
          #print values,data[0][istep]
          if len(values):
              if (data['step'][istep] != int(values[0]) ):
                  raise RuntimeError("Different timesteps between files of velocity and thermo")
              for iatom in range(natoms):
                  linevel = filevel.readline()
                  values = np.array(linevel.split(), dtype=np.float64)
                  data['vel'][istep,iatom,:] = values[:] * BOHR / TAU

          # lettura forze
          values = np.array(linefor.split())
          #print linepos
          #print values, data['step'][istep]
          if len(values):
              if (data['step'][istep] != int(values[0]) ):
                  raise RuntimeError("Different timesteps between files of force and thermo")
              for iatom in range(natoms):
                  linefor = filefor.readline()
                  values = np.array(linefor.split(), dtype=np.float64)
                  data['for'][istep,iatom,:] = values[:]
          
          if readcell:
              #lettura cella
              values = np.array(linecel.split())
              #print values, data['step'][istep]
              if len(values):
                  if (data['step'][istep] != int(values[0]) ):
                      raise RuntimeError("Different timesteps between files of cell and thermo")
                  for i in range(3):
                      values = np.array(filecel.readline().split(), dtype=np.float64())
                      data['cell'][istep,:,i] = values * BOHR # MATRIX MUST BE TRANSPOSED (stupid CP convention)

          istep += 1

    return data

#def wrap_cubic_timestep(positions,l_cube,cellAxis,natoms):
#    position_extended=np.array
#    for iatom in range(natoms):
#        for icoord in range(3)
#        if positions[iatom,icoord]<0 or positions[iatom,icoord]>

def write_lammpstrj(outfile, data, natoms_per_type, type_names=None, cp_ordered=True):
    """
    Scrive un file nel formato lammpstrj (facilmente leggibile da vmd).
    cp.x nell'output separa gli atomi per tipi. Questa funzione assume che la prima metà sono di tipo "1"
    e la seconda metà di tipo "2".
    outfile è il nome del file da scrivere.
    data è il risultato della chiamata a read_file_pos_vel
    l è la dimensione della cella cubica scritta nell'output. """
    
    def isDiag(M):
        i, j = np.nonzero(M)
        return np.all(i == j)
    if not all([isDiag(cel) for cel in data['cell']]):
        triclinic_cell = True
#        raise NotImplementedError('write_lammpstrj does not yet support non-orthogonal cells')
    else:
        triclinic_cell = False

    out_file = open(outfile, "w")
    #out_file.write("This Text is going to out file\nLook at it and see\n")
    nsteps = data['pos'].shape[0]
    natoms = data['pos'].shape[1]
    if (cp_ordered and natoms != sum(natoms_per_type)):
        raise ValueError('Sum of number of atoms per type does not match the total number of atoms.')
    if type_names is None:
        if cp_ordered:
            type_names = list(map(str, np.arange(1, len(natoms_per_type)+1)))
        else:
            type_names = list(map(str, np.array(natoms_per_type) +1 ))
    else:
        if (len(natoms_per_type) != len(type_names)):
            raise ValueError('Number of type_names not compatible with natoms_per_type.')
    for itimestep in range(nsteps):
        out_file.write("ITEM: TIMESTEP\n")
        out_file.write("{}\n".format(int(round(data['step'][itimestep]))))
        out_file.write("ITEM: NUMBER OF ATOMS\n")
        out_file.write("{}\n".format(natoms))
        if triclinic_cell:
            raise NotImplementedError('triclinic cells not tested yet')
            a, b, c, alpha, beta, gamma = cellmatrix_to_cellpar(data['cell'][itimestep])
            xy = b * np.cos(gamma)
            xz = c * np.cos(beta)
            yz = c * (np.cos(alpha) - np.cos(gamma) * np.cos(beta)) / np.sin(gamma)
            xlo_bound = 0.0 + min(0.0, xy, xz, xy + xz)
            xhi_bound = a + max(0.0, xy, xz, xy + xz)
            ylo_bound = 0.0 + min(0.0, yz)
            yhi_bound = b + max(0.0, yz)
            zlo_bound = 0.0
            zhi_bound = c
### WE NEED TO CHECK IF THESE NUMBERS ARE NEGATIVE!!!
            out_file.write('ITEM: BOX BOUNDS xy xz yz xx yy zz\n')
            out_file.write('{} {} {}\n'.format(xlo_bound, xhi_bound, xy))
            out_file.write('{} {} {}\n'.format(ylo_bound, yhi_bound, xz))
            out_file.write('{} {} {}\n'.format(zlo_bound, zhi_bound, yz))
        else:
            a, b, c = [data['cell'][itimestep,i,i] for i in range(3)]
            out_file.write('ITEM: BOX BOUNDS pp pp pp\n')
            out_file.write('{} {}\n'.format(0, a))
            out_file.write('{} {}\n'.format(0, b))
            out_file.write('{} {}\n'.format(0, c))
        out_file.write('ITEM: ATOMS id type x y z vx vy vz\n')
        if cp_ordered:
            cumnattype = np.cumsum(np.append(0,natoms_per_type))
            for attype, nattype in enumerate(natoms_per_type):
                firstat = cumnattype[attype]
                lastat  = cumnattype[attype+1]
                for i, idat in enumerate(range(firstat, lastat)):
                   out_file.write('{} {} {} {} {} {} {} {}\n'.format(idat+1, type_names[attype], \
                                    data['pos'][itimestep,idat,0], data['pos'][itimestep,idat,1], data['pos'][itimestep,idat,2], \
                                    data['vel'][itimestep,idat,0], data['vel'][itimestep,idat,1], data['vel'][itimestep,idat,2]))
#                np.savetxt(out_file, np.vstack((np.arange(firstat+1,lastat+1), [type_names[attype]]*nattype, \
#                                               data['pos'][itimestep,firstat:lastat,:].T, \
#                                               data['vel'][itimestep,firstat:lastat,:].T)).T, \
#                           fmt='%d %s %f %f %f %f %f %f')
        else:
            if len(natoms_per_type) != len(data['pos'][0]):
                raise ValueError('Number of atoms does not correspond to the number of atomic id')
            for idat in range(len(natoms_per_type)):
                out_file.write('{} {} {} {} {} {} {} {}\n'.format(idat+1, type_names[idat], \
                                data['pos'][itimestep,idat,0], data['pos'][itimestep,idat,1], data['pos'][itimestep,idat,2], \
                                data['vel'][itimestep,idat,0], data['vel'][itimestep,idat,1], data['vel'][itimestep,idat,2]))

    out_file.close()
    return

#def write_com_traj(outfile, data, natoms_per_type, type_names=None):
#    """
#    Scrive un file nel formato lammpstrj (facilmente leggibile da vmd).
#    cp.x nell'output separa gli atomi per tipi. Questa funzione assume che la prima metà sono di tipo "1"
#    e la seconda metà di tipo "2".
#    outfile è il nome del file da scrivere.
#    data è il risultato della chiamata a read_file_pos_vel
#    l è la dimensione della cella cubica scritta nell'output. """
#    
#    out_file = open(outfile+'.lammpstrj', "w")
#    #out_file.write("This Text is going to out file\nLook at it and see\n")
#    nsteps = data['pos'].shape[0]
#    natoms = data['pos'].shape[1]
#    if (natoms != sum(natoms_per_type)):
#        raise ValueError('Sum of number of atoms per type does not match the total number of atoms.')
#    if type_names is None:
#        type_names = map(str, np.arange(1, len(natoms_per_type)+1))
#    else:
#        if (len(natoms_per_type) != len(type_names)):
#            raise ValueError('Number of type_names not compatible with natoms_per_type.')
#    for itimestep in xrange(nsteps):
#        line = "{:d}".format(data['step'][itimestep])
#
#        cumnattype = np.cumsum(np.append(0,natoms_per_type))
#        for attype, nattype in enumerate(natoms_per_type):
#            firstat = cumnattype[attype]
#            lastat  = cumnattype[attype+1]
#            for i, idat in enumerate(xrange(firstat, lastat)):
#               out_file.write('{} {} {} {} {} {} {} {}\n'.format(idat+1, type_names[attype], \
#                                data['pos'][itimestep,idat,0],     data['pos'][itimestep,idat,1],     data['pos'][itimestep,idat,2], \
#                                data['vel'][itimestep,idat,0], data['vel'][itimestep,idat,1], data['vel'][itimestep,idat,2]))
##            np.savetxt(out_file, np.vstack((np.arange(firstat+1,lastat+1), [type_names[attype]]*nattype, \
##                                           data['pos'][itimestep,firstat:lastat,:].T, \
##                                           data['vel'][itimestep,firstat:lastat,:].T)).T, \
##                       fmt='%d %s %f %f %f %f %f %f')
#    out_file.close()
#    return

def main ():
   """This program converts a CP trajectory to a LAMMPS one."""
   parser = argparse.ArgumentParser()
   parser = argparse.ArgumentParser(description=main.__doc__, formatter_class=argparse.RawTextHelpFormatter)
   parser.add_argument('prefix', type=str, help='prefix of the files in the QE output directory.')
   parser.add_argument('-n', '--natoms', type=int, required=True, help='number of atoms')
   parser.add_argument('-N', '--nsteps', type=int, help='number of steps to read')
   parser.add_argument('-o', '--output', type=str, help='file name of the LAMMPS trajectory to write')
   parser.add_argument('-O', '--binoutput', type=str, help='file name of the binary Numpy file to write')
   parser.add_argument('-t', '--natomstype', type=int, nargs='*', help='number of atoms per type')
   parser.add_argument('-T', '--atomtypenames', type=str, nargs='*', help='list of atom type names')
   mutualexcgroup = parser.add_mutually_exclusive_group()
   mutualexcgroup.add_argument('--cell',  type=float, help='cell size in Bohr (cubic, if .cel file is not provided)')
   mutualexcgroup.add_argument('--cellA', type=float, help='cell size in Angstrom (cubic, if .cel file is not provided)')
   parser.add_argument('--minimal', action='store_true', help='just read .pos and .vel')
   parser.add_argument('--not-ordered', help='read new cp.x format that does not reorder the atoms. You need to specify an array of types in --natomstype as long as the number of atoms', action='store_true')
#   parser.add_argument('--comtraj', action='store_true', help='compute Center of Mass trajectory of each species')
   args = parser.parse_args()
   prefix = args.prefix
   natoms = args.natoms
   nsteps = args.nsteps
   outfile = args.output
   binoutfile = args.binoutput
   natomstype = args.natomstype
   atomtypenames = args.atomtypenames
   cell = None
   if args.cell is not None:
       cell = args.cell
   elif args.cellA is not None:
       cell = args.cellA / BOHR
#   comtraj = args.comtraj

   if args.minimal:
      method = 'minimal'
   else:
      method = 'full'

   data = read_file_pos_vel(prefix, natoms, nstep=nsteps, cell=cell, method=method)
   
   if outfile is not None:
     if natomstype is not None:
       print("Writing text file: ", outfile + '.lammpstrj')
       write_lammpstrj(outfile + '.lammpstrj', data, natomstype, atomtypenames, cp_ordered=not args.not_ordered )
#       if cmtraj:
#         write_com_traj(outfile+'_com', data, natomstype, atomtypenames)
     else:
       raise ValueError('You must provide the number of atoms per type -t')

   if binoutfile is not None:
     print("Writing binary file: {}.npz".format(binoutfile))
     np.savez(binoutfile, **data)

   return 0

if __name__ == "__main__":
   main()
