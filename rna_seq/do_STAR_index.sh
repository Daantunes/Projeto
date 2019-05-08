#!/bin/bash
#27-4-2019
if [ "$1" == "-h" ]; then
	echo "<Pathway to fastq files> <Name of the genome file> <Name of the annotation file>"
	echo "Insert unziped files"
	exit 0
fi

docker pull quay.io/biocontainers/star:2.7.0f--0

mkdir $1/genome

chmod 777 $1/genome

docker run -d -it --rm -v $1:/data/ quay.io/biocontainers/star:2.7.0f--0 STAR \
--runThreadN 16\
--runMode genomeGenerate \
--genomeDir /data/genome \
--genomeFastaFiles /data/$2 \
--sjdbGTFfile /data/$3 \
--sjdbOverhang 99

echoerr() { printf "%s\n" "$*" >&2; }
echoerr ERROR



