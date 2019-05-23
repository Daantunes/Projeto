#!/bin/bash
#11-05-2019

if [ "$1" == "-h" ]; then
  echo "<Pathway to BAM file> <Name of the SAM file> <Name of the GTF file>"
  exit 0
fi

docker pull quay.io/biocontainers/qualimap:2.2.2b--1

docker_id=$(docker run -d --rm --user $(id -u):$(id -g) -e INPUT1=$2 -e INPUT2=$3 -v $1:/data/ quay.io/biocontainers/qualimap:2.2.2b--1 \
bash -c "qualimap \
rnaseq -bam /data/$INPUT1 \
-gtf /data/$INPUT2 \
-outformat PDF:HTML \
-outfile /data/Qualimap_$INPUT1 \
-outdir /data/results_qualimap \
--java-mem-size=5G > /data/results_qualimap/run.log &")

echo $docker_id
