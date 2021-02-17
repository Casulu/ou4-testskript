#!/bin/bash
if [ $# -eq 4 ]
then
    SCRIPTPATH="$( cd  "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
	echo -e "Running script for testing $2 element values split into $3,  $4 times\n"
	resultfolder=$1_$2_$3_$4
	mkdir -p $resultfolder
	printf "#!/bin/bash\n" > $resultfolder/runandsplit.sh
	printf "$1, $2, $3, $4" > $resultfolder/meta.txt
    touch ./$resultfolder/raw.txt
	b=$(($3*$4))
	for ((j=1;j<=$4;j++))
	do
		for ((i=1;i<=$3;i++))
		do
			a=$(($2/$3))
			a=$(($a*$i))
			printf "echo $b tests left. Testing n=$a && ./$1 -n -t $a >> ./$resultfolder/raw.txt && " >> $resultfolder/runandsplit.sh
			b=$(($b-1))
		done
	done
	/bin/bash $resultfolder/runandsplit.sh
	rm $resultfolder/runandsplit.sh
	echo "Done! Would you like to run the plotter aswell (Y/N)?"
	
else
	echo -e "Usage: pathto/complete.sh {test executable location} {max elements} {element split amount} {runs per test}\n"
fi


