use strict;
use warnings;
sub help{
	print "perl xxx.pl gene.list log_dir/ seq_dir/\n";
}
if($ARGV[0] eq "-h"){
	&help;
}else{
	open(IN,"$ARGV[0]") or die;
	my @file;
	while(<IN>){
		chomp;
		push @file,$_;
	}
	close(IN);
	foreach my $file(@file){
		open(IN,"$ARGV[1]/$file.log") or die;
		while(<IN>){
			chomp;
			if(/Permutation/){
				my @it = split(/\s+/,$_);
				if($it[2] > 0.05){
					`cp $ARGV[2]/$file  ./`;
					print STDERR "$file\t$it[2]\n";
				}
			}
			
		}
		close(IN);
	}
}
