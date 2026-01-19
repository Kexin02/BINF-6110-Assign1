# BINF*6110 Assignment 1
## Introduction

Whole-genome assembly and reference-based genome comparison are fundamental tasks in bioinformatics and are widely applied in microbial genomics, pathogen surveillance, and evolutionary studies (Quainoo et al., 2017). The goal of this assignment is to assemble a consensus genome of *Salmonella enterica* from raw Oxford Nanopore sequencing reads and to compare the assembled genome to a reference genome obtained from NCBI through alignment and variant analysis.

*Salmonella enterica* is a bacterial pathogen of major public health importance and has a relatively small (approximately 5 Mb), haploid genome, making it well suited for de novo genome assembly using long-read sequencing data (Li et al., 2021). Bacterial genomes typically lack the extensive repetitive content and ploidy complexity found in many eukaryotic genomes, allowing assembly strategies to focus primarily on read length, sequencing accuracy, and coverage rather than phasing or large-scale scaffolding (Zadesenets et al., 2017).

Next-generation sequencing technologies are commonly divided into short-read and long-read platforms, each with distinct advantages and limitations. Short-read sequencing technologies, such as Illumina, produce highly accurate reads that enable precise base-level analyses but often result in fragmented assemblies due to their limited read length, particularly in repetitive genomic regions (Whiteford et al., 2005). In contrast, long-read sequencing technologies, including Oxford Nanopore Technologies (ONT), generate reads that span several kilobases, enabling improved assembly contiguity and resolution of structural features (Kim et al., 2024). However, long-read sequencing data are generally characterized by higher per-base error rates, particularly insertions and deletions, which can affect consensus accuracy if not properly addressed (Amarasinghe et al., 2020).

Recent improvements in ONT chemistry and basecalling accuracy have made long-read-only genome assembly increasingly feasible for bacterial genomes, provided that appropriate assembly and alignment methods are used (Zhang et al., 2021). Long-read assemblers reconstruct genomes by identifying overlaps between reads to generate contiguous sequences, but sequencing errors can still lead to misassemblies or incorrect consensus sequences, highlighting a trade-off between structural completeness and base-level accuracy (Bzikadze et al., 2022).

Reference-based alignment provides a complementary approach for evaluating genome assemblies and identifying genetic differences relative to a known reference (Liu et al., 2018). Modern aligners typically use heuristic strategies, such as k-mer-based seeding followed by local alignment extension, to efficiently compare large sequences (Shaw & Yu, 2023). While these methods are computationally efficient, alignment accuracy can be influenced by sequencing errors, repetitive regions, and reference bias, which must be considered when interpreting variant calls (Freeman et al., 2020).

In this assignment, a long-read genome assembly approach is combined with reference-based alignment and visualization to compare an assembled *Salmonella enterica* genome to a reference sequence. This workflow highlights the practical trade-offs between sequencing technology, assembly strategy, and alignment-based comparison, while providing hands-on experience with commonly used bioinformatics tools.

## Methods

Raw sequencing reads will be provided in FASTQ format and generated using Oxford Nanopore sequencing with R10 chemistry. FASTQ files contain both nucleotide sequences and per-base quality scores, allowing for initial assessment of sequencing quality prior to genome assembly. Read quality and length distributions will be examined using NanoPlot (v1.46.2) to ensure that the data are suitable for long-read assembly and to identify potential issues such as excessive short or low-quality reads (De Coster & Rademakers, 2023).No read trimming or filtering will be applied unless initial quality assessment indicates substantial low-quality signal, in which case default parameters will be used.

De novo genome assembly will be performed using Flye (v2.9.6), a long-read assembler designed for noisy sequencing data produced by Oxford Nanopore platforms (Kolmogorov et al., 2020). Assembly will be carried out using the ```--nano-raw``` option, which is appropriate for raw Nanopore reads, and an estimated genome size of approximately 5 Mb based on known *Salmonella enterica* genomes. All other parameters will be left at their default values. This approach balances assembly contiguity with computational efficiency and is well suited for bacterial genomes.

The draft assembly will be compared to a reference genome for *Salmonella enterica* obtained from the NCBI RefSeq database in FASTA format. The assembled genome will be aligned to the reference using minimap2 (v2.30), an aligner optimized for long-read and assembly-to-reference comparisons (H. Li, 2018). Alignments will be generated using the ```-ax asm5``` preset, which is recommended for aligning assembled contigs to a reference genome, and stored in SAM/BAM format for downstream analysis (H. Li, 2018). Alignment files will be processed using samtools (v1.23) for sorting and indexing (Danecek et al., 2021).

Differences between the assembled genome and the reference genome, including single-nucleotide variants and small insertions or deletions, will be identified using bcftools (v1.23) based on the alignment results (Danecek et al., 2021). Variant calls and alignments will be visualized using Integrative Genomics Viewer to inspect read coverage, alignment quality, and regions of divergence (Robinson et al., 2011). Visualization will be used to assess assembly accuracy and to support interpretation of observed differences between the assembled genome and the reference.

## References
Amarasinghe, S. L., Su, S., Dong, X., Zappia, L., Ritchie, M. E., & Gouil, Q. (2020).   
Opportunities and challenges in long-read sequencing data analysis.   
*Genome Biology, 21*(1), 30.         
https://doi.org/10.1186/s13059-020-1935-5  

Bzikadze, A. V., Mikheenko, A., & Pevzner, P. A. (2022).   
Fast and accurate mapping of long reads to complete genome assemblies with VerityMap.   
*Genome Research, 32*(11–12), 2107–2118.       
https://doi.org/10.1101/gr.276871.122  

Danecek, P., Bonfield, J. K., Liddle, J., Marshall, J., Ohan, V., Pollard, M. O., Whitwham, A., Keane, T., McCarthy, S. A., Davies, R. M., & Li, H. (2021).   
Twelve years of SAMtools and BCFtools.   
*GigaScience, 10*(2), giab008.   
https://doi.org/10.1093/gigascience/giab008  

De Coster, W., & Rademakers, R. (2023).   
NanoPack2: Population-scale evaluation of long-read sequencing data. *Bioinformatics, 39*(5), btad311.   
https://doi.org/10.1093/bioinformatics/btad311  

Freeman, T. M., Wang, D., & Harris, J. (2020).   
Genomic loci susceptible to systematic sequencing bias in clinical whole genomes.   
*Genome Research, 30*(3), 415–426.   
https://doi.org/10.1101/gr.255349.119  

Kim, C., Pongpanich, M., & Porntaveetus, T. (2024).   
Unraveling metagenomics through long-read sequencing: A comprehensive review.   
*Journal of Translational Medicine, 22*(1), 111.   
https://doi.org/10.1186/s12967-024-04917-1  

Kolmogorov, M., Bickhart, D. M., Behsaz, B., Gurevich, A., Rayko, M., Shin, S. B., Kuhn, K., Yuan, J., Polevikov, E., Smith, T. P. L., & Pevzner, P. A. (2020).   
metaFlye: Scalable long-read metagenome assembly using repeat graphs.   
*Nature Methods, 17*(11), 1103–1110.   
https://doi.org/10.1038/s41592-020-00971-x  

Li, C., Tyson, G. H., Hsu, C.-H., Harrison, L., Strain, E., Tran, T.-T., Tillman, G. E., Dessai, U., McDermott, P. F., & Zhao, S. (2021).   
Long-Read Sequencing Reveals Evolution and Acquisition of Antimicrobial Resistance and Virulence Genes in Salmonella enterica.   
*Frontiers in Microbiology, 12*.   
https://doi.org/10.3389/fmicb.2021.777817  

Li, H. (2018). Minimap2: Pairwise alignment for nucleotide sequences.   
*Bioinformatics, 34*(18), 3094–3100.   
https://doi.org/10.1093/bioinformatics/bty191  

Liu, W., Wu, S., Lin, Q., Gao, S., Ding, F., Zhang, X., Aljohi, H. A., Yu, J., & Hu, S. (2018).   
RGAAT: A Reference-based Genome Assembly and Annotation Tool for New Genomes and Upgrade of Known Genomes.   
*Genomics, Proteomics & Bioinformatics, 16*(5), 373–381.   
https://doi.org/10.1016/j.gpb.2018.03.006  

Quainoo, S., Coolen, J. P. M., van Hijum, S. A. F. T., Huynen, M. A., Melchers, W. J. G., van Schaik, W., & Wertheim, H. F. L. (2017).   
Whole-Genome Sequencing of Bacterial Pathogens: The Future of Nosocomial Outbreak Analysis.   
*Clinical Microbiology Reviews, 30*(4), 1015–1063.   
https://doi.org/10.1128/cmr.00016-17  

Robinson, J. T., Thorvaldsdóttir, H., Winckler, W., Guttman, M., Lander, E. S., Getz, G., & Mesirov, J. P. (2011).   
Integrative genomics viewer.   
*Nature Biotechnology, 29*(1), 24–26.   
https://doi.org/10.1038/nbt.1754  

Shaw, J., & Yu, Y. W. (2023).   
Proving sequence aligners can guarantee accuracy in almost O(m log n) time through an average-case analysis of the seed-chain-extend heuristic.   
*Genome Research, 33*(7), 1175–1187.   
https://doi.org/10.1101/gr.277637.122  

Whiteford, N., Haslam, N., Weber, G., Prügel-Bennett, A., Essex, J. W., Roach, P. L., Bradley, M., & Neylon, C. (2005).   
An analysis of the feasibility of short read sequencing.   
*Nucleic Acids Research, 33*(19), e171.   
https://doi.org/10.1093/nar/gni170  

Zadesenets, K. S., Ershov, N. I., & Rubtsov, N. B. (2017).   
Whole-genome sequencing of eukaryotes: From sequencing of DNA fragments to a genome assembly.   
*Russian Journal of Genetics, 53*(6), 631–639.   
https://doi.org/10.1134/S102279541705012X  

Zhang, P., Jiang, D., Wang, Y., Yao, X., Luo, Y., & Yang, Z. (2021).   
Comparison of De Novo Assembly Strategies for Bacterial Genomes.   
*International Journal of Molecular Sciences, 22*(14), 7668.   
https://doi.org/10.3390/ijms22147668  
