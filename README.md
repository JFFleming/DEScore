# DEScore
The DE-Score (Dayhoff Exchange Score) is a measurement of saturation within and between amino acid datasets. 

Site Saturation can be a serious problem for the accurate and effective recovery of phylogenetic topologies, caused by large amounts of independent change along branches, which obscures the phylogenetic signal of the data. As nucleotide data only possesses four plausible states, it is often considered to be more prone to these kinds of artifacts, and at deep levels of biological time, amino acid datasets are generally preferred (as they comprise a 20 state alphabet).
However, amino acid datasets are not immune to site saturation, particularly considering many phylum-level datasets span hundreds of millions of years (and untold generations) of change. Existing methods to identify site saturation have two clear disadvantages:

1) they cannot be used to compare saturation directly between datasets.
2) they cannot be used to assess the contribution of individual taxa to the overall saturation level of the dataset.
3) they often require detailed phylogenetic analysis prior to identifying site saturation in the dataset.

The DE-Score is a rapid, easily calculated site saturation metric, implemented in Perl, that provides users with the ability to easily survey and explore the presence of site saturation in their dataset. It also contains a taxon-specific metric, the tDE-Score, which for the first time allows researchers to assess the effect of a single taxa on the overall saturation in a dataset.

# How does it work?
The DE-Score is very simple! It measures the frequency of pairwise between Dayhoff Category and within Dayhoff Category Exchanges across an amino acid dataset, and then works out the distance of these changes from the uninformative Dayhoff Category Exchange Ratio, normalised for the size of the dataset. It uses the following equation:

<img width="432" alt="Screen Shot 2025-01-20 at 10 48 03 AM" src="https://github.com/user-attachments/assets/a37ae2bf-7a9a-46ee-882b-ff268c351660" />

It also comes in a taxa-specific variant, calculated as follows:

<img width="373" alt="Screen Shot 2025-01-20 at 10 49 13 AM" src="https://github.com/user-attachments/assets/38f9ec48-2c24-4837-8efc-ffe6518cb547" />



# Installing the DE-Score Calculator
The DE-Score Calculator provided in this Github is easy to install. It is a Perl script that requires the installation of one additional Perl module - FAST::Bio::SeqIO (this is a Bioperl module that makes it easier to read Fasta Files).
This can be installed with the following command:

``
cpan FAST::Bio::SeqIO
``

And then you're ready to go!

# Using DE-Score Calculator
The DE-Score Calculator takes two arguments as input, an aligned fasta file and an output prefix, as follows:

``
perl DEScoreCalculator.pl <InputFileName> <OutputFilePrefix>
``

That can be formatted like so:

``
perl DEScoreCalculator.pl Input.fas Results
``

This command takes the fasta file "Input.fas" as input, and produces two output files: "Results.SiteSaturation.TotalFrequencies.txt" and "Results.SiteSaturation.TaxaFrequencies.txt". 


Inside Results.SiteSaturation.TotalFrequencies.txt you will find a table showing the Dayhoff Exchange Frequency, Dayhoff Exchange Frequency Standard Deviation and the DE-Score of the entire dataset.
Inside Results.SiteSaturation.TaxaFrequencies.txt you will find the same, but for each taxa in your dataset instead.


# NoiseMaker
Also provided in this package is Noisemaker, available as either a perl or ruby script. It is a pure noise generator for amino acid datasets, used in the initial manuscript to test the effect of noise on the DE-Score. Noisemaker is a very simple program - you provide Noisemaker with four parameters - the number of taxa/sequences you would like in your alignment, the length of an amino acid alignment, the number of simulation cycles, and an optional parameter of a seed that will let you repeat the analysis by generating the same random datasets. It produces a fasta alignment of pure noise by randomly generating a number from 1-20 X number of times.

Format a command for Noisemaker as follows
``
ruby NoiseMaker.rub 10 100 100
``
This produces an alignment of ten taxa that is 100 amino acids in length 100 times. It also produces a text file which tracks the random seed.
``
ruby NoiseMaker.rub 10 100 100 123456
``
Will produce the same, but using the specified random seed 123456.
``
perl NoiseMaker.pl 10 100 100
``
and
``
perl NoiseMaker.pl 10 100 100 123456
``
Are the same command (although the random seed may differ between versions, and so output directories and random seed files are labelled as Noisemaker_Ruby and Noisemaker_Perl).


