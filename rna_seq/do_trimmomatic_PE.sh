#!/bin/bash
#24-04-2019

if [ "$1" == "-h" ]; then
	echo "<Pathway to fastq files> <Name of the first fastq file> <Name of the second fastq file>"
	exit 0
fi
docker pull quay.io/biocontainers/trimmomatic:0.39--1

chmod 777 $1

docker run -it --rm --user $(id -u):$(id -g) -v /usr/share/trimmomatic:/adapters/ \
-v $1:/data/ quay.io/biocontainers/trimmomatic:0.39--1 \
trimmomatic PE /data/$2 /data/$3 /data/TP_$2 /data/TU_$2 /data/TP_$3 /data/TU_$3 \
ILLUMINACLIP:/adapters/TruSeq3-PE.fa:2:30:10 \
MINLEN:36 > $1/results_$2/run.log


