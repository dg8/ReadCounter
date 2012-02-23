#!/usr/bin/env perl

################################################################
#take in a fastq file and count the number of reads containing 
#the given sequence. 
################################################################

use strict;
use warnings;
use Getopt::Long;
use ReadsCounter;

my ($search_seq, $fastq_file);
$fastq_file = 'test.fastq';
GetOptions ( 's|sequence=s' => \$search_seq,
	    # 'f|fastq-file=s' => \$fastq_file,
);

if (!$search_seq){
    die "Please provide the searching sequence after '-s'.\n";
}

$fastq_file =#'/lustre/scratch103/pathogen/pathpipe/eukaryotes/seq-pipelines/Leishmania/donovani_donovani/TRACKING/195/BPK031A1/SLX/BPK031A1_441992/5151_8#6/5151_8#6_2.fastq.gz' ;
't/test.fastq.gz';


my $reads_counter_object = ReadsCounter->new(fastq_file => $fastq_file,
					     search_seq => $search_seq,
    );

my $counter=$reads_counter_object->reads_counter;

print "Found $counter ".(($counter == 1 )?"read":"reads").
" containing the sequence '$search_seq'.\n";



