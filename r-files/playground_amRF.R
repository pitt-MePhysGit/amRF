projectName <- 'amRF'
linkFileName <- 'amRF_link.txt'

baseDir <- '~/Dropbox/'
source('~/Dropbox/r-compile/signalProcessoR/R/signalProcessoR.R')
df           <- prepDFsignalProcessor(projectName, linkFileName)

ndx <- 5:10
dfline       <- df[ndx,]
print(dfline)


#ana                 <- loadSignalProcessor(  dfline,chStr='ch135', project=projectName, epoch='raw',blrng=c(-10,0) )


chStr <- paste('ch',34:129,sep='')
raw                 <- loadSignalProcessor(  dfline,chStr=chStr, project=projectName, epoch='raw', analysis='ampInd_freqInd',blrng=c(-10,0) )
raw$channelPosition <- getSC96pos()

mua                 <- loadSignalProcessor(  dfline,chStr=chStr, project=projectName, epoch='mua', analysis='ampInd_freqInd',blrng=c(-10,0) )
mua$channelPosition <- getSC96pos()


rawGA <- avgSignalProcessor( raw, frml=~ampInd*freqInd)
muaGA <- avgSignalProcessor( mua, frml=~ampInd*freqInd)


showSignalProcessor( rawGA, frml=~ampInd, subsExpr = expression(ampInd<=5), trng=c(-50,450), vlineat = c(125,225) )


showSignalProcessorDPMap(raw, IVstr='ampInd',IVbyStr='dummy', nrm=T,lognrm = F, zlim=c(-5,5), trng = c(0,50))
showSignalProcessorDPMap(raw, IVstr='ampInd',IVbyStr='dummy', nrm=T,lognrm = F, zlim=c(-5,5), trng = c(125,225))

showSignalProcessor( mua )


showSignalProcessorXYC(raw, xaxis = 'freqInd', yaxis='dummy', caxis='ampInd', chIndx=20, trng=c(-50,250), scl='numeric', sclfctr = 200 )
showSignalProcessorXYC(mua, xaxis = 'ampInd', yaxis='dummy', caxis='freqInd', chIndx=60, trng=c(-10,450), scl='numeric', sclfctr = 4, tsqueezrng = c(0,.85) )

showSignalProcessor( mua )


disc <- showSignalProcessorWrapper(rawGA, plotFUN=wrapper_TRF_HeatPlot, to.rangeY = c(0,.7), trng=c(200,450),from.rangeX=c(1,16),zlim=c(0,30)  )
disc <- showSignalProcessorWrapper(muaGA, plotFUN=wrapper_TRF_HeatPlot, to.rangeY = c(0,.7), trng=c(200,450),from.rangeX=c(1,16),zlim=c(0,.5)  )
