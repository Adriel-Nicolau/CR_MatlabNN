function [ testAccuracy, globalAccuracy  ] = imageRecognize( image, setup )
outTest=-1;
TTargets=[];
% circleTARGET = [1 0 0 0];
% squareTARGET = [0 1 0 0];
% starTARGET = [0 0 1 0];
% triangleTARGET = [0 0 0 1];
% T = logical([circleTARGET ; squareTARGET ; starTARGET ; triangleTARGET]') ;
pathSetup = strcat('./save/', setup);
imageSelected = imread(image);
imageSelectedt= imresize(imageSelected, 0.5);
imageBW = im2bw(imageSelectedt,0.5);
reshape(imageBW,1,[]);
%transpose(circleBW);
imageBWMatrixLine = reshape(imageBW.',1,[]);
P =  imageBWMatrixLine';
setupLoaded = load(pathSetup);
net =setupLoaded.net;
tr =setupLoaded.tr;

size(P)
% SIMULAR
outTrain = sim(net, P);
disp(outTrain>0.5)
% % SIMULAR A REDE APENAS NO CONJUNTO DE TESTE
% TInput = P(:, tr.testInd);
% TTargets = T(:, tr.testInd);
% outTest = sim(net, TInput);
% plotconfusion(T, outTrain) % Matriz de confusao
% %IMPRIMIR RESULTADOS
%  [ testAccuracy, globalAccuracy ]= getTrainAndGlobalAccuracy(outTrain, outTest ,TTargets,tr,T);
% 



end

