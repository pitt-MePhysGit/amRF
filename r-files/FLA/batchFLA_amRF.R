batchFLA_TRF <- function(projectName, linkFileName, ndx){
  
  source('~/Dropbox/r-compile/signalProcessoR/R/signalProcessoR.R')
  sourceDir( paste( '~/Dropbox/',projectName,'/r-files/FLA/',sep='')  )
  
  df          <- prepDFsignalProcessor(projectName, linkFileName)
  dfline      <- df[ndx,]
  
 
  # extract FFR kernels and make FFR tracking plots for each channel 
  run_amRF_Heatplot_SC96 <- TRUE
  run_amRF_multiplot     <- TRUE

  
  if (run_amRF_Heatplot_SC96)
    FLA_amRF_Heatplot_SC96( projectName, linkFileName, ndx )  
  
  if (run_amRF_multiplot)
    FLA_amRF_multiplot( projectName, linkFileName, ndx )  
  
}