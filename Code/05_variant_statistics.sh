#!/bin/bash
# Count the total number of variant records in the VCF file
# bcftools view -H outputs variant records without the VCF header
# wc -l counts the number of variant lines
bcftools view -H variants.vcf.gz | wc -l

# Count the number of single-nucleotide polymorphisms (SNPs)
# -v snps restricts output to SNP variants only
bcftools view -H -v snps variants.vcf.gz | wc -l

# Count the number of small insertions and deletions (indels)
# -v indels restricts output to indel variants only

# Summarize alignment coverage statistics across the reference genome
# samtools coverage reports the proportion of reference bases covered,
# along with mean depth and mapping quality, providing a quantitative
# assessment of assembly-to-reference concordance
bcftools view -H -v indels variants.vcf.gz | wc -l04_variant_calling_bcftools.sh
samtools coverage asm_to_ref.sorted.bam
