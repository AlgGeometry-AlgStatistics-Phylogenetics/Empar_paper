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
$b=0.05;
    for(my $tenbrb=5;$tenbrb<150;$tenbrb+=2){
 $lbrb=$tenbrb/100;
	for($i=0;$i < $tests;$i++){
	    
#############DEFINING FILE treein.txt
#define the file treein.txt Si genero amb F84, o HKY ... 
	    open(TREEIN,">treein.txt");
	    print TREEIN "((1:", $lbrb,", 2:",$lbra,"):",$lbra,", 3:", $lbrb,", 4:",$lbra,");\n";
	    close(TREEIN);
##########################################

#executing GenNonh
	    system('~/GenNon-H/GenNon-h treein.txt ~/papers/Empar_paper/data/simul_Felsensteink81/length'.$length.'_b'.$tenbrb.'_num'.$i.'.fa '.$length.' k81 >simul.txt')==0 or die "system failed in GenNonh";
#	sleep(1);


	}
system('tar -cf ~/papers/Empar_paper/data/simul_Felsensteink81/length'.$length.'_b'.$tenbrb.'.tar ~/papers/Empar_paper/data/simul_Felsensteink81/leng*.fa')==0 or die;
system('tar -cf ~/papers/Empar_paper/data/simul_Felsensteink81/dat_length'.$length.'_b'.$tenbrb.'.tar ~/papers/Empar_paper/data/simul_Felsensteink81/leng*.dat')==0 or die;	
system('rm ~/papers/Empar_paper/data/simul_Felsensteink81/*.dat');
system('rm ~/papers/Empar_paper/data/simul_Felsensteink81/*.fa');

	
    }

