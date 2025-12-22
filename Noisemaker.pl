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

=head1 CONTACT

For questions, comments, or bug reports, please contact:

j.fleming@ub.edu

=head1 LICENSE

This script is provided for academic and research use.
Please cite the appropriate publication if you use this software in
published work. (Publication is under review)

=head1 SEE ALSO

perldoc, pod2man, pod2html

=cut

my $version = 1.2;
print "Noisemaker Version $version, December 18th 2025 written by James Fleming & Torsten H. Struck\n";

my $inputNumber = $ARGV[0];
my $inputLength = $ARGV[1];
my $simNumber   = $ARGV[2];
my $out_handle;

# Amino acid lookup table
my %aminoAcids = (
    1  => 'A',  2  => 'R',  3  => 'N',  4  => 'D',  5  => 'C',
    6  => 'Q',  7  => 'E',  8  => 'G',  9  => 'H',  10 => 'I',
    11 => 'L',  12 => 'K',  13 => 'M',  14 => 'F',  15 => 'P',
    16 => 'S',  17 => 'T',  18 => 'W',  19 => 'Y',  20 => 'V'
);

# Random seed handling
my $seedNumber;
if (defined $ARGV[3]) {
    $seedNumber = $ARGV[3];
    srand($seedNumber);
    print "$seedNumber\n";
} else {
    $seedNumber = time();
    srand($seedNumber);
    print "$seedNumber\n";
}

# Output directory
my $output_dir = "Noisemaker_Output_Perl_$seedNumber";
if (-d $output_dir) {
    die "Warning: output directory '$output_dir' already exists. Aborting to prevent overwrite.\n";
} else {
    mkdir $output_dir or die "Failed to create directory '$output_dir': $!\n";
}

# Write seed file
open(my $seed_file, '>', "$output_dir/NoiseMakerSeed.txt") or die $!;
print $seed_file "Perl\n$seedNumber\n";
close $seed_file;

# Simulation loop

for (my $simCycle = 1; $simCycle <= $simNumber; $simCycle++) {
    my $outFile = "$output_dir/$simCycle.Noise.fas";
    open($out_handle, '>', $outFile) or die $!;
    for (my $taxNumber = 1; $taxNumber <= $inputNumber; $taxNumber++) {

        my @seq;
        my @rands;
        for (my $position = 1; $position <= $inputLength; $position++) {
            my $random = int(rand(20)) + 1;
            push(@seq, $aminoAcids{$random});
            push(@rands, $random);
        }

        my $header = ">t" . ($taxNumber) . "\n";
        print $out_handle $header, @seq, "\n";
        print $header, @rands, "\n";
    }

    close $outFile;
}
