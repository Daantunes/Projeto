    
#!/bin/bash
#12-05-2019

if [ "$1" == "-h" ]; then
  echo "<Pathway to index files> <Name of the fasta file used in index> <Name of the fastq file>"
  exit 0
fi

docker pull quay.io/biocontainers/bowtie2:2.3.5--py27he860b03_0

chmod 777 $1
mkdir -p $1/results
chmod 777 $1/results

docker run -d --rm --user $(id -u):$(id -g) -v $1:/data/ quay.io/biocontainers/bowtie2:2.3.4.3--py36h2d50403_0 bash -c 'bowtie2 \
-p 15 -q --no-unal \
-x /data/genome/$2 \
-U /data/$3 \
-S /data/results/counts_$3.sam > /data/results/counts_$3.txt'
