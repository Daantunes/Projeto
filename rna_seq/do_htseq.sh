#!/bin/bash
#
if [ "$1" == "-h" ]; then
  echo "<Pathway to fastq files> <Name of the SAM file> <Name os the GTF/GFF file>"
  exit 0
fi

docker pull quay.io/biocontainers/htseq:0.11.2--py27h637b7d7_1

chmod 777 $1

docker run --rm --user $(id -u):$(id -g) -v $1:/data/ biocontainers/htseq:0.11.2--py27h637b7d7_1 htseq-count \
-m=intersection-strict --stranded=no -t=gene $2 $3 \
 > runhtseq.log 2>&1 &
