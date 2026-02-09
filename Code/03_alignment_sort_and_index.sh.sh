#!/bin/bash

# Convert the SAM alignment file to BAM format, then sort the alignments by genomic coordinates
# samtools view:
#   -@ 2 specifies the use of 2 CPU threads
#   -bS converts the input SAM file into BAM format
# The output is piped directly into samtools sort to avoid writing an intermediate file
# samtools sort:
#   -@ 2 specifies the use of 2 CPU threads
#   -o defines the name of the sorted BAM output file
samtools view -@ 2 -bS asm_to_ref.sam | samtools sort -@ 2 -o asm_to_ref.sorted.bam

# Index the sorted BAM file to enable rapid random access
# This index file is required for downstream analyses and visualization in IGV
samtools index asm_to_ref.sorted.bam


