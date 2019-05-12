#!/bin/bash
#24-04-2019

if [ "$1" == "-h" ]; then
  echo "<Pathway to fastq files> <Name of the fastq file>"
  exit 0
fi
docker pull quay.io/biocontainers/trimmomatic:0.39--1

chmod 777 $1

docker run --rm --user $(id -u):$(id -g) -v /usr/share/trimmomatic:/adapters/ \
-v $1:/data/ quay.io/biocontainers/trimmomatic:0.39--1 \
trimmomatic SE /data/$2 /data/T_$2 \
ILLUMINACLIP:$1/TruSeqALL-SE.fa:2:0:10 \
LEADING:0 \
TRAILING:0 \
SLIDINGWINDOW:0:0 \
MINLEN:36 > run$2.log 2>&1 &

