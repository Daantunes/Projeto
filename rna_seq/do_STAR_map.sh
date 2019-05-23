#!/bin/bash
#27-4-2019
if [ "$1" == "-h" ]; then
	echo "<Pathway to fastq files> <fastq file>"
	exit 0
fi

mkdir $1/results_$2

chmod 777 $1/genome
chmod 777 $1/results_$2

docker_id=$(docker run -d --rm --user $(id -u):$(id -g) -e INPUT=$2 -v $1:/data/ quay.io/biocontainers/star:2.7.0f--0 \
bach -c "STAR \
--runThreadN 16 \
--genomeDir /data/genome \
--readFilesIn /data/$INPUT \
--readFilesCommand gunzip -c \
--outFileNamePrefix /data/results_$INPUT/ > /data/results_$INPUT/run.log &")

echo $docker_id





