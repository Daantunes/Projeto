#!/bin/bash
#11-05-2019

if [ "$1" == "-h" ]; then
  echo "<Local for the final_results directory>"
  exit 0
fi

mkdir $1/final_results
chmod 777 $1/final_results
grep "^MGP" $1/results_T_SRR3737439.fastq.gz/htseq_counts.readcounts > /$1/final_results/C439.readcounts
grep "^MGP" $1/results_T_SRR3737440.fastq.gz/htseq_counts.readcounts > /$1/final_results/C440.readcounts
grep "^MGP" $1/results_T_SRR3737441.fastq.gz/htseq_counts.readcounts > /$1/final_results/C441.readcounts
grep "^MGP" $1/results_T_SRR3737442.fastq.gz/htseq_counts.readcounts > /$1/final_results/C442.readcounts
grep "^MGP" $1/results_T_SRR3737443.fastq.gz/htseq_counts.readcounts > /$1/final_results/C443.readcounts
grep "^MGP" $1/results_T_SRR3737444.fastq.gz/htseq_counts.readcounts > /$1/final_results/C444.readcounts

echo "geneid WT1 WT2 WT3 KO1 KO2 KO3" > $1/final_results/COUNTS.tab

paste $1/final_results/*.readcounts | cut -f1,2,4,6,8,10,12 >> $1/final_counts/COUNTS.tab

