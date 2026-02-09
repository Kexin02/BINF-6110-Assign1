#!/bin/bash

# Decompress the reference genome FASTA file while keeping the original compressed file
# -d decompresses the file
# -k keeps the original .gz file intact
gzip -dk GCF_000006945.2_ASM694v2_genomic.fna.gz

# Generate a pileup of aligned contigs against the reference genome
# bcftools mpileup:
#   -f specifies the reference genome FASTA file
#   asm_to_ref.sorted.bam is the sorted alignment file used to generate pileup information
# The pileup output is streamed directly to bcftools call using a pipe
bcftools mpileup -f GCF_000006945.2_ASM694v2_genomic.fna \
asm_to_ref.sorted.bam | \

# Identify sequence variants (SNPs and small indels) based on the pileup information
# bcftools call:
#   -m uses the multiallelic calling model
#   -v outputs variant sites only
#   -Oz writes the output in compressed VCF (VCF.gz) format
# The resulting VCF file contains variant calls comparing the assembly to the reference genome
bcftools call -mv -Oz -o variants.vcf.gz
