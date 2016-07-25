#!/usr/bin/perl                                    

use strict;

#USAGE: ./treespace.pl length
my $i;
my $lbra;
my $lbrb;
#my $k;
my $length=$ARGV[0];
my $tests=100; #NUMBER OF SEQ i WANT TO GENERATE FOR EACH LENGTH


#for(my $tenbra=1;$tenbra<150;$tenbra+=2){
 #       $lbra=$tenbra/100;
$lbra=0.5;
$b=0.05;
    for(my $tenbrb=1;$tenbrb<60;$tenbrb+=10){
 $lbrb=$tenbrb/1000;
	for($i=0;$i < $tests;$i++){
	    
#############DEFINING FILE treein.txt
#define the file treein.txt Si genero amb F84, o HKY ... 
	    open(TREEIN,">treein.txt");
	    print TREEIN "((1:", $lbra,", 2:",$lbra,"):",$lbrb,", 3:", $lbrb,", 4:",$lbrb,");\n";
	    close(TREEIN);
##########################################

#executing GenNonh
	    system('./GenNon-h treein.txt simul_Farris2/length'.$length.'_c'.$tenbrb.'_num'.$i.'.fa '.$length.' gmm >simul.txt')==0 or die "system failed in GenNonh";
	sleep(1);
###########################################
#execute our program for each alignment:
#  system('~/pompeu/4leaves/4lnorma1/./4leaves1.pl seq.txt >out4leaves.txt')==0 or die "system failed in 4leaves1.pl";

##########################################
#########check the result for our program
#	    open(TREE, "< out4leaves.txt") or die;
#	    my $line=<TREE>;
#	    chomp($line);
#	    close(TREE);
#	    $wrongs+=&simplecheck($line);
#	  
######################################

	}
#system('cd treespace') or die;
system('tar -cf simul_Farris2/length'.$length.'_c'.$tenbrb.'.tar simul_Farris2/leng*.fa')==0 or die;
#
#system('mv *.tar treespace/treespace'.$length.'/') or die;
system('rm simul_Farris2/*.dat');
system('rm simul_Farris2/*.fa');
#	print OUTA $lbrb," ",$tests-$wrongs,"\n";
#	$wrongs=0;
	
    }
#    $bra{$lbra}=$brb;

#print OUT ")\n";
#print OUT "lbrb<-c(";
#for($lbrb=0.01;$lbrb<0.76;$lbrb+=0.02){
#    print OUT $lbrb; 
#    if($lbrb < 0.75){print OUT ",";}
#}
#print OUT ")\n";
#print OUT "scores<-c(";
#for($lbra=0.01;$lbra<0.76;$lbra+=0.02){
#    my $hash=$bra{$lbra};
#    for($lbrb=0.01;$lbrb<0.76;$lbrb+=0.02){
#	print OUT $tests-$$hash{$lbrb};    
#	if($lbrb < 0.75){print OUT ",";}
#    }
#}
#print OUT ")\n";
#close(OUT);
#close(OUTA);

#########################################################RUTINES##############################################



sub simplecheck{
    my $newicktree=$_[0];
		if($newicktree !~ /\(\(1,2\),3,4\)/) {
		    if($newicktree !~ /\(\(2,1\),3,4\)/) {
			if($newicktree !~ /\(\(1,2\),4,3\)/) {
			    if($newicktree !~ /\(\(2,1\),4,3\)/) {
				if($newicktree !~ /\(\(3,4\),1,2\)/) {
				    if($newicktree !~ /\(\(3,4\),2,1\)/) {
					if($newicktree !~ /\(\(4,3\),1,2\)/) {
					    if($newicktree !~ /\(\(4,3\),2,1\)/) {
						return(1);
					    }
					}
				    }
				}
			    }
			}
		    }
		}

}


sub check{
#returns 0 if correct tree, returns 1 if not.
    my $newicktree=$_[0];
	if($newicktree !~ /\(1,\(3,4\),2\)/) {
	    if($newicktree !~ /\(1,\(4,3\),2\)/) {
		if($newicktree !~ /\(2,\(3,4\),1\)/) {
		    if($newicktree !~ /\(2,\(4,3\),1\)/) {
			if($newicktree !~ /\(3,\(1,2\),4\)/) {
			    if($newicktree !~ /\(3,\(2,1\),4\)/) {
				if($newicktree !~ /\(4,\(1,2\),3\)/) {
				    if($newicktree !~ /\(4,\(2,1\),3\)/) {
					if($newicktree !~ /\(\(1,2\),3,4\)/) {
					    if($newicktree !~ /\(\(2,1\),3,4\)/) {
						if($newicktree !~ /\(\(1,2\),4,3\)/) {
						    if($newicktree !~ /\(\(2,1\),4,3\)/) {
							if($newicktree !~ /\(\(3,4\),1,2\)/) {
							    if($newicktree !~ /\(\(3,4\),2,1\)/) {
								if($newicktree !~ /\(\(4,3\),1,2\)/) {
								    if($newicktree !~ /\(\(4,3\),2,1\)/) {
									return(1);
							# print $line, "\n";
							# next;
							#my $fileout='testseqphylip/wrong_'.$length.'_'.$x;
							#open(STD, ">",$fileout) or die "cannot open file wrongtree";
							#print STD $line, "\n";
							#open(PAMLIN,"<MCbase.dat");
							#while(<PAMLIN>){
							#    print STD $_;
							#}
							#close(PAMLIN);
							#close(STD);
								    }
								}
							    }
							}
						    }
						}
					    }
					} 
				    }
				   }
				}
			       }
			    }
			   }
			}
		       }
    else{
	return(0);
    }
}



#reads the newick tree written in the file "outtree"
sub readtreephy{
	open(PHY, "<outtree") or die "Couldn't open outtree";
	my $tree;
	while (<PHY>){
	     chomp;
	     $tree.=$_;
	}	
	chomp($tree);
	close(PHY);
		$tree=~s/seq\.//g;
		$tree=~s/:\d+\.\d+//g;
	return($tree);
}



#reads from "mc.paml" and writes the sequences in FASTA format in "seq.txt"
sub phytofasta{
	my $seq;
	my $newsp;
	my $file=$_[0];
	open(RESULT,"<$file") or print "no such file";
	while(<RESULT>){
	    chomp;
	    if(/\s+\d+\s+\d+/){
		next;
	    }
	    if(/^\w+\s/){
		$_=~s/(\w+)\s+([\w+\d+]+)//;
		$newsp=$1;
		$$seq{$newsp}.=$2;
	    }
	}
	close(RESULT);
#	my $l=scalar($length);
	#my $x=scalar($i);
	#my $file='testseq/mc.paml_'.$length.'_'.$x;
	open(SEQ,"> seq.txt") or die;
	foreach my $species (keys(%$seq)){
	    print SEQ ">",$species,"\n";
	    print SEQ $$seq{$species},"\n";
	}
	close(SEQ);
}
