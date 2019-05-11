#!/bin/bash
if [ "$1" == "-h" ]; then
  echo "<Pathway to fastq files>"
  exit 0
fi

docker pull biocontainers/fastqc:v0.11.5_cv3

chmod 777 $1

#Para correr um background, mas caso haja erro aparece no ficheiro nohup.out
nohup bash -c "\

docker run --rm --user $(id -u):$(id -g) -v $1:/data/ biocontainers/fastqc:v0.11.5_cv3 \
fastqc *.fastq.gz \

2>&1 &"

