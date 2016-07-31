#!/bin/bash

# data in Empar_paper/data/simul_balanc4bppSSM/bppssmlength1000_b100.tar
#bppssmlength1000_b100_num97.fa

MOD=ssm

ITER=2 # number of data sets
bl=100

#prep output files
OUT_lik='likel_balanced4_bpp_'$bl'_'$MOD'_E.txt'
OUT_iter='iter_balanced4_bpp_'$bl'_'$MOD'_E.txt'
OUT_time='time_balanced4_bpp_'$bl'_'$MOD'_E.txt'
OUT_nc='neg_cases_balanced4_bpp_'$bl'_'$MOD'_E.txt'

[[ -f $OUT_lik ]] && rm -f $OUT_lik
[[ -f $OUT_iter ]] && rm -f $OUT_iter
[[ -f $OUT_time ]] && rm -f $OUT_time
[[ -f $OUT_nc ]] && rm -f $OUT_nc

touch $OUT_lik
touch $OUT_iter
touch $OUT_time
touch $OUT_nc

# run from within the scripts folder

for i in $(seq 0 1 $ITER)
do
  #extract a single file from tar
  tar -xvf ../data/simul_balanc4bppSSM/bppssmlength1000_b$bl.tar bppssmlength1000_b$bl\_num$i.fa
  ./main ../data/trees/treeE.tree bppssmlength1000_b$bl\_num$i.fa $MOD > out.txt
  cat out.txt | grep Likelihood  | cut -d':' -f2  | xargs >> $OUT_lik
  cat out.txt | grep Iter | cut -d':' -f2 | xargs >> $OUT_iter
  cat out.txt | grep Time  | cut -d':' -f2  | xargs >> $OUT_time
  cat out.txt | grep "negative branches"  | cut -d':' -f2  | xargs >> $OUT_time

  rm out.txt
  # not poluting the folder with single files
  rm bppssmlength1000_b$bl\_num$i.fa

done
mv $OUT_time ../results/ssm/bpp_data/balanc4bppdata/.
mv $OUT_lik ../results/ssm/bpp_data/balanc4bppdata/.
mv $OUT_iter ../results/ssm/bpp_data/balanc4bppdata/.
mv $OUT_nc ../results/ssm/bpp_data/balanc4bppdata/.
