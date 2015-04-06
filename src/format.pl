#!/usr/bin/perl
use warnings;
use strict;

if($#ARGV + 1 == 2){
	my $input = $ARGV[0];
	my $output = $ARGV[1];
	my $newline = "";
	my $nestedlvl = 0;

	open IN, '<', $input or die;
	open OUT, '>', $output or die;

	while ( my $line = <IN> ) {


		if($line eq "---------- ARRAY BEGIN ---------\n" || $line eq "--------- OBJECT BEGIN ---------\n"){
			$newline = "  " x $nestedlvl;
			$newline .= $line;
			print OUT $newline;
			$nestedlvl = $nestedlvl + 1;
		}elsif($line eq "----------- ARRAY END ----------\n" || $line eq "---------- OBJECT END ----------\n"){
			$nestedlvl = $nestedlvl - 1;
			$newline = "  " x $nestedlvl;
			$newline .= $line;
			print OUT $newline;
		}else{
			$newline = "  " x $nestedlvl;
			$newline .= $line;
			print OUT $newline;
		}

	}

	print "Formatted output was written into " . $ARGV[1] . "\n";

	close IN;
	close OUT;
}else{
	print "Missing arguments, exiting...\n";
}

