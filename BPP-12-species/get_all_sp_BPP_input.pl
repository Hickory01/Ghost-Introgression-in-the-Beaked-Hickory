use strict;
use warnings;
sub help{
	print "perl xxx.pl seq_dir/ \n";
}
if($ARGV[0] eq "-h"){
	&help;
}else{
	my @files = split(/\n/,`ls $ARGV[0]`);
	open(PHY,">all-sp-input.phy") or die;
	foreach my $file(@files){
		open(FA,"$ARGV[0]/$file") or die;
		open(MAP,">all-sp-map.txt") or die;
		my %seq;
		my $sp;
		while(<FA>){
			chomp;
			if(/^>(.*)/){
				$sp = $1;
			}else{
				$seq{$sp} .= $_;
			}
			
		}
		close(FA);
		my $len = length($seq{Asi});
		print PHY "12 $len\n";
		foreach my $i(sort keys %seq){
			next if($i =~ /Pst/);
			print PHY "$i^$i        $seq{$i}\n";
			print MAP "$i\t$i\n";
		}
		close(MAP);
		print PHY "\n";
	}
	close(PHY);
}
