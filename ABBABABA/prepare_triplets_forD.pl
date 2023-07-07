use strict;
use warnings;
sub help{
	print "perl xxx.pl allsp.list connect_sequence.fa\n";
}
if($ARGV[0] eq "-h"){
	&help;
}else{
	open(IN,"$ARGV[0]") or die;
	my @sp;
	while(<IN>){
		chomp;
		push  @sp,$_;
	}
	close(IN);
	my $num = @sp;
	for(my $i =0;$i< $num;$i++){
		for(my $j=$i+1;$j< $num;$j++){	
			for(my $k=$j+1;$k< $num;$k++){
					my $sp1 = $sp[$i];
					my $sp2 = $sp[$j];
					my $sp3 = $sp[$k];
					my $out = "Pste"; ##outgroup 
					open(FA,"$ARGV[1]") or die;
					my %seq;
					my $ind;
					while(<FA>){
						chomp;
						if(/^>(.*)/){
							$ind = $1;
						}else{
							s/N/-/g;
							$seq{$ind} .= $_;
						}
					}
					close(FA);
					open(OUT1,">$sp1-$sp2-$sp3.fa") or die;
					print OUT1 ">$sp1\n$seq{$sp1}\n>$sp2\n$seq{$sp2}\n>$sp3\n$seq{$sp3}\n>$out\n$seq{$out}\n";
					close(OUT1);
					open(OUT2,">$sp1-$sp3-$sp2.fa") or die;
					print OUT2 ">$sp1\n$seq{$sp1}\n>$sp3\n$seq{$sp3}\n>$sp2\n$seq{$sp2}\n>$out\n$seq{$out}";
					close(OUT2);
					open(OUT3,">$sp2-$sp3-$sp1.fa") or die;
					print OUT3 ">$sp2\n$seq{$sp2}\n>$sp3\n$seq{$sp3}\n>$sp1\n$seq{$sp1}\n>$out\n$seq{$out}";
					close(OUT3);
					print STDERR "$sp1-$sp2-$sp3.fa\n";
					print STDERR "$sp1-$sp3-$sp2.fa\n";
					print STDERR "$sp2-$sp3-$sp1.fa\n";
			}
		}
	}
}
