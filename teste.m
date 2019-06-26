

 net = feedforwardnet(10);
     net.divideFcn = '';
       
        net.layers{2}.transferFcn = 'tansig';
  
    
    %Setup função de activação da camada de saida
   
    
    net.trainParam.epochs = 100;
    
    %Setup da função de treino
    net.trainFcn ='trainscg' ; %'traingd';
    
   
 
    
     [P, T] = getDataSet(1);
%     %Treinar a rede
%     net.plotFcns = {'plotperform','plottrainstate','plotresponse','ploterrcorr', 'plotinerrcorr'};
%     [net,tr] = train(net, P, T);