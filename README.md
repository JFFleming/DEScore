# DEScore
The DE-Score (Dayhoff Exchange Score) is a measurement of saturation within and between amino acid datasets. 

Site Saturation can be a serious problem for the accurate and effective recovery of phylogenetic topologies, caused by large amounts of independent change along branches, which obscures the phylogenetic signal of the data. As nucleotide data only possesses four plausible states, it is often considered to be more prone to these kinds of artifacts, and at deep levels of biological time, amino acid datasets are generally preferred (as they comprise a 20 state alphabet).
However, amino acid datasets are not immune to site saturation, particularly considering many phylum-level datasets span hundreds of millions of years (and untold generations) of change. Existing methods to identify site saturation have two clear disadvantages:

1) they cannot be used to compare saturation directly between datasets.
2) they cannot be used to assess the contribution of individual taxa to the overall saturation level of the dataset.
3) they often require detailed phylogenetic analysis prior to identifying site saturation in the dataset.

The DE-Score is a rapid, easily calculated site saturation metric, implemented in Perl, that provides users with the ability to easily survey and explore the presence of site saturation in their dataset. It also contains a taxon-specific metric, the tDE-Score, which for the first time allows researchers to assess the effect of a single taxa on the overall saturation in a dataset.

# How does it work?
The DE-Score is very simple! It measures the frequency of pairwise between Dayhoff Category and within Dayhoff Category Exchanges across an amino acid dataset using the following equation:

DEScore=(1/n ∑_(t=1)^n▒∑_(i=1)^(n-1)▒〖Cw〗_it/(〖Cb〗_it+〖Cw〗_it ))/n^(-0.08) ![image](https://github.com/user-attachments/assets/e518ece2-7b29-49c3-bb77-08b1e934f66e)
