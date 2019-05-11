#!/bin/bash
if [ "$1" == "-h" ]; then
  echo "<Pathway to fastq files> <Name of the fastq file>"
  exit 0
fi
docker pull quay.io/biocontainers/trimmomatic:0.39--1

chmod 777 $1

cp /adapters/TruSeq2-SE.fa $1/TruSeqALL-SE.fa
printf "\n" >> $1/TruSeqALL-SE.fa
cat /adapters/TruSeq3-SE.fa >> $1/TruSeqALL-SE.fa

docker run -it --rm --user $(id -u):$(id -g) -v /usr/share/trimmomatic:/adapters/ \
-v $1:/data/ quay.io/biocontainers/trimmomatic:0.39--1 \
trimmomatic SE /data/$2 /data/T_$2 \
ILLUMINACLIP:$1/TruSeqALL-SE.fa:2:0:10 \
LEADING:0 \
TRAILING:0 \
SLIDINGWINDOW:0:0 \
MINLEN:36 > $1/results_$2/run.log

