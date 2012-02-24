#!/usr/bin/env perl

###################################
#test script for ReadsCounter.pm
##################################

use strict;
use warnings;

BEGIN{
	use Test::Most;
	use_ok('ReadsCounter');#is the module compile?
}

my %test_search=('AAAAAA' => 25,
		 'GATTTGGGGTTCAAAGCAGTATCGATCAAATAGTAAATCCATTT' => 3,
		 'G{2,}AG' => 2,
		 'ACCTTGG' => 0,
    );

foreach my $key (keys %test_search){
   ok  my $test_object = ReadsCounter->new(fastq_file => 'test/test.fastq',
					   search_seq => $key,
					   output_file => 'test/test.'.$key,
    ), 'object created';


   is($test_object->reads_counter, $test_search{$key}, 'reads_counter()');
}

my $test_object_zip = ReadsCounter->new(fastq_file => 'test/test.fastq.gz',
					search_seq => 'AAAAAA',    
					output_file => 'test/test.gz.output'
);
is($test_object_zip->reads_counter, 25, 'reads_counter()');

done_testing();
