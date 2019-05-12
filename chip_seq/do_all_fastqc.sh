#!/bin/bash
#24-04-2019

if [ "$1" == "-h" ]; then
  echo "<Pathway to fastq files> <Name of the output directory>"
  exit 0
fi

docker pull biocontainers/fastqc:v0.11.5_cv3

chmod 777 $1

docker run --rm --user $(id -u):$(id -g) -v $1:/data/ biocontainers/fastqc:v0.11.5_cv3 \
fastqc *.fastq.gz --outdir=$1/$2 > runallfastq.log 2>&1 &

