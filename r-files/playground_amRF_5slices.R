projectName <- 'amRF'
linkFileName <- 'amRF_link.txt'

baseDir <- '~/Dropbox/'
source('~/Dropbox/r-compile/signalProcessoR/R/signalProcessoR.R')
df           <- prepDFsignalProcessor(projectName, linkFileName)


tdf <- df[which(df$animal=='Soleil'&df$ElectrodeConfig=='ebbby'), ]

ndx          <- dim(tdf)[1]
dfline       <- tdf[ndx,]
print(dfline)

chStrRep <- c('ch500','ch177','ch334','ch321','ch173','ch179','ch17','ch322')[c(2,4,3,1,5,6,8,7)]
chStrRef <- c('ch501','ch109','ch430','ch209','ch144','ch148','ch1','ch326')[c(2,4,3,1,5,6,8,7)]
chStrReg <- c('A1',   'BST',  'Thl',  'IC','Cb','ParCx','EEG','F1')[c(2,4,3,1,5,6,8,7)]


chPosMes <- getMePhyspos(paste('ch',1:513,sep=''))
getChNdx    <- function(cs){ which(chPosMes %in% cs)}
chStrRepNdx <- sapply(chStrRep, getChNdx)
chStrRefNdx <- sapply(chStrRef, getChNdx)

chn                       <- loadSignalProcessor( tdf[ndx,], chStr=chStrRep, epoch='llp')
chn$channelPosition$chStr <- chStrReg

showSignalProcessor( chn, frml=~ampInd, subsExpr = expression(valTone, ampInd<6), trng=c(-15,175))
showSignalProcessor( chn, frml=~freqInd, subsExpr = expression(valTone, ampInd<6), trng=c(-15,175))





