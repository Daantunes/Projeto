#!/bin/bash
#12-05-2019

if [ "$1" == "-h" ]; then
  echo "<Pathway to fastq files> <Name of the fasta file>"
  exit 0
fi

docker pull quay.io/biocontainers/bowtie2:2.3.5--py27he860b03_0

chmod 777 $1

docker run --rm --user $(id -u):$(id -g) -v $1:/data/ quay.io/biocontainers/bowtie2:2.3.4.3--py36h2d50403_0 bowtie2-build \
/data/$2 /data/$2 > $1/runbowtie2index.log 2>&1 &
