#!/bin/bash
#11-05-2019

if [ "$1" == "-h" ]; then
  echo "<Pathway to fastq files>"
  exit 0
fi

cp /usr/local/share/trimmomatic/adapters/TruSeq2-SE.fa $1/TruSeqALL-SE.fa
chmod 777 $1/TruSeqALL-SE.fa
printf "\n" >> $1/TruSeqALL-SE.fa
cat /usr/local/share/trimmomatic/adapters/TruSeq3-SE.fa >> $1/TruSeqALL-SE.fa
