#!/bin/bash
#
if [ "$1" == "-h" ]; then
  echo "<Pathway to fastq files> <Name of the fastq file>"
  exit 0
fi

docker pull quay.io/biocontainers/htseq:0.11.2--py27h637b7d7_1

chmod 777 $1

docker run -it --rm --user $(id -u):$(id -g) -v $1:/data/ biocontainers/htseq:0.11.2--py27h637b7d7_1 htseq-count \
-m=intersection-strict --stranded=no -t gene - $GTF > $COUNTSDIR/$i\_counts
 > $1/results_$2/run.log

