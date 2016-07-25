#!/usr/bin/perl                                    

#use strict;

#USAGE: 
my $i;

$n=4;
#my $k;
my $length=$ARGV[0];
my $b=$ARGV[1];
my $tests=100; #NUMBER OF SEQ i WANT TO GENERATE FOR EACH LENGTH
#my $b=95;


	for($i=0;$i < $tests;$i++){
	    

  system('bppseqgen param=bppsuitegen'.$b.'.txt');

	my $fastafile='bppssmlength'.$length.'_b'.$b.'_num'.$i.'.fa';

 system('mv generatedalign.fa '.$fastafile);  
sleep(1);
}
#system('tar -cf bppssm'.$length.'_b'.$b.'.tar bppssmlength*.fa');
#system('mv bppssm'.$length.'_b'.$b.'.tar ~/ania/Empar_paper/data/simulationsbppml_FelsSSM/');
#system('rm bppssmlength*.fa');
