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

docker_id=$(docker run -d --rm --user $(id -u):$(id -g) -e INPUT1=$2 -e INPUT2=$3 -v $1:/data/ quay.io/biocontainers/star:2.7.0f--0 \
bash -c "STAR \
--runThreadN 16 \
--runMode genomeGenerate \
--genomeDir /data/genome \
--genomeFastaFiles /data/$INPUT1 \
--sjdbGTFfile /data/$INPUT2 \
--outFileNamePrefix /data/genome/ \
--sjdbOverhang 50 > /data/genome/runSTARindex.log &")

echo $docker_id

# Retirado de: ftp://ftp.ensembl.org/pub/release-96/fasta/mus_musculus_c57bl6nj/dna/
# wget ftp://ftp.ensembl.org/pub/release-96/fasta/mus_musculus_c57bl6nj/dna/Mus_musculus_c57bl6nj.C57BL_6NJ_v1.dna.toplevel.fa.gz
# gunzip Mus_musculus_c57bl6nj.C57BL_6NJ_v1.dna.toplevel.fa.gz &

# Retirado de: ftp://ftp.ensembl.org/pub/release-96/gtf/mus_musculus_c57bl6nj
# wget ftp://ftp.ensembl.org/pub/release-96/gtf/mus_musculus_c57bl6nj/Mus_musculus_c57bl6nj.C57BL_6NJ_v1.96.gtf.gz
# gunzip Mus_musculus_c57bl6nj.C57BL_6NJ_v1.96.gtf.gz &

