#!/usr/bin/perl                                    

use strict;

#USAGE: ./simulFarristree.pl length
my $i;
my $lbra;
my $lbrb;
#my $k;
my $length=$ARGV[0];
my $tests=100; #NUMBER OF SEQ i WANT TO GENERATE FOR EACH LENGTH


#for(my $tenbra=1;$tenbra<150;$tenbra+=2){
 #       $lbra=$tenbra/100;
$lbra=0.05;
#$b=0.05;
 #   for(my $tenbrb=5;$tenbrb<150;$tenbrb+=2){
my $tenbrb=$ARGV[1]; 
$lbrb=$tenbrb/100;
	for($i=0;$i < $tests;$i++){
	    
#############DEFINING FILE treein.txt
#define the file treein.txt Si genero amb F84, o HKY ... 
	    open(TREEIN,">treein.txt");
	    print TREEIN "((1:", $lbrb,", 2:",$lbrb,"):",$lbrb,", 3:", $lbrb,", 4:",$lbrb,");\n";
	    close(TREEIN);
##########################################

#executing GenNonh
	    system('~/GenNon-H/GenNon-h treein.txt ~/ania_k/Empar_paper/data/simul_balanc4GenNonhSSM/length'.$length.'_b'.$tenbrb.'_num'.$i.'.fa '.$length.' ssm >simul.txt')==0 or die "system failed in GenNonh";
#	sleep(1);


	}

#chdir '~/ania_k/Empar_paper/data/simul_FelsensteinSSM/';

#system('tar -cCf ~/ania_k/Empar_paper/data/simul_FelsensteinSSM/ ~/ania_k/Empar_paper/data/simul_FelsensteinSSM/length'.$length.'_b'.$tenbrb.'.tar leng*.fa')==0 or die;

#system('tar -cf ~/ania_k/Empar_paper/data/simul_FelsensteinSSM/length'.$length.'_b'.$tenbrb.'.tar ~/ania_k/Empar_paper/data/simul_FelsensteinSSM/leng*.fa')==0 or die;

#system('tar -cf length'.$length.'_b'.$tenbrb.'.tar leng*.fa')==0 or die;

#system('tar -cCf ~/ania_k/Empar_paper/data/simul_FelsensteinSSM/ ~/ania_k/Empar_paper/data/simul_FelsensteinSSM/dat_length'.$length.'_b'.$tenbrb.'.tar leng*.dat')==0 or die;

#system('tar -cf dat_length'.$length.'_b'.$tenbrb.'.tar leng*.dat')==0 or die;	
#system('rm ~/ania_k/Empar_paper/data/simul_Felsensteink81/*.dat');
#system('rm ~/ania_k/Empar_paper/data/simul_Felsensteink81/*.fa');

	
    

