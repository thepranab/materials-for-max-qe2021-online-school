cat << EOF > handson_day9.md
---
header-includes:
 - \usepackage{fvextra}
 - \DefineVerbatimEnvironment{Highlighting}{Verbatim}{breaklines,fontsize=\footnotesize,commandchars=\\\\\\{\}} 
---
EOF
ln -s example2.CPU/pool.png ./pool.png
cat README.md ./example0.intro/README.md ./example1.setup/README.md ./example2.CPU/README.md ./example3.GPU/README.md >> handson_day9.md

pandoc -t beamer handson_day9.md -o handson_day9.pdf
rm pool.png
