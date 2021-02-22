#!/bin/bash
if [ $# -eq 3 ]
then
    SCRIPTPATH="$( cd  "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
	echo -e "Running script for testing $1 element values split into $2,  $3 times\n"
	resultfolder="results_$1_$2_$3"
	mkdir -p $resultfolder
	printf "#!/bin/bash\n" > $resultfolder/runandsplit.sh
    touch ./$resultfolder/rawdlist.txt
	b=$(($2*$3))
	for ((j=1;j<=$3;j++))
	do
		for ((i=1;i<=$2;i++))
		do
			a=$(($1/$2))
			a=$(($a*$i))
			printf "echo $b tests left. Testing n=$a && ./dlist_test -n -t $a >> ./$resultfolder/rawdlist.txt && " >> $resultfolder/runandsplit.sh
			b=$(($b-1))
		done
	done
	printf "echo Done testing dlist table" >> $resultfolder/runandsplit.sh
	/bin/bash $resultfolder/runandsplit.sh
	rm $resultfolder/runandsplit.sh
	printf "#!/bin/bash\n" > $resultfolder/runandsplit.sh
    touch ./$resultfolder/rawmtf.txt
	b=$(($2*$3))
	for ((j=1;j<=$3;j++))
	do
		for ((i=1;i<=$2;i++))
		do
			a=$(($1/$2))
			a=$(($a*$i))
			printf "echo $b tests left. Testing n=$a && ./mtf_test -n -t $a >> ./$resultfolder/rawmtf.txt && " >> $resultfolder/runandsplit.sh
			b=$(($b-1))
		done
	done
	printf "echo Done testing dlist table" >> $resultfolder/runandsplit.sh
	/bin/bash $resultfolder/runandsplit.sh
	rm $resultfolder/runandsplit.sh
	printf "#!/bin/bash\n" > $resultfolder/runandsplit.sh
    touch ./$resultfolder/rawarray.txt
	b=$(($2*$3))
	for ((j=1;j<=$3;j++))
	do
		for ((i=1;i<=$2;i++))
		do
			a=$(($1/$2))
			a=$(($a*$i))
			printf "echo $b tests left. Testing n=$a && ./array_test -n -t $a >> ./$resultfolder/rawarray.txt && " >> $resultfolder/runandsplit.sh
			b=$(($b-1))
		done
	done
	printf "echo Done testing dlist table" >> $resultfolder/runandsplit.sh
	/bin/bash $resultfolder/runandsplit.sh
	rm $resultfolder/runandsplit.sh
else
	echo -e "Usage: pathto/complete.sh {max elements} {element split amount} {runs per test}\n"
fi


