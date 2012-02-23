package ReadsCounter;

use Moose;

has 'fastq_file' => (is =>'ro', isa => 'Str', required => 1);
has 'search_seq' => (is =>'ro', isa => 'Str', required => 1);

sub reads_counter{
    my ($self) =@_;
    my $reads_counter=0;
    my $line_counter=0;
    my $fastq_file = $self->fastq_file;
    my $search_seq = $self->search_seq;

    open(my $file_handle,'-|', "zcat $fastq_file" ) 
	or die ("Unable to open $fastq_file: $!\n");

    while (my $line =<$file_handle>){
	$line_counter++;
	if ( ($line_counter%4)==2 and $line =~ /$search_seq/){
	    $reads_counter++;
	}
    }
    close $file_handle;
    return $reads_counter;
}

1;
