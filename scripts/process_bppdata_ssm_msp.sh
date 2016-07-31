#!/bin/bash

MOD=ssm

ITER=0 # number of data sets
bl=95 #
#bl=250

#prep output files
OUT_lik='likel_bpp_'$bl'_'$MOD'.txt'

[[ -f "$OUT_lik" ]] && rm -f $OUT_lik

touch $OUT_lik

# run from within the scripts folder

for i in $(seq 0 1 $ITER)
do
  #extract a single file from tar
  echo $i
  tar -xvf ../data/simulationsbppml_FelsSSM/bppssm1000_b$bl.tar bppssmlength1000_b$bl\_num$i.fa
  for j in $(seq 0 1 10)
  do
      ./main ../data/treeE.tree bppssmlength1000_b$bl\_num$i.fa $MOD > out.txt
      cat out.txt | grep Likelihood  | cut -d':' -f2  | xargs >> $OUT_lik
  done
  #rm out.txt
  # not poluting the folder with single files
  #rm bppssmlength1000_b$bl\_num$i.fa
  rm bppssmlength1000_b$bl\_num$i.dat
  rm bppssmlength1000_b$bl\_num$i.cov
done
#mv $OUT_lik ../results/ssm/.
