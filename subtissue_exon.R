library('SummarizedExperiment')
library('recount')
library('devtools')

load("rse_exon_brain.Rdata", verbose = TRUE)

chrInfo <- read.table('/dcl01/leek/data/gtex_work/runs/gtex/hg38.sizes',
    header = FALSE, stringsAsFactors = FALSE, col.names = c('chr', 'length'))
chrInfo <- subset(chrInfo, chr %in% paste0('chr', c(1:22, 'X', 'Y', 'M')))


subtissue_of_interest <- as.numeric(Sys.getenv('SGE_TASK_ID'))
if(FALSE) {
	## for testing
	subtissue_of_interest <- 1
}

#Rename files 
tissue_file_names <- gsub('brain-', '', gsub(' ', '', tolower(unique(colData(rse_exon)$smtsd))))

#Separate brain overall and subtissues
if(subtissue_of_interest == 14) {
	rse_exon <- rse_exon[, colData(rse_exon)$smafrze == 'USE ME']
	subtissue_outfile <- 'brain_outfile'
} else {
	subtissue_outfile <- tissue_file_names[subtissue_of_interest]
    subtissue_outfile <- gsub('\\)|\\(', '', subtissue_outfile)
	rse_exon <- rse_exon[, colData(rse_exon)$smtsd == unique(colData(rse_exon)$smtsd)[subtissue_of_interest] & colData(rse_exon)$smafrze == 'USE ME']
}

counts <- assays(scale_counts(rse_exon))$counts * 100

## Get exon length
exonic_length <-  width(rowRanges(rse_exon)) 
counts_per_base <- counts / exonic_length
mean_expr <-  rowMeans(counts_per_base)

cuts <- seq(0.2, 15, by = 0.1)

passing <- sapply(cuts, function(cut) { which( mean_expr > cut) })
names(passing) <- cuts

meanLength <- sapply(passing, function(i) { if(length(i) == 0) return (0); mean(exonic_length[i]) })

medianLength <- sapply(passing, function(i) { if(length(i) == 0) return (0); median(exonic_length[i]) })

iqrLength <- sapply(passing, function(i) { if(length(i) == 0) return (0); IQR(exonic_length[i]) })

#Combine information into data frame 
exonInfo <- data.frame( cutoff = cuts, mean = meanLength, median = medianLength, IQR = iqrLength, tissue = subtissue_outfile, n = sapply(passing, length), stringsAsFactors = FALSE)

exonInfo$percent <- exonInfo$mean * exonInfo$n / sum(as.numeric(chrInfo$length)) * 100

save(exonInfo,
    file = file.path(subtissue_outfile, paste0('exon_info', '.Rdata')))

proc.time()
Sys.time()
options(width = 120)
session_info()