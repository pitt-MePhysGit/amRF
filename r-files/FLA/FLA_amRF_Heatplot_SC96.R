FLA_amRF_Heatplot_SC96 <- function(projectName, linkFileName, ndx){
  
  baseDir <- '~/Dropbox/'
  source('~/Dropbox/r-compile/signalProcessoR/R/signalProcessoR.R')
  df           <- prepDFsignalProcessor(projectName, linkFileName)
  dfline       <- df[ndx,]
  epochStrList <- c('llp','mua','raw')

  plotDir <- 'heatPlotSC96'
    
  # ===============================================
  # load libraries and functions

  
  # use all available channels
  chStr                     <- paste('ch', 34:129,sep='')
  
  for (ex in 1:length(epochStrList)){

    tn                        <- loadSignalProcessor(  dfline,chStr=chStr, project='TRF', epoch=epochStrList[ex], analysis='ampInd_freqInd',blrng=c(-10,0) )
    tn$channelPosition        <- getSC96pos()

    
    .GlobalEnv$pp   <- function(){paste('/Volumes/Drobo5D3/channelPlots/',tn$project,'/',plotDir,'/',tn$epoch, '/',sep='')}#/',tn$dfline$session,'/',sep='')}
    if (!exists(pp()))
      system(paste('mkdir -p ', pp() ))
    
    
    # pre-screen to get the range of values for this recording and signal type
    trfmapList <- showSignalProcessorWrapper(tn, plotFUN=wrapper_TRF_HeatPlot, to.rangeY = c(0,.7), zlim=c(0,80) )
    trfmapMat  <- array( unlist(trfmapList), c(dim(trfmapList[[1]]),length(trfmapList)) )    
    mxVal <- quantile( apply(trfmapMat,c(3),max), probs=.95 )
    
    
    # the actual figure:
    eps.file2(paste(tn$dfline$session,'_heatplot.eps',sep=''),pdf=T,pp=pp,s=4.5,ratio=1)
    trfmapList <- showSignalProcessorWrapper(tn, plotFUN=wrapper_TRF_HeatPlot, to.rangeY = c(0,.7), zlim=c(0,mxVal) )
    dev.off()
    
  }
}





