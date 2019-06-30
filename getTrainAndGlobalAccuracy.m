function [ testAccuracy, globalAccuracy] = getTrainAndGlobalAccuracy(outTrain, outTest ,TTargets,tr,T)

%Calcula e mostra a percentagem de classificacoes corretas no conjunto de teste
r=0;
for i=1:size(outTrain,2)               % Para cada classificacao
    [~, b] = max(outTrain(:,i));          %b guarda a linha onde encontrou valor mais alto da saida obtida
    [~, d]  = max(T(:,i));  %d guarda a linha onde encontrou valor mais alto da saida desejada
    if b == d                       % se estao na mesma linha, a classificacao foi correta (incrementa 1)
        r = r+1;
    end
end
globalAccuracy = r/size(outTrain,2)*100;
fprintf('Precisao global %f\n', globalAccuracy)
if(outTest~=-1)
    %Calcula e mostra a percentagem de classificacoes corretas no conjunto de teste
    r=0;
    for i=1:size(tr.testInd,2)               % Para cada classificacao
        [~, b] = max(outTest(:,i));          %b guarda a linha onde encontrou valor mais alto da saida obtida
        [~, d] = max(TTargets(:,i));  %d guarda a linha onde encontrou valor mais alto da saida desejada
        if b == d                       % se estao na mesma linha, a classificacao foi correta (incrementa 1)
            r = r+1;
        end
    end
    testAccuracy = r/size(tr.testInd,2)*100;
    fprintf('Precisao teste %f\n', testAccuracy)
else
    testAccuracy = '-';
end
end

