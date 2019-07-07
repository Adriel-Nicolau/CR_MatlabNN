function [ testAccuracy, globalAccuracy  ] = imageRecognize( image, setup )
outTest=-1;
TTargets=[];
circleTARGET = [1 0 0 0];
squareTARGET = [0 1 0 0];
starTARGET = [0 0 1 0];
triangleTARGET = [0 0 0 1];
T =[circleTARGET ; squareTARGET ; starTARGET ; triangleTARGET]';
pathSetup = strcat('./save/', setup);
imageSelected = imread(image);
imageSelectedt= imresize(imageSelected, [64 NaN]);
imageBW = im2bw(imageSelectedt,0.5);
reshape(imageBW,1,[]);
%transpose(circleBW);
imageBWMatrixLine = reshape(imageBW.',1,[]);
P =  imageBWMatrixLine';
setupLoaded = load(pathSetup);
net =setupLoaded.net;
tr =setupLoaded.tr;


outTrain = sim(net, P);
plotconfusion(T, outTrain)
saveas(gcf,strcat('./outputImg/',setupName,'_',dataset,'_Train_plotconfusion.png'));
[ testAccuracy, globalAccuracy ]= getTrainAndGlobalAccuracy(outTrain, outTest ,TTargets,tr,T);




end

