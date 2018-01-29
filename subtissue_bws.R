library('recount')
library('devtools')
library('recount.bwtool')

metadata_full <-  all_metadata('gtex')
metadata_brain <- subset(metadata_full, smafrze == 'USE ME' & smts == 'Brain')
metadata_subtissue <- split(metadata_brain, metadata_brain$smtsd)
tissue_file_names <- gsub('brain-', '', gsub(' ', '', tolower(names(metadata_subtissue))))
subtissue_of_interest <- as.numeric(Sys.getenv("SGE_TASK_ID"))
subtissue_outfile <- tissue_file_names[subtissue_of_interest]
subtissue_outfile <- gsub('\\)|\\(', '', subtissue_outfile)
subtissue_tmpdir <- paste0('temdpir_', subtissue_outfile)

subtissue_bws <-  recount_url$path[match(metadata_subtissue[[subtissue_of_interest]]$bigwig_file, recount_url$file_name)]
compute_mean(bws = subtissue_bws, outfile = subtissue_outfile, tempdir = subtissue_tmpdir, chr_sizes = '/dcl01/leek/data/gtex_work/runs/gtex/hg38.sizes')

Sys.time()
proc.time()
options(width = 120)
session_info()