library('ggplot2')
files <- dir(pattern = 'exon_info.Rdata', full.names = TRUE, recursive = TRUE)
tissues <- gsub('\\./', '', dirname(files))

load_info <- function(f) {
    message(paste(Sys.time(), 'loading', f))
    load(f)
    return(exonInfo)
}

exonInfo <- do.call(rbind, lapply(files, load_info))

ggplot(exonInfo, aes(x = cutoff, y = mean, color = tissue)) + geom_point(size = 0.02) + geom_line() + scale_colour_manual(name = "Tissue", breaks = c("hypothalamus", "substantianigra", "amygdala", "hippocampus", "caudatebasalganglia", "nucleusaccumbensbasalganglia", "putamenbasalganglia", "cerebellum", "cerebellarhemisphere", "anteriorcingulatecortexba24", "frontalcortexba9", "cortex", "spinalcordcervicalc-1", "brain_outfile"), labels = c("Hypothalamus", "Substantia Nigra", "Amygdala", "Hippocampus", "Basal Ganglia - Caudate", "Basal Ganglia - Nucleus Accumbens", "Basal Ganglia - Putamen", "Cerebellum", "Cerebellar Hemisphere", "Anterior Cingulate Cortex", "Frontal Cortex", "Cortex", "Spinal Cord (Cervical C-1)", "Brain"), values = c("#66CC00","#FF6600", "#999999", "#3399CC", "#CC6699", "#FF99CC", "#CC6633", "#FF3333", "#336600", "#9933CC", "#0000FF", "#006699", "#990033", "#FFCC00"))

dev.off()

proc.time()
Sys.time()
options(width = 120)
session_info()