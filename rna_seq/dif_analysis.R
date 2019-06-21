library(DESeq2)
library(edgeR)

counts = read.table('COUNTS.tab', h=T, row.names=1)
condition = factor(c('WT','WT','WT','KO','KO','KO'))

#Remove Lines With no Counts
dim(counts)
counts = counts[rowSums(counts)>1,]
dim(counts)

sampleTable=data.frame(c('WT','WT','WT','KO','KO','KO'))
colnames(sampleTable)[1]= 'condition'
rownames(sampleTable)=colnames(counts)

#DESeq2
dds = DESeqDataSetFromMatrix(countData = counts ,colData = sampleTable, 
                              design = ~ condition)
dds = DESeq(dds)

resFDR = results(dds, contrast=c("condition","KO","WT"), alpha = 0.05)
summary(resFDR)
# know how many genes had adjusted p-value < 0.05
table(resFDR$padj < 0.05) #TRUE says how many
resFDR = as.data.frame(resFDR)
resFDR = resFDR[!is.na(resFDR$padj),]
# select just genes < 0.05:
resFDR = resFDR[resFDR$padj < 0.05,]
dim(resFDR)

resFDR.down = resFDR[resFDR$log2FoldChange < 1,]
dim(resFDR.down)
resFDR.down

resFDR.up = resFDR[resFDR$log2FoldChange > 1,]
dim(resFDR.up)
resFDR.up


#EdgeR
y <- DGEList(counts=counts[,1:6], group = condition)
y <- calcNormFactors(y)
design <- model.matrix(~condition)

y <- estimateDisp(y,design)
et <- exactTest(y, pair=c("WT","KO"))
out <- topTags(et, n=Inf)

down <- out$table$FDR <= 0.05 & out$table$logFC <= -1
dim(out[down,])
out[down,]

up <- out$table$FDR <= 0.05 & out$table$logFC >= 1
dim(out[up,])
out[up,]
