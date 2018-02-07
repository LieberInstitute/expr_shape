library('ggplot2')

chrInfo <- read.table('/dcl01/leek/data/gtex_work/runs/gtex/hg38.sizes',
    header = FALSE, stringsAsFactors = FALSE, col.names = c('chr', 'length'))
chrInfo <- subset(chrInfo, chr %in% paste0('chr', c(1:22, 'X', 'Y', 'M')))

files <- dir(pattern = 'region_info.Rdata', full.names = TRUE, recursive = TRUE)
tissues <- gsub('\\./', '', dirname(files))
load_info <- function(f) {
    message(paste(Sys.time(), 'loading', f))
    load(f)
    return(regInfo)
}
regInfo <- do.call(rbind, lapply(files, load_info))
regInfo$percent <- regInfo$mean * regInfo$n / sum(as.numeric(chrInfo$length)) * 100
pdf('pdf/regInfo_percent.pdf')
ggplot(regInfo, aes(x = cutoff, y = percent, color = tissue)) + geom_point(size = 0.8) + geom_line() + scale_colour_manual(name = "Tissue", breaks = c("hypothalamus", "substantianigra", "amygdala", "hippocampus", "caudatebasalganglia", "nucleusaccumbensbasalganglia", "putamenbasalganglia", "anteriorcingulatecortexba24", "frontalcortexba9", "cortex", "spinalcordcervicalc-1", "brain_outfile"), labels = c("Hypothalamus", "Substantia Nigra", "Amygdala", "Hippocampus", "Basal Ganglia - Caudate", "Basal Ganglia - Nucleus Accumbens", "Basal Ganglia - Putamen", "Anterior Cingulate Cortex", "Frontal Cortex", "Cortex", "Spinal Cord (Cervical C-1)", "Brain"), values = c("#66CC00","#FF6600", "#999999", "#3399CC", "#CC6633", "#FF3333", "#336600", "#9933CC", "#0000FF", "#006699", "#990033", "#FFCC00")) + ylab('Percent of the genome')

dev.off()

proc.time()
Sys.time()
options(width = 120)
session_info()