FLA_amRF_multiplot <- function(projectName, linkFileName, ndx){
  
  baseDir <- '~/Dropbox/'
  source('~/Dropbox/r-compile/signalProcessoR/R/signalProcessoR.R')
  df           <- prepDFsignalProcessor(projectName, linkFileName)
  dfline       <- df[ndx,]
  epochStrList <- c('llp','mua','raw')
  
  plotDir <- 'multiplot'
  
  # =============================================== find out how many channels were recorded
  Nbank       <- nchar(as.character(dfline$ElectrodeConfig))
  eConfigList <- lapply(1:Nbank, function(n){ substr(as.character(dfline$ElectrodeConfig),n,n)})
  NchanBank   <- NchanBankList[unlist(eConfigList)]
  Nchan       <- sum(NchanBank)
  
  
  # use all available channels
  chStr                     <- paste('ch', 1:129,sep='')
  
  for (ex in 1:length(epochStrList)){
    
    trng <- c(-10,250)
    if (epochStrList[ex]=='mua')
      trng <- c(-10,150)
    
    for (cx in 1:length(chStr)){
      tn                        <- loadSignalProcessor(  dfline,chStr=chStr[cx], project='TRF', epoch=epochStrList[ex], analysis='ampInd_freqInd',blrng=c(-10,0) )
      
      .GlobalEnv$pp   <- function(){paste('/Volumes/Drobo5D3/channelPlots/',tn$project,'/',plotDir,'/',tn$epoch, '/', chStr[cx], '/' ,sep='')}#/',tn$dfline$session,'/',sep='')}
      if (!exists(pp()))
        system(paste('mkdir -p ', pp() ))
      
      
      # the actual figure:
      eps.file2(paste(tn$dfline$session,'_multiplot.eps',sep=''),pdf=T,pp=pp,s=4.5,ratio=1)
      showSignalProcessorXYC(tn, xaxis = 'freqInd', yaxis='ampInd', caxis='dummy', trng=trng )
      dev.off()
      
    }
  }
}





