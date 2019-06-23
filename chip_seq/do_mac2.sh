#!/bin/bash
#13-06-2019

if [ "$1" == "-h" ]; then
  echo "<Pathway to index files> <Name of the sam/bam file>"
  exit 0
fi

docker pull quay.io/biocontainers/macs2:2.1.2--py27r351h14c3975_1

docker run --rm --user $(id -u):$(id -g) -v $1:/data/ quay.io/biocontainers/macs2:2.1.2--py27r351h14c3975_1 macs2 \
callpeak -t /data/$2 --outdir /data/ > $1/counts_$2.log 2<&1 &



