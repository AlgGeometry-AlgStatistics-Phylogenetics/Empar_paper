#!/usr/bin/perl

#use strict;
use Time::HiRes;

#USAGE:
my $i;

$n=4;
#my $k;
my $length=$ARGV[0];
my $tests=100; #NUMBER OF SEQ i WANT TO GENERATE FOR EACH LENGTH
my $l1;


my $b=$ARGV[1];

    my $filer='likelihoodsbppml_SSM_b'.$b.'length'.$length;
open(OUTR,">", $filer);
my $timefile='timesbppmlSSM_length'.$length.'_b'.$b;
open(TIME,">", $timefile);

system('rm -f iter_bppmlSSMlength'.$length.'_'.$b.'.txt || true');
system('touch iter_bppmlSSMlength'.$length.'_'.$b.'.txt');

system('tar -xf ../data/simulationsbppml_FelsSSM/bppssm'.$length.'_b'.$b.'.tar');

	for($i=0;$i < $tests;$i++){

	my $fastafile='bppssmlength'.$length.'_b'.$b.'_num'.$i.'.fa';

 system('mv '.$fastafile.' align.fa');
#my $st=time();
my $st== [Time::HiRes::gettimeofday()];
#  system("(time bppml param=bppsuite1.txt >outfile) &> outtime");
  system("bppml param=bppsuite1.txt >outfile");
#my $end=time();
my $end=[Time::HiRes::gettimeofday()];
#open(OUTF, "< outfile") or die;
#while(<OUTF>){
#if($_ !~//funtion/
#}
#my $comand="grep user outtime | cut -d'm' -f2 | sed 's/s//g'";
#system($comand.' >> times_length'.$length.'_'.$b.'.txt');
print TIME $end-$st, "\n";
my $c2="grep function outfile | cut -d':' -f2 | cut -d' ' -f2";
system($c2.' >> iter_bppmlSSMlength'.$length.'_'.$b.'.txt');

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
system('rm bppssmlen*.fa');
close(OUTR);
