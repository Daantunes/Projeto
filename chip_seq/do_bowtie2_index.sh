docker pull quay.io/biocontainers/bowtie2:2.3.5--py27he860b03_0

docker run -d -t -v $1:/data/ quay.io/biocontainers/bowtie2:2.3.4.3--py36h2d50403_0 bowtie2-build 
/data/$2 
