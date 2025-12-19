#!/usr/bin/perl
use strict;
use warnings;

=pod

=head1 NAME

Nosiemaker - making random amino acid sequences.

=head1 SYNOPSIS

  perl Noisemaker.pl <Number of Sequences in output alignment> <Length of Sequences in output alignment> <Number of Simulations> <Seed(optional parameter)>

=head1 DESCRIPTION

NOISEMAKER is very simple. It takes four inputs. The inputNumber (how many taxa in an alignment), inputLength (how many amino acid positions), simNumber (how many simulation cycles) and a fourth optional parameter, seed, which lets you track and repeat a simulation analysis.

# Version and startup message
my $version = 1.1;
print "Noisemaker Version $version, October 14th 2025 written by James Fleming & Torsten H. Struck\n";

# Amino acid lookup table
my %aminoAcids = (
    1  => 'A',  2  => 'R',  3  => 'N',  4  => 'D',  5  => 'C',
    6  => 'Q',  7  => 'E',  8  => 'G',  9  => 'H',  10 => 'I',
    11 => 'L',  12 => 'K',  13 => 'M',  14 => 'F',  15 => 'P',
    16 => 'S',  17 => 'T',  18 => 'W',  19 => 'Y',  20 => 'V'
);

# Command-line arguments
my $inputNumber = $ARGV[0];
my $inputLength = $ARGV[1];
my $simNumber   = $ARGV[2];

# Handle seeding
my $seedNumber;
if (defined $ARGV[3]) {
    $seedNumber = $ARGV[3];
    srand($seedNumber);
    print "$seedNumber\n";
} else {
    $seedNumber = srand();
    print "$seedNumber\n";
}

# Ensure output directory exists
my $output_dir = "Noisemaker_Output_Perl_$seedNumber";
if (-d $output_dir) {
    die "Warning: output directory '$output_dir' already exists. Aborting to prevent overwrite.\n";
} else {
    mkdir $output_dir or die "Failed to create directory '$output_dir': $!\n";
}

# Write seed file inside output directory
open(my $seed_file, '>', "$output_dir/NoiseMakerSeed.txt") or die $!;
print $seed_file "Perl\n$seedNumber\n";
close $seed_file;

#Noisemaker
for (my $sim = 0; $sim < $simNumber; $sim++) {

    my $fileNumber = $sim + 1;
    my $fileName = "$output_dir/$fileNumber.Noise.fas";

    open(my $file, '>>', $fileName) or die $!;

    for (my $i = 0; $i < $inputNumber; $i++) {

        my $seq = '';

        for (my $j = 0; $j < $inputLength; $j++) {
            my $randomaa = srand(20) + 1;
            $seq .= $aminoAcids{$randomaa};
        }

        my $header = ">t" . ($i + 1) . "\n";
        print $file $header, $seq, "\n";
#        print $header, $seq, "\n";
    }

    close $file;
}
