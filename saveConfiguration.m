function [ code, setup] = saveConfiguration(activationFunctions, activationFuntionOutput,trainningFunction, epochsNumber ,neuroNumber, trainningWeights,divFunc,setupName, ExcelFileName, sheetNumber,testAccuracy,globalAccuracy,net,tr, P, T, TInput ,TTargets)


filename = strcat('./save/',setupName,'.mat');
if exist(filename, 'file') == 2
    % File exists.
    filename=strcat('./save/','tmp','.mat');
    save(filename, 'activationFunctions', 'activationFuntionOutput', 'trainningFunction', 'epochsNumber', 'neuroNumber','trainningWeights','divFunc','testAccuracy','globalAccuracy','net','tr', 'P', 'T', 'TInput', 'TTargets');
    code = 409 ;
else
    % File does not exist.
    save(filename, 'activationFunctions', 'activationFuntionOutput', 'trainningFunction', 'epochsNumber', 'neuroNumber','trainningWeights','divFunc','testAccuracy','globalAccuracy','net','tr', 'P', 'T', 'TInput','TTargets');
    writeExcellFile(setupName,filename,sheetNumber, ExcelFileName);
    code = 200;
end

setup = filename;

end

