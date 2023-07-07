use strict;
use warnings;
sub help{
	print "perl xxx.pl seq_dir/ sp2.name sp3.name \n";
	print "perl get_BPP_input.pl filter-recombination-gap0.5_missing0.2_500-1000bp Cil Cco\n";
}
sub list{
	my ($file) = @_;
	open(IN,$file) or die;
	my @sp;
	while(<IN>){
		chomp;
		push @sp,$_;
	}
	close(IN);
	return @sp;
}
if($ARGV[0] eq "-h"){
	&help;
}else{
	my @files = split(/\n/,`ls $ARGV[0]`);
	my $sp1 = "Asi";
	my $sp2 = $ARGV[1];
	my $sp3 = $ARGV[2];
	open(OUT1,">$sp1-$sp2-$sp3-BPP.input.txt") or die;
	open(OUT2,">$sp1-$sp2-$sp3-map.txt") or die;
	foreach my $file(@files){
		open(FA,"$ARGV[0]/$file") or die;
		my $ind;
		my %seq;
		while(<FA>){
			chomp;
			if(/^>(.*)/){
				$ind = $1;
			}else{
				$seq{$ind} .= uc($_);
			}
		}
		close(FA);
		my $out = $sp1;
		my $len = length($seq{$out});
		print OUT1 "3    $len\n";
		print OUT1 "$sp1^$sp1       $seq{$sp1}\n";
		print OUT1 "$sp2^$sp2       $seq{$sp2}\n";
		print OUT1 "$sp3^$sp3       $seq{$sp3}\n";
		print OUT1 "\n";
	}
	close(OUT1);
	print OUT2 "$sp1\tAsi\n";
	print OUT2 "$sp2\tCil\n";
	print OUT2 "$sp3\tCco\n";
	close(OUT2);
}
