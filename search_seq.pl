#!/usr/bin/env perl

################################################################
#takes in a zipped fastq file and counts the number of reads
#containing the given sequence. 
################################################################

use strict;
use warnings;
use Getopt::Long;
use ReadsCounter;
use Bio::SeqIO::fastq;

my ($search_seq, $fastq_file);
#$fastq_file = 'test.fastq';
GetOptions ( 's|sequence=s' => \$search_seq,
	    # 'f|fastq-file=s' => \$fastq_file,
);

if (!$search_seq){
    die "Please provide the searching sequence: search_seq.pl -s \n";
}

$fastq_file ='/lustre/scratch103/pathogen/pathpipe/eukaryotes/seq-pipelines/Leishmania/donovani_donovani/TRACKING/195/BPK031A1/SLX/BPK031A1_441992/5151_8#6/5151_8#6_2.fastq.gz' ;

my $output_file = 'test/script_output';


my $reads_counter_obj = ReadsCounter->new(fastq_file => $fastq_file,
					     search_seq => $search_seq,
					     output_file => $output_file,
    );

my $counter=$reads_counter_obj->reads_counter;

print "Found $counter ".(($counter == 1 )?"read":"reads").
" containing the sequence '$search_seq'.\n";

