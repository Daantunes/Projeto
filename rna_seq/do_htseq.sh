#!/bin/bash
#12-05-2019

if [ "$1" == "-h" ]; then
  echo "<Pathway to fastq files> <Name of the SAM file> <Name os the GTF/GFF file>"
  exit 0
fi

docker pull quay.io/biocontainers/htseq:0.11.2--py27h637b7d7_1

chmod 777 $1

docker_id=$(docker run -d --rm --user $(id -u):$(id -g) -v $1:/data/ quay.io/biocontainers/htseq:0.11.2--py27h637b7d7_1 bash -c 'htseq-count \
-m=intersection-strict \
--stranded=no \
-t=gene /data/$2 /data/$3 \
> /data/htseq_counts.txt')

echo $docker_id



#docker run -d --rm --user $(id -u):$(id -g) -v /home/dantunes/rna_seq/results_T_SRR3737444.fastq.gz:/data/ quay.io/biocontainers/htseq:0.11.2--py27h637b7d7_1 \
#bash -c 'htseq-count \
#-m=intersection-strict \
#--stranded=no \
#-t=gene /data/Aligned.out.sam /data/Mus_musculus_c57bl6nj.C57BL_6NJ_v1.96.gtf \
#> /data/htseq_counts.txt'

