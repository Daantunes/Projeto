#!/bin/bash
#19-06-2019

if [ "$1" == "-h" ]; then
  echo "<Pathway to index files> <Name of the fasta file used in index> <Name of the fastq file>"
  exit 0
fi

docker pull quay.io/biocontainers/bedtools:2.23.0--hdbcaa40_3

docker run -d --rm --user $(id -u):$(id -g) -v $1:/data/ quay.io/biocontainers/bedtools:2.23.0--hdbcaa40_3 bash -c 'bowtie2 \
-p 15 -q --no-unal \
-x /data/genome/$2 \
-U /data/$3 \
-S /data/results/counts_$3.sam'


docker run -d --rm --user $(id -u):$(id -g) -v $1:/data/ quay.io/biocontainers/bedtools:2.23.0--hdbcaa40_3 bedtools bamToBed -i reads.bam > reads.bed
