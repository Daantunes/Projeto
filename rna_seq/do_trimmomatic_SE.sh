#!/bin/bash
if [ "$1" == "-h" ]; then
  echo "<Pathway to fastq files> <Name of the fastq file>"
  exit 0
fi
docker pull quay.io/biocontainers/trimmomatic:0.39--1

chmod 777 $1

docker run -it --rm --user $(id -u):$(id -g) -v /usr/share/trimmomatic:/adapters/ \
-v $1:/data/ quay.io/biocontainers/trimmomatic:0.39--1 \
trimmomatic SE /data/$2 /data/T_$2 \
ILLUMINACLIP:/adapters/TruSeq3-SE.fa:2:30:10 \
MINLEN:36 > $1/results_$2/run.log

