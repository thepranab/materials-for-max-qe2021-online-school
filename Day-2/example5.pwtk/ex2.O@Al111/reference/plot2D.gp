set samples 50
set isosamples 50
set contour
set pm3d interpolate 10,10 map
set palette file "-"
0 0 0.5
0.5 0.5 1
1 1 1
1 0.5 0.5
0.5 0 0
end

ev=13.605691930242388; # Ry

set title "{/Symbol D} Energy (eV)"
set xlabel "A (alat)"
set ylabel "B (alat)"
set clabel "%5.2f"
set cbtics -4,0.5,0.0
set cbrange [-4:0.0]
set contour base
set cntrparam  cubicspline levels incremental -4,0.5,0.0
set format "%.1f"
set xrange [-0.5:1.0]
set yrange [0.0:sqrt(3)/2]

set xtics -0.5, 0.1
set ytics 0.0, 0.1
set size 1.0, 0.8
splot 'energies.dat' u 1:2:(($3+110.73614280)*ev) notitle with pm3d lt 1 lw 2
pause -1
