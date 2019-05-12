#!/bin/bash
#12-05-2019

if [ "$1" == "-h" ]; then
  echo "<Pathway to fastq files> <Name of the SAM file>"
  exit 0
fi

docker pull docker pull quay.io/biocontainers/samtools:1.9--h8571acd_11

chmod 777 $1

docker run --rm --user $(id -u):$(id -g) -v $1:/data/ quay.io/biocontainers/samtools:1.9--h8571acd_11 samtools \
view -Sb /data/$2 -o /data/$2.bam \
 > runconvert2bam.log 2>&1 &

 # samtools requires us to run everything inside docker with bash -c 'commands' (it's needed because of the way the container script 
 #was build)
 # bash -c runs everything inside docker so even with '>' to redirect docker terminal output we redirect to a folder inside docker 
 #/data/; --user $(id -u):$(id -g) to have write permissions for user and group
 
#docker run -d --rm --user $(id -u):$(id -g) -t -v /home/tbarata/RNA_seq_analysis_20181019/Results/BJs/STAR_alignments/:/data/ 
#biocontainers/samtools:v1.3_cv2 bash -c 'cd /data/; for i in `ls`; do samtools sort $i/$i.bam -o $i/$i\_sorted.bam; samtools index 
#$i/$i\_sorted.bam; done;'
