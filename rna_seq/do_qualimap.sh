#!/bin/bash
#11-05-2019

if [ "$1" == "-h" ]; then
  echo "<Pathway to SAM file> <Name of the SAM file> <Name of the GTF file>"
  exit 0
fi

docker pull quay.io/biocontainers/qualimap:2.2.2b--1

docker run --rm --user $(id -u):$(id -g) -v $1:/data/ quay.io/biocontainers/qualimap:2.2.2b--1 qualimap \
rnaseq -bam /data/$2 \
-gtf /data/$3 \
-outformat PDF:HTML \
-outfile /data/Qualimap_$2 \
-outdir /data/results_qualimap \
--java-mem-size=5G > $1/results_qualimap/run.log 2>&1 & 
