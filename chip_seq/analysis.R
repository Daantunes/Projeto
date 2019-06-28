library(ChIPseeker)
library(TxDb.Mmusculus.UCSC.mm10.knownGene)
library(org.Mm.eg.db)
library(VennDiagram)
library(rtracklayer)
library(DBI)
library(ChIPpeakAnno)
library(biomaRt)
library(ggplot2)

txdb <- TxDb.Mmusculus.UCSC.mm10.knownGene

# Get annotations and create a piechart
peak <- readPeakFile('counts_T_SRR3737445.fastq.gz.sam_peaks.narrowPeak.bed')

peakAnno <- annotatePeak(peak, TxDb=txdb, annoDb="org.Mm.eg.db")
df <- data.frame(
label=c('Promoter (27.45%)', '5 UTR (0.09%)', '3 UTR (0.91%)' , 'Exon (3.33%)', 'Intron (35.70%)', 'Downstream (0.89%)', 'Distal Intergenic (31.63%)'),
perc=c(19.07339251+4.76293570+3.61550119,0.08659883,0.90928772,1.21238363+2.12167136,13.24962113+22.45074691,0.88763802,31.63022299))

#Create file with piechart
pdf('pie.pdf',height=4,width=6)
p <- ggplot(data=df, aes(x="", y = perc, fill=label, xlab="")) +
  geom_bar(width = 1, stat = "identity") + coord_polar("y", start=0)
blank_theme <- theme_minimal()+
  theme(
    axis.title.x = element_blank(),
    axis.title.y = element_blank(),
    axis.text.x=element_blank(),
    panel.border = element_blank(),
    panel.grid=element_blank(),
    axis.ticks = element_blank(),
    plot.title=element_text(size=14, face="bold")
  )

p + scale_fill_brewer(palette = "RdBu") + blank_theme
dev.off()

# Get annotations and filter by per binding site < 10 kb
ensembl=useMart("ensembl")
ensembl = useMart("ensembl",dataset="mmusculus_gene_ensembl")
mouse <- useEnsembl(biomart = "ensembl", dataset = "mmusculus_gene_ensembl", version = "75")
m.anno <- getAnnotation(mouse)


extraCols_narrowPeak <- c(signalValue = "numeric", pValue = "numeric", qValue = "numeric", peak = "integer")
gr_narrowPeak <- import("counts_T_SRR3737445.fastq.gz.sam_peaks.narrowPeak", format = "BED", extraCols = extraCols_narrowPeak)
annotatedPeak <- annotatePeakInBatch(gr_narrowPeak,AnnotationData = m.anno)

genes <- genes(txdb)
tss <- resize(genes, width=1, fix="start")
d <- distanceToNearest(annotatedPeak, tss)
dist <- mcols(d)[,1]
close.Hits <- d[dist <= 10000,]
chip.genes <- genes[subjectHits(close.Hits)]
names(chip.genes)

# Change annotation from ENTREZID to ENSEMBL
chip = mapIds(org.Mm.eg.db, keys=names(chip.genes), column="ENSEMBL", keytype="ENTREZID", multiVals="first")
chip=as.list(chip)
length(chip)

# Upload results from RNA-seq
rna = scan('rna.txt', what='', sep='\n')
rna=as.list(rna)
length(rna)


#Create file with venn diagram
pdf('venn.pdf',height=7,width=7)
venn.plot <- draw.pairwise.venn(area1           = length(rna),
                                area2           = length(chip),
                                cross.area      = length(intersect(rna, chip)),
                                category        = c("Differentially \n expressed \n genes", "Genes with Sox2 \n occupancy within \n 10 kb of the TSS"),
                                fill            = c("orange", "blue"),
                                lty             = "blank",
                                cex             = 3,
                                cat.cex         = 2,
                                cat.pos         = c(360, 25),
                                cat.dist        = 0.05,
                                cat.just        = list(c(0.65, 0.55), c(0.54, 0.2)),
                                ext.pos         = 2,
                                ext.dist        = -0.04,
                                ext.length      = 0.9,
                                ext.line.lwd    = 2)

dev.off()

