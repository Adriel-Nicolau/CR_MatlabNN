function [ value ] = convertConstants( code )
value =[];

switch(code)
    case 0
        value = 'tansig';
    case 1
        value = 'purelin';
    case 2
        value = 'logsig';
    case '3'
        value = 'trainlm';
    case '4'
        value = 'trainbfg';
    case '5'
        value = 'trainrp';
    case '6'
        value = 'trainscg';
    case '7'
        value = 'traincgb';
    case '8'
        value = 'traincgf';
    case '9'
        value = 'traincgp';
    case '10'
        value = 'trainoss';
    case '11'
        value = 'traingdx';
    case '12'
        value = 'dividerand';
    case '13'
        value = 'divideblock';
    case '14'
        value = 'divideint';
    case '15'
        value = 'divideind';
end




end
