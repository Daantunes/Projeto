#!/bin/bash
#
if [ "$1" == "-h" ]; then
  echo "<Pathway to fastq files> <Name of the fastq file>"
  exit 0
fi

docker pull biocontainers/fastqc:v0.11.5_cv3

chmod 777 $1

docker run -d --rm -u "$(id -u):$(id -g)" -t -v $1:/data/ biocontainers/fastqc:v0.11.5_cv3 fastqc $2 \
 > $1/results_$2/run.log
