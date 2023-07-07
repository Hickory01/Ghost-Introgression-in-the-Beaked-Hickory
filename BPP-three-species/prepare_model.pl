use strict;
use warnings;
sub help{
	print "perl xxx.pl sp2.name sp1.name\n";
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
	my $sp1 = "Asi";
	my $sp2 = $ARGV[0];
	my $sp3 = $ARGV[1];
	`mkdir -p $sp1-$sp2-$sp3-BPP`;
		#	my $i = 5;
	my $loci = `grep -c "Asi" $sp1-$sp2-$sp3-BPP.input.txt`;
	my @loci = split(/\n/,$loci);
		for(my $i=1;$i<=5;$i++){
			`cp -r model$i $sp1-$sp2-$sp3-BPP`;
			`cp $sp1-$sp2-$sp3-BPP.input.txt $sp1-$sp2-$sp3-BPP/model$i/`;
			`cp $sp1-$sp2-$sp3-map.txt $sp1-$sp2-$sp3-BPP/model$i/`;
			`sed -i s/Asi-Cca-Cil-BPP/$sp1-$sp2-$sp3-BPP/g $sp1-$sp2-$sp3-BPP/model$i/A00.ctl`;
			`sed -i s/Asi-Cca-Cil-map/$sp1-$sp2-$sp3-map/g $sp1-$sp2-$sp3-BPP/model$i/A00.ctl`;
			`sed -i s/2560/$loci[0]/g $sp1-$sp2-$sp3-BPP/model$i/A00.ctl`;
		}
}
