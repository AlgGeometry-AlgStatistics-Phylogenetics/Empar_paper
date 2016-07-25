#!/usr/bin/perl                                    

#use strict;

#USAGE: 
my $i;

$n=4;
#my $k;
my $length=$ARGV[0];
my $tests=100; #NUMBER OF SEQ i WANT TO GENERATE FOR EACH LENGTH
my $l1;


my $b=95;

    my $filer='outbppml_k81_b'.$b.'length'.$length;
open(OUTR,">", $filer);


	
#system('tar -xf ~/ania_k/Empar_paper/data/simul_Felsensteink81/length'.$length.'_b'.$b.'.tar');

	for($i=0;$i < $tests;$i++){
	    
	my $fastafile='~/ania_k/Empar_paper/data/simul_Felsensteink81/length'.$length.'_b'.$b.'_num'.$i.'.fa';

 system('mv '.$fastafile.' align.fa'); 

  system("bppml param=bppsuitek81.txt"); 
open(PARAM,"< param_estimates.txt") or die;
	while(<PARAM>){	
#{# sites 10000,  total changes }
#{# sites100000,  total changes102769}
#if($_ !~ s/^#\s+sites\s*\d+,\s+total\s+changes\s*//){
# Log likelihood = -1035.69160782249036856228
		if($_ !~ s/^#\s+Log\s*likelihood\s+=\s+-//){
		next;
		}
		else{
		#$_=~s/(\d+)\s+//;
		$_=~s/(\d+\.\d+)\s+//;
		$l1=$1;
		last;
		}
	}
close(PARAM);
#print $l1;
#exit(0);

print OUTR $l1, ",";
}
system('rm len*.fa');
close(OUTR);


