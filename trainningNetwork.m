function [ code , setup ] = trainningNetwork( activationFunctions, activationFuntionOutput,trainningFunction, epochsNumber ,neuroNumber, trainningWeights,divFunc,setupName,ExcelFileName, sheetNumber,dataset,treina,loadfile)
try
    globalAccuracy=0;
    length = size(activationFunctions);
    length =length(2);
    TInput = [];
    TTargets =[];
    treina
    loadfile
    resp =strcmp(loadfile,'0');
    resp
    if(treina==1 &&   strcmp(loadfile,'0'))
        net = feedforwardnet(neuroNumber);
        %Setup fun��o de activa��o das camadas escondidas
        for index=1:length
            func =convertConstants(activationFunctions(index));
            net.layers{index}.transferFcn = func;
        end
        
        %Setup fun��o de activa��o da camada de saida
        net.layers{index+1}.transferFcn = convertConstants(activationFuntionOutput);
        
        net.trainParam.epochs = epochsNumber;
        
        %Setup da fun��o de treino
        net.trainFcn =convertConstants(trainningFunction) ; %'traingd';
        
        %Todos os exemplos s�o usados para treino
        if( trainningWeights(1)==100)
            net.divideFcn = '';
        else
            %� utilziado uma fun��o de divis�o e racios
            net.divideFcn = convertConstants(divFunc);
            net.divideParam.trainRatio = trainningWeights(1)/100;
            net.divideParam.valRatio =  trainningWeights(2)/100;
            net.divideParam.testRatio =  trainningWeights(3)/100;
        end
    end
    %apanha o dataset correspondeente
    [P, T] = getDataSet(dataset);
    
    if(strcmp(dataset,'Formas_1'))
        %TREINAR A REDE
        [net,tr] = train(net, P, T);
        
        % SIMULAR
        outTrain = sim(net, P);
        disp(outTrain>0.5)
        
        %IMPRIMIR RESULTADOS
        outTest=-1;
        [ testAccuracy, globalAccuracy ]=   getTrainAndGlobalAccuracy(outTrain, outTest ,TTargets,tr,T);
    elseif(strcmp(dataset,'Formas_2') || strcmp(dataset,'Formas_3') &&  strcmp(loadfile,'0'))
        %TREINAR A REDE
        [net,tr] = train(net, P, T);
        
        % SIMULAR
        outTrain = sim(net, P);
        
        %disp(outTrain>0.5)
        
        %VISUALIZAR DESEMPENHO
        plotconfusion(T, outTrain) % Matriz de confusao
        plotperf(tr)         % Grafico com o desempenho da rede nos 3 conjuntos
        
        % SIMULAR A REDE APENAS NO CONJUNTO DE TESTE
        TInput = P(:, tr.testInd);
        TTargets = T(:, tr.testInd);
        outTest = sim(net, TInput);
        
        %IMPRIMIR RESULTADOS
        [ testAccuracy, globalAccuracy ]= getTrainAndGlobalAccuracy(outTrain, outTest ,TTargets,tr,T);
    elseif(strcmp(dataset,'Formas_3'))
        clg = 'FORAM3'
        setupLoaded = load(loadfile);
        net =setupLoaded.net;
        if(treina==1)
            clg1 = 'TREINO'
            [net,tr] = train(net, P, T);
        else
            clg2 = 'NAO TREINO'
            
            tr =setupLoaded.tr;
            
        end
        % SIMULAR
        outTrain = sim(net, P);
        
        %disp(outTrain>0.5)
        
        %VISUALIZAR DESEMPENHO
        plotconfusion(T, outTrain) % Matriz de confusao
        plotperf(tr)         % Grafico com o desempenho da rede nos 3 conjuntos
        
        % SIMULAR A REDE APENAS NO CONJUNTO DE TESTE
        TInput = P(:, tr.testInd);
        TTargets = T(:, tr.testInd);
        outTest = sim(net, TInput);
        
        %IMPRIMIR RESULTADOS
        [ testAccuracy, globalAccuracy ]= getTrainAndGlobalAccuracy(outTrain, outTest ,TTargets,tr,T);
    end
    
    
    [code, setup] = saveConfiguration(activationFunctions, activationFuntionOutput,trainningFunction, epochsNumber ,neuroNumber, trainningWeights,divFunc ,setupName, ExcelFileName, sheetNumber,testAccuracy,globalAccuracy, net,tr, P, T, TInput ,TTargets);
catch ME
    disp(ME)
    code = 500;
    setup=ME.message;
    
end

end
