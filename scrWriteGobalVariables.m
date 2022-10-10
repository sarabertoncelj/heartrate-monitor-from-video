%% write global variables 

GV.fsDeafult = 30;
GV.fDTFTMin = 0;
GV.fDTFTMax = GV.fsDeafult/2;
GV.fNumOfPoints = 2000;
GV.DTFTFreqResolution = (GV.fDTFTMax-GV.fDTFTMin)/GV.fNumOfPoints;
GV.fFirMin = 0.8;
GV.fFirMax = 6;
GV.Nfir = 50;
GV.FilteredDataOffset = 90;
GV.colorChannel = 2;
GV.HRDeviation = 2;
GV.HRBand_deltaK = ceil(GV.HRDeviation/GV.DTFTFreqResolution/60);
GV.nX = 15; 
GV.nY = 15;

save('GlobalVariables.mat', 'GV')