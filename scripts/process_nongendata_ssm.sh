#!/bin/bash

MOD=ssm

ITER=99 # number of data sets
bl=95 #
#bl=250

#prep output files
OUT_lik='likel_nongenh_'$bl'_'$MOD'.txt'
OUT_iter='iter_nongenh_'$bl'_'$MOD'.txt'
OUT_time='time_nongenh_'$bl'_'$MOD'.txt'

[[ -f $OUT_lik ]] && rm -f $OUT_lik
[[ -f $OUT_iter ]] && rm -f $OUT_iter
[[ -f $OUT_time ]] && rm -f $OUT_time

touch $OUT_lik
touch $OUT_iter
touch $OUT_time

# run from within the scripts folder
for i in $(seq 0 1 $ITER)
do
  #extract a single file from tar
  tar -xvf ../data/simul_FelsensteinSSM/length1000_b$bl.tar length1000_b$bl\_num$i.fa
  ./main ../data/treeE.tree length1000_b$bl\_num$i.fa $MOD > out.txt
  cat out.txt | grep Likelihood  | cut -d':' -f2  | xargs >> $OUT_lik
  cat out.txt | grep Iter | cut -d':' -f2 | xargs >> $OUT_iter
  cat out.txt | grep Time  | cut -d':' -f2  | xargs >> $OUT_time
  rm out.txt
  # not poluting the folder with single files
  rm length1000_b$bl\_num$i.fa
  rm length1000_b$bl\_num$i.dat
  rm length1000_b$bl\_num$i.cov
done
mv $OUT_time ../results/ssm/.
mv $OUT_lik ../results/ssm/.
mv $OUT_iter ../results/ssm/.
