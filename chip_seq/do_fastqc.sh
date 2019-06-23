#!/bin/bash
#24-04-2019

if [ "$1" == "-h" ]; then
  echo "<Pathway to fastq files> <Name of the fastq file>"
  exit 0
fi

docker pull biocontainers/fastqc:v0.11.5_cv3

mkdir $1/fastqc
chmod 777 $1

docker run --rm --user $(id -u):$(id -g) -v $1:/data/ biocontainers/fastqc:v0.11.5_cv3 \
fastqc -o /data/fastqc /data/$2 > $1/fastqc/run$2.log 2>&1 &
