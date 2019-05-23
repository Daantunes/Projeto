#!/bin/bash
#24-04-2019

if [ "$1" == "-h" ]; then
  echo "<Pathway to fastq files> <Name of the fastq file>"
  exit 0
fi

docker pull biocontainers/fastqc:v0.11.5_cv3

chmod 777 $1

docker_id=$(docker run -d --rm --user $(id -u):$(id -g) -e INPUT=$2 -v $1:/data/ biocontainers/fastqc:v0.11.5_cv3 \
bash -c "fastqc $INPUT > /data/run$INPUT.log &")
echo $docker_id
