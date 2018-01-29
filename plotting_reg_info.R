files <- dir(pattern = 'region_info.Rdata', full.names = TRUE, recursive = TRUE)
tissues <- gsub('\\./', '', dirname(files))

load_info <- function(f) {
    message(paste(Sys.time(), 'loading', f))
    load(f)
    return(regInfo)
}

regInfo <- do.call(rbind, lapply(files, load_info))

library('ggplot2')

## reordered 

ggplot(regInfo, aes(x = cutoff, y = mean, color = tissue)) + geom_point(size = 0.8) + geom_line() + scale_colour_manual(name = "Tissue", breaks = c("hypothalamus", "substantianigra", "amygdala", "hippocampus", "caudatebasalganglia", "nucleusaccumbensbasalganglia", "putamenbasalganglia", "anteriorcingulatexortexba24", "frontalcortexba9", "cortex", "spinalcordcervicalc-1", "brain_outfile"), labels = c("Hypothalamus", "Substantia Nigra", "Amygdala", "Hippocampus", "Basal Ganglia - Caudate", "Basal Ganglia - Nucleus Accumbens", "Basal Ganglia - Putamen", "Anterior Cingulate Cortex", "Frontal Cortex", "Cortex", "Spinal Cord (Cervical C-1)", "Brain"), values = c("#9933CC", "#FFFF66", "#009966", "#33FF99", "#3399CC", "#0000FF", "#006699", "#FF6600", "#FF3333", "#990033", "#993300", "#999999")) 

