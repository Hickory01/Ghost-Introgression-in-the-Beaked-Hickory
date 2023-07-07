use strict;
use warnings;
sub help{
	print "perl xx.pl sp1.list sp2.list D_dir/\n";
	print "perl summary_ABBABABA_result.pl p1.list EA.list NA.list ABBA-BABA/block-10k-size/ 1>Asi-EA-NA-clade.txt\n";
}
sub read_list{
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
	my @sp1 = &read_list($ARGV[0]);
	my @sp2 = &read_list($ARGV[1]);
	my @sp3 = &read_list($ARGV[2]);
	print "P1\tP2\tP3\tD-statistic\tZ-score\tblock bootstrap SD\tP-value\n";
	my $line;
	my @files = split(/\n/,`ls $ARGV[3]`);
	foreach my $file(@files){
		my $new = $file;
		$new =~ s/\.fa\.log//g;
		my @tmp = split(/\-/,$new);
		my $n = 0;
		foreach my $ck1(@tmp){
			if(grep{$ck1 eq $_}@sp1){
				$n++;
				last;
			}
		}
		foreach my $ck2(@tmp){
			if(grep{$ck2 eq $_}@sp2){
				$n++;
				last;
			}
		}
		foreach my $ck3(@tmp){
			if(grep{$ck3 eq $_}@sp3){
				$n++;
				last;
			}
		}
		if($n == 3){
			print STDERR "$file\n";
			$line .= "$tmp[0]\t$tmp[1]\t$tmp[2]\t";
			open(IN,"$ARGV[3]/$file") or die;
			while(<IN>){
				chomp;
				if(/Z-score/){
					my @it = split(/\s+/,$_);
					$line .= "$it[-3]\t$it[-1]\t";
				}
				if(/SD/){
					my @it = split(/\s+/,$_);
					$line .= "$it[-1]\t";
				}
				if(/P-value/){
					my @it = split(/\s+/,$_);
					$line .= "$it[-1]\t";
				}
			}
			close(IN);
			$line .= "\n";	
		}
	}
	print "$line";
}
