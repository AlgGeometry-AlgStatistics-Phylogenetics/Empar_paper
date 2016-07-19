#!/bin/bash

MOD='k81'
echo $MOD
LEN=100 # sequence length
ITER=10 # number of data sets

for i in $(seq 1 1 $ITER)
do
  ./GenNon-h data/test.tree data/data_$i.fa $LEN $MOD
done
