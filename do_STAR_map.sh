#!/bin/bash
#27-4-2019
if [ "$1" == "-h" ]; then
	echo "<Pathway to fastq files> <fastq file>"
	exit 0
fi

mkdir $1/results_$2

chmod 777 $1/genome
chmod 777 $1/results_$2

docker run -it --rm -v --user $(id -u):$(id -g) $1:/data/ quay.io/biocontainers/star:2.7.0f--0 STAR \
--runThreadN 16 \
--genomeDir /data/genome \
--readFilesIn /data/$2 \
--readFilesCommand gunzip -c \
--outFileNamePrefix /data/results_$2/ > $1/results_$2/run.log



