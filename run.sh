#!/bin/bash
if [ $# -eq 5 ]
then
    SCRIPTPATH="$( cd  "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
	echo -e "Running script for testing $2 element values split into $3,  $4 times\n"
	printf "#!/bin/bash\n" > runandsplit$1.sh
    touch ./$5
	b=$(($3*$4))
	for ((j=1;j<=$4;j++))
	do
		for ((i=1;i<=$3;i++))
		do
			a=$(($2/$3))
			a=$(($a*$i))
			printf "echo $b tests left. Testing n=$a && $1 -n -t $a >> ./$5 && " >> runandsplit$1.sh
			b=$(($b-1))
		done
	done
	printf "echo Done testing" >> runandsplit$1.sh
	/bin/bash runandsplit$1.sh
	rm runandsplit$1.sh
else
	echo -e "Usage: pathto/complete.sh {path to the compiled test} {max elements} {element split amount} {runs per test} {output name}\n"
fi


