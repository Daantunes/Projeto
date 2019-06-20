#!/bin/bash
#27-4-2019
if [ "$1" == "-h" ]; then
	echo "<Pathway to fastq files> <Name of the genome file> <Name of the annotation file>"
	echo "Insert unzipped files"
	exit 0
fi

docker pull quay.io/biocontainers/star:2.7.0f--0

mkdir $1/genome

chmod 777 $1/genome

docker run --rm --user $(id -u):$(id -g) -v $1:/data/ quay.io/biocontainers/star:2.7.0f--0 STAR \
--runThreadN 16 \
--runMode genomeGenerate \
--genomeDir /data/genome \
--genomeFastaFiles /data/$2 \
--sjdbGTFfile /data/$3 \
--sjdbOverhang 50 > $1/genome/runSTARindex.log 2<&1 &


# Retirado de: ftp://ftp.ensembl.org/pub/release-96/fasta/mus_musculus_c57bl6nj/dna/
# wget ftp://ftp.ensembl.org/pub/release-96/fasta/mus_musculus_c57bl6nj/dna/Mus_musculus_c57bl6nj.C57BL_6NJ_v1.dna.toplevel.fa.gz
# gunzip Mus_musculus_c57bl6nj.C57BL_6NJ_v1.dna.toplevel.fa.gz &

# Retirado de: ftp://ftp.ensembl.org/pub/release-96/gtf/mus_musculus_c57bl6nj
# wget ftp://ftp.ensembl.org/pub/release-96/gtf/mus_musculus_c57bl6nj/Mus_musculus_c57bl6nj.C57BL_6NJ_v1.96.gtf.gz
# gunzip Mus_musculus_c57bl6nj.C57BL_6NJ_v1.96.gtf.gz &

