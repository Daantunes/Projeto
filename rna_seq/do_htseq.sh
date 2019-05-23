#!/bin/bash
#12-05-2019

if [ "$1" == "-h" ]; then
  echo "<Pathway to fastq files> <Name of the SAM file> <Name os the GTF/GFF file>"
  exit 0
fi

docker pull quay.io/biocontainers/htseq:0.11.2--py27h637b7d7_1

chmod 777 $1

docker_id=$(docker run -d --rm --user $(id -u):$(id -g) -e INPUT1=$2 -e INPUT2=$3 -v $1:/data/ quay.io/biocontainers/htseq:0.11.2--py27h637b7d7_1 \
bash -c "htseq-count \
-m=intersection-strict \
--stranded=no \
-t=gene \
-o=/data/htseq_counts.sam /data/$INPUT1 /data/$INPUT2 \
> /data/runhtseq.log &")

echo $docker_id

