#!/bin/bash
if [ $# -eq 4 ]
then
	echo -e "Running script for testing $2 element values split into $3,  $4 times\n"
	printf "#!/bin/bash\n" >> runandsplit.sh
	resultfolder=results/$1_$2_$3_$4
	mkdir -p $resultfolder
	printf "$2, $3, $4" >> ./$resultfolder/input.txt
	b=$(($3*$4))
	for ((i=1;i<=$3;i++))
	do
		for ((j=1;j<=$4;j++))
		do	
			a=$(($2/$3))
			a=$(($a*$i)) 
			printf "echo $b tests left. && ./$1 -n -t $a >> ./$resultfolder/raw.txt && " >> runandsplit.sh
			b=$(($b-1))
		done
	done
	printf "python3 splitfile.py ./$resultfolder/raw.txt && python3 splitandavg.py ./$resultfolder/raw.txt" >> runandsplit.sh
	/bin/bash runandsplit.sh
	rm runandsplit.sh
	cp plotter.m $resultfolder/
	echo "Done!"
else 
	echo -e "Usage: ./complete.sh {test executable location} {max elements} {element split amount} {runs per test}\n"
fi


