function [ code , setup , testAccuracy, globalAccuracy ] = trainningNetwork( activationFunctions, activationFuntionOutput,trainningFunction, epochsNumber ,neuroNumber, trainningWeights,divFunc,setupName,ExcelFileName, sheetNumber,dataset,treina,loadfile)
try
    globalAccuracy=0;
    length = size(activationFunctions);
    length =length(2);
    TInput = [];
    TTargets =[];
    savetype=0;
    testAccuracy='-';
    globalAccuracy='-';
    
    if(treina==1 &&   strcmp(loadfile,'0'))
        net = feedforwardnet(neuroNumber);
        %Setup da função de treino
        net.trainFcn =convertConstants(trainningFunction) ;
        
        %Setup função de activação das camadas escondidas
        for index=1:length
            func =convertConstants(activationFunctions(index));
            net.layers{index}.transferFcn = func;
        end
        
        %Setup função de activação da camada de saida
        net.layers{index+1}.transferFcn = convertConstants(activationFuntionOutput);
        net.trainParam.epochs = epochsNumber;
        %Todos os exemplos são usados para treino
        if( trainningWeights(1)==100)
            net.divideFcn = '';
        else
            %è utilziado uma função de divisão e racios
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
        plotperf(tr);
        name= strcat('./outputImg/',setupName,'_performance.png');
        saveas(gcf,name)
        outTest=-1;
        [ testAccuracy, globalAccuracy ]=   getTrainAndGlobalAccuracy(outTrain, outTest ,TTargets,tr,T);
    elseif(strcmp(dataset,'Formas_2') || strcmp(dataset,'Formas_3') &&  strcmp(loadfile,'0'))
        %TREINAR A REDE
        [net,tr] = train(net, P, T);
        
        % SIMULAR
        outTrain = sim(net, P);
        
        %VISUALIZAR DESEMPENHO
        plotconfusion(T, outTrain) % Matriz de confusao
        name=   strcat('./outputImg/',setupName,'_',dataset,'_plotconfusion.png');
        saveas(gcf,name)
        plotperf(tr)         % Grafico com o desempenho da rede nos 3 conjuntos
        name= strcat('./outputImg/',setupName,'_',dataset,'_performance.png');
        saveas(gcf,name)
        % SIMULAR A REDE APENAS NO CONJUNTO DE TESTE
        TInput = P(:, tr.testInd);
        TTargets = T(:, tr.testInd);
        outTest = sim(net, TInput);
        %IMPRIMIR RESULTADOS
        [ testAccuracy, globalAccuracy ]= getTrainAndGlobalAccuracy(outTrain, outTest ,TTargets,tr,T);
    elseif(strcmp(dataset,'Formas_3'))
        outTrain=-1;
        outTest=-1;
        setupLoaded = load(loadfile);
        net =setupLoaded.net;
    
        if(treina==1)
            [net,tr] = train(net, P, T);
            % SIMULAR
            outTrain = sim(net, P);
            %VISUALIZAR DESEMPENHO
            % Matriz de confusao
            plotconfusion(T, outTrain)
            saveas(gcf,strcat('./outputImg/',setupName,'_',dataset,'_Train_plotconfusion.png'));
            % Grafico com o desempenho da rede nos 3 conjuntos
            plotperf(tr)
            saveas(gcf,strcat('./outputImg/',setupName,'_',dataset,'_Train_performance.png'));
            % SIMULAR A REDE APENAS NO CONJUNTO DE TESTE
            TInput = P(:, tr.testInd);
            TTargets = T(:, tr.testInd);
      
            outTest = sim(net, TInput);
        else
            tr =setupLoaded.tr;
            outTrain = sim(net, P);
            plotconfusion(T, outTrain)
            saveas(gcf,strcat('./outputImg/',setupName,'_',dataset,'_Train_plotconfusion.png'));
        end
        
        %IMPRIMIR RESULTADOS
        [ testAccuracy, globalAccuracy ]= getTrainAndGlobalAccuracy(outTrain, outTest ,TTargets,tr,T);

        savetype=1;
        name= strcat(setupName,'_Loaded_',num2str(sheetNumber));
        code= writeExcellFile(name,loadfile,sheetNumber, ExcelFileName);
        setup='null';
        
        setupsavedname =  strcat('./save/',name,'.mat');
        
        activationFunctions = setupLoaded.activationFunctions;
        activationFuntionOutput =setupLoaded.activationFuntionOutput;
        trainningFunction = setupLoaded.trainningFunction;
        epochsNumber=setupLoaded.epochsNumber;
        neuroNumber=setupLoaded.neuroNumber;
        trainningWeights=setupLoaded.trainningWeights;
        divFunc=setupLoaded.divFunc;
        save(setupsavedname,'net' , 'tr','activationFunctions', 'activationFuntionOutput','trainningFunction', 'epochsNumber' ,'neuroNumber', 'trainningWeights','divFunc');
    end
    if(savetype==0)
        [code, setup] = saveConfiguration(activationFunctions, activationFuntionOutput,trainningFunction, epochsNumber ,neuroNumber, trainningWeights,divFunc ,setupName, ExcelFileName, sheetNumber,testAccuracy,globalAccuracy, net,tr, P, T, TInput ,TTargets);
    end
    
    
    
catch ME
    disp(ME)
    code = 500;
    setup=ME.message;
    
end

end

