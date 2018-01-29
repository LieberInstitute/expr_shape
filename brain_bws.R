library('recount')
library('devtools')
library('recount.bwtool')

metadata_full <-  all_metadata('gtex')
metadata_brain <- subset(metadata_full, smafrze == 'USE ME' & smts == 'Brain')
brain_bws <- recount_url$path[match(metadata_brain$bigwig_file, recount_url$file_name)]
compute_mean(bws = brain_bws, outfile = 'brain_outfile', tempdir = 'brain_tmpdir', chr_sizes = '/dcl01/leek/data/gtex_work/runs/gtex/hg38.sizes')

Sys.time()
proc.time()
options(width = 120)
session_info()