for file in `cat $1` ###$1 sequence file name, $2: sequence dir
do
	Phi -f $2/$file -p &>$file.log 
done
