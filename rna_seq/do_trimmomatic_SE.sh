#!/bin/bash
#24-04-2019

if [ "$1" == "-h" ]; then
  echo "<Pathway to fastq files> <Name of the fastq file>"
  exit 0
fi
docker pull quay.io/biocontainers/trimmomatic:0.39--1

chmod 777 $1

docker_id=$(docker run -d --rm --user $(id -u):$(id -g) -e INPUT=$2 -v $1:/data/ quay.io/biocontainers/trimmomatic:0.39--1 \
bash -c "trimmomatic SE /data/$INPUT /data/T_$INPUT \
ILLUMINACLIP:/data/TruSeqALL-SE.fa:2:0:10 \
LEADING:0 \
TRAILING:0 \
SLIDINGWINDOW:0:0 \
MINLEN:36 > /data/run$INPUT.log &")

echo $docker_id
