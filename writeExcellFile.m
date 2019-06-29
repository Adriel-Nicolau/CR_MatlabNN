function [ code ] = writeExcellFile(setupName, workspacename , sheet , excelFileName )


workspace = load(workspacename);
sizeFA = size(workspace.activationFunctions);
sizeFA = sizeFA(2);

A = {'Nome do Treino';'';'Função Treino';' ';'Camadas';      'Layer 1';'Layer 2';'Layer 3'; 'Layer 4';'Output'; ' '; ' ';'Precisoa Treino';'Precisao Global'};
if(sizeFA==4)
    B = {setupName;''; convertConstants(workspace.trainningFunction);' '; 'Nº Neuronios'; num2str(workspace.neuroNumber(1)); num2str(workspace.neuroNumber(2)); num2str(workspace.neuroNumber(3)); num2str(workspace.neuroNumber(4)); ' ' ; ' '; ' ';workspace.testAccuracy;workspace.globalAccuracy};
    C = {' ';' ';' ';' '; 'Funcao de Activacao'; convertConstants(workspace.activationFunctions(1)); convertConstants(workspace.activationFunctions(2)); convertConstants(workspace.activationFunctions(3)); convertConstants(workspace.activationFunctions(4)); convertConstants(workspace.activationFuntionOutput) ; ' '; ' ';' ';' '};
elseif(sizeFA==3)
    B = {setupName;''; convertConstants(workspace.trainningFunction);' '; 'Nº Neuronios'; num2str(workspace.neuroNumber(1)); num2str(workspace.neuroNumber(2)); num2str(workspace.neuroNumber(3)); ' '; ' ' ; ' '; ' ';workspace.testAccuracy;workspace.globalAccuracy};
    C = {' ';' ';' ';' '; 'Funcao de Activacao'; convertConstants(workspace.activationFunctions(1)); convertConstants(workspace.activationFunctions(2)); convertConstants(workspace.activationFunctions(3)); ' '; convertConstants(workspace.activationFuntionOutput) ; ' '; ' ';' '; ' '};
elseif(sizeFA==2)
    B = {setupName;''; convertConstants(workspace.trainningFunction);' '; 'Nº Neuronios'; num2str(workspace.neuroNumber(1)); num2str(workspace.neuroNumber(2)); ' '; ' '; ' ' ; ' '; ' ';workspace.testAccuracy;workspace.globalAccuracy};
    C = {' ';' ';' ';' '; 'Funcao de Activacao'; convertConstants(workspace.activationFunctions(1)); convertConstants(workspace.activationFunctions(2)); ' '; ' '; convertConstants(workspace.activationFuntionOutput) ; ' '; ' ';' ';' '};
else
    B = {setupName;''; convertConstants(workspace.trainningFunction);' '; 'Nº Neuronios'; num2str(workspace.neuroNumber(1)); ' '; ' '; ' '; ' ' ; ' '; ' ';workspace.testAccuracy;workspace.globalAccuracy};
    C = {' ';' ';' ';' '; 'Função de Activacao'; convertConstants(workspace.activationFunctions(1)); ' '; ' '; ' '; convertConstants(workspace.activationFuntionOutput) ; ' '; ' ';' ';' '};
end
D = {' ';' ';' ';' '; ' '; ' '; ' '; ' '; ' '; ' '; ' '; ' ';' ';' '};
E = {' ';' ';' ';' '; 'Funcao de Divisao '; 'Trainning'; 'Validation '; 'Testing '; ' '; ' '; ' '; ' ';' ';' '};
if(workspace.divFunc~= -1)
    F = {' ';' ';' ';'Divisao dos Exemplos'; convertConstants(workspace.divFunc); strcat(num2str(workspace.trainningWeights(1)),'%'); strcat(num2str(workspace.trainningWeights(2)),'%'); strcat(num2str(workspace.trainningWeights(3)),'%'); ' '; ' '; ' '; ' ';' ';' '};
else
    F = {' ';' ';' ';'Divisao dos Exemplos'; ' '; ' '; ' '; ' '; ' '; ' '; ' '; ' ';' ';' '};
end



G = [A B C D E F];

xlswrite(excelFileName,G,sheet)
 code = 200;

end

