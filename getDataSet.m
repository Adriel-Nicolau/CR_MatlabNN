function [ IN, T  ]= getDataSet( dataset )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
extention = '.png';

if(strcmp(dataset,'Formas_1'))
    %tranforming images in to matrix
    circleImg = imread('./Formas_1/0_circle.png');
    squareImg = imread('./Formas_1/0_square.png');
    starImg = imread('./Formas_1/0_star.png');
    triangleImg = imread('./Formas_1/0_triangle.png');
   
    %resize images
    resizeCircle = imresize(circleImg,  [64 NaN]);
    resizeSquare = imresize(squareImg,  [64 NaN]);
    resizeStar = imresize(starImg, [64 NaN]);
    resizeTriangle = imresize(triangleImg, [64 NaN]);
    
    %tranforming images  to binary matrix
    circleBW = im2bw(resizeCircle,0.5);
    squareBW = im2bw(resizeSquare,0.5);
    starBW = im2bw(resizeStar,0.5);
    triangleBW = im2bw(resizeTriangle,0.5);
   % figure, imshow(circleBW), figure, imshow(squareBW), figure, imshow(starBW),figure, imshow(triangleBW)
    
    reshape(circleBW,1,[]);
    %transpose(circleBW);
    circleBWMatrixLine = reshape(circleBW.',1,[]);
    
    reshape(squareBW,1,[]);
    %transpose(squareBW);
    squareBWMatrixLine = reshape(squareBW.',1,[]);
    
    reshape(starBW,1,[]);
    %transpose(starBW);
    starBWMatrixLine = reshape(starBW.',1,[]);
    
    reshape(triangleBW,1,[]);
    %transpose(triangleBW);
    triangleBWMatrixLine = reshape(triangleBW.',1,[]);
   
    IN =  [circleBWMatrixLine;squareBWMatrixLine;starBWMatrixLine;triangleBWMatrixLine]';
    
    circleTARGET = [1 0 0 0];
    squareTARGET = [0 1 0 0];
    starTARGET = [0 0 1 0];
    triangleTARGET = [0 0 0 1];
    T = logical([circleTARGET ; squareTARGET ; starTARGET ; triangleTARGET]') ;
    
elseif(strcmp(dataset,'Formas_2') || strcmp(dataset,'Formas_3'))
    if(strcmp(dataset,'Formas_2'))
    
        init = 0;
        limit =200;
        ONES = ones(1,201);
        ZEROS = zeros(1,201);
        
        A=[ZEROS ;ZEROS ;ZEROS ;ONES];
        B=[ZEROS ;ZEROS ;ONES ;ZEROS];
        C=[ZEROS ;ONES ;ZEROS ;ZEROS];
        D=[ONES ;ZEROS ;ZEROS ;ZEROS];
        
        T = [A B C D];
        
        pathCircle = './Formas_2/circle/';
        pathSquare = './Formas_2/square/';
        pathStar = './Formas_2/star/';
        pathTriangle = './Formas_2/triangle/';
    else
        init = 201;
        limit =250;
        ONES = ones(1,50);
        ZEROS = zeros(1,50);
        
        A=[ZEROS ;ZEROS ;ZEROS ;ONES];
        B=[ZEROS ;ZEROS ;ONES ;ZEROS];
        C=[ZEROS ;ONES ;ZEROS ;ZEROS];
        D=[ONES ;ZEROS ;ZEROS ;ZEROS];
        
        T = [A B C D];
        
        pathCircle = './Formas_3/circle/';
        pathSquare = './Formas_3/square/';
        pathStar = './Formas_3/star/';
        pathTriangle = './Formas_3/triangle/';
        
    end
    matrixCircle=[];
    matrixSquare=[];
    matrixStar=[];
    matrixTriangle=[];
 
    for index = init:1:limit
        %tranforming images in to matrix
        img = int2str(index);
        imgName = strcat(img,extention);
        
        finalPathCircle = strcat(pathCircle,imgName);
        finalPathSquare = strcat(pathSquare,imgName);
        finalPathStar = strcat(pathStar,imgName);
        finalPathTriangle = strcat(pathTriangle,imgName);
        
        cirlces = imread(finalPathCircle);
        squares= imread(finalPathSquare);
        stars= imread(finalPathStar);
        triangles= imread(finalPathTriangle);
        %resize images
        resizeImgCircle = imresize(cirlces, [64 NaN]);
        resizeImgSquare = imresize(squares, [64 NaN]);
        resizeImgStar = imresize(stars, [64 NaN]);
        resizeImgTriangle = imresize(triangles, [64 NaN]);
        %tranforming images  to binary matrix
        CircleBW = im2bw(resizeImgCircle,0.5);
        SquareBW = im2bw(resizeImgSquare,0.5);
        StarBW = im2bw(resizeImgStar,0.5);
        TriangleBW = im2bw(resizeImgTriangle,0.5);
        %figure, imshow(circleBW), figure, imshow(squareBW), figure, imshow(starBW),figure, imshow(triangleBW)
        
        
        % reshape(CircleBW,1,[]);
        CircleBWMatrixLine = reshape(CircleBW.',1,[]);
        
        % reshape(SquareBW,1,[]);
        SquareBWMatrixLine = reshape(SquareBW.',1,[]);
        
        %reshape(StarBW,1,[]);
        StarBWMatrixLine = reshape(StarBW.',1,[]);
        
        % reshape(TriangleBW,1,[]);
        TriangleBWMatrixLine = reshape(TriangleBW.',1,[]);
        
        matrixCircle =  [matrixCircle; CircleBWMatrixLine];
        matrixSquare =  [matrixSquare; SquareBWMatrixLine];
        matrixStar =  [matrixStar; StarBWMatrixLine];
        matrixTriangle =  [matrixTriangle; TriangleBWMatrixLine];
        
        
    end
    IN =  [matrixCircle;matrixSquare;matrixStar;matrixTriangle]';

    
end
    size(IN)
    size(T)
    

end

