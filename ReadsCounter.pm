package ReadsCounter;

use Moose;
use Bio::Seq;
use Bio::SeqIO;

has 'fastq_file' => (is =>'ro', isa => 'Str', required => 1);
has 'search_seq' => (is =>'ro', isa => 'Str', required => 1);
has 'output_file' => (is =>'ro', isa => 'Str', required => 1);

sub reads_counter{
    my ($self) =@_;
    my $reads_counter=0;
#    my $line_counter=0;
    my $fastq_file = $self->fastq_file;
    my $search_seq = $self->search_seq;
    my $output_file = $self->output_file;
    my $infile = "<$fastq_file";
    if ($fastq_file =~/gz$/){
	$infile = "gunzip -c $fastq_file |";
    }


#    open(my $file_handle,'-|', "gunzip -c $fastq_file" ) 
#	or die ("Unable to open $fastq_file: $!\n");
    
    my $seq_in = Bio::SeqIO->new(
	-file => $infile,
	-format => 'fastq',
	);
    my $seq_out = Bio::SeqIO->new(
	-file =>">$output_file",
	-format => 'fastq',
	);
    
    while (my $seq =$seq_in->next_seq() ){
	my $sequence= $seq->seq();
	if ($sequence =~ /$search_seq/i){
	    $reads_counter++;
	    $seq_out -> write_seq($seq);
	}
    }
#    close $file_handle;
    return $reads_counter;
}

1;
