#!/bin/bash

# Create an output directory to store read-level quality control results
# This directory will contain all NanoPlot-generated figures and summary files
mkdir precheck

# Run NanoPlot to assess the quality of Oxford Nanopore long-read sequencing data
# --fastq specifies the input FASTQ file containing raw Nanopore reads
# --outdir specifies the output directory for all NanoPlot results
# --threads sets the number of CPU threads used for plotting and statistics

NanoPlot \
--fastq SRR32410565.fastq.gz \
--outdir precheck \
--threads 2
