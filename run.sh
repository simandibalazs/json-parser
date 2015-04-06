#!/bin/bash
echo "Compile parser? [y/n]";
read answer;
if [[ "$answer" == "y" ]]
then
	echo "Compiling...";
	sh ./src/compile.sh;
fi
ls ./examples;
echo "Name of the input file:";
read filename;
if [[ -f ./examples/$filename ]];
then
	echo "Name of the output file(defaults to result.txt if left empty):";
	read output;
	echo "Name of the formatted output file(defaults to formatted_result.txt if left empty):";
	read formatted_output;
	if [[ -z $output ]]
	then
		output="result.txt";
	fi
	if [[ -z $formatted_output ]]
	then
		formatted_output="formatted_result.txt";
	fi
	echo "Parsing...";
	./src/Parser < ./examples/$filename > $output;
	echo "Writing formatted output...";
	perl -w ./src/format.pl $output $formatted_output
else
	echo "File $filename does not exist."
fi





