#!/bin/bash
if [ "$1" == "-h" ]; then
  echo "<Pathway to fastq files>"
  exit 0
fi

docker pull biocontainers/fastqc:v0.11.5_cv3

chmod 777 $1

docker run -it --rm --user $(id -u):$(id -g) -v $1:/data/ biocontainers/fastqc:v0.11.5_cv3 \
fastqc *.fastq.gz > $1/results_$2/run.log
