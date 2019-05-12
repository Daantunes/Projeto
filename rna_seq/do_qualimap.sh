#!/bin/bash
#11-05-2019

if [ "$1" == "-h" ]; then
  echo "<Pathway to BAM file> <Name of the BAM file> <Name of the GTF file>"
  exit 0
fi

docker pull quay.io/biocontainers/qualimap:2.2.2b--1

docker run --rm --user $(id -u):$(id -g) -v $1:/data/ quay.io/biocontainers/qualimap:2.2.2b--1 \
qualimap rnaseq -bam $1/$2 -gtf $1/$3 \
-outformat PDF:HTML -outfile Qualimap_$2 \
-outdir $1/results_qualimap > $1/results_qualimap/run.log 2>&1 &
