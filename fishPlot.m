% Plots a top-down animation of the zebrafish moving around the tank, so
% to help visualise the work being done

myWTFolder = './data/wildTypes/';
myPTFolder = './data/parkinsonTypes/';

%checking for valid filepath
if ~isfolder(myWTFolder)
    errorMessage=sprintf('Error: The following folder does not exist:\n%s', myWTFolder);
    uiwait(warndlg(errorMessage));
    return;
end

if ~isfolder(myPTFolder)
    errorMessage=sprintf('Error: The following folder does not exist:\n%s', myPTFolder);
    uiwait(warndlg(errorMessage));
    return;
end

filePatternWT = fullfile(myWTFolder, '*.csv');
theFilesWT = dir(filePatternWT);

filePatternPT = fullfile(myPTFolder, '*.csv');
theFilesPT = dir(filePatternPT);

for k = 1 : length(theFilesWT)
    
    baseFileNameWT = theFilesWT(k).name;
    fullFileNameWT = fullfile(myWTFolder, baseFileNameWT);
    dataWT = readtable(fullFileNameWT);
    
    baseFileNamePT = theFilesPT(k).name;
    fullFileNamePT = fullfile(myPTFolder, baseFileNamePT);
    dataPT = readtable(fullFileNamePT);
    
    plotFish(dataWT, dataPT);
    
end

% function which plots the positional xy co-ordinates of the
% zebrafish
function plotFish(dataWT, dataPT)
    
    frames = 600;
    for i = 1 : frames
        % WT = wild type
        % MT = mutant type

        %reading values of the 7 xy co-ordinates on the zebrafish spine
       xWT1 = dataWT{i, [8 10 12 14 16 18 20]};
       yWT1 = dataWT{i, [9 11 13 15 17 19 21]};

       xMT1 = dataPT{i, [8 10 12 14 16 18 20]};
       yMT1 = dataPT{i, [9 11 13 15 17 19 21]};
       
       
        %after experimenting, i have determined that the head co-ords are 8 and 9. the tail is 20 and 21
       
       
        %first plots yWT against xWT, then yMT against xMT
        plot(yWT1,xWT1, xMT1, yMT1,'LineWidth', 2.0);
        
        xlabel('x co-ordinates');
        ylabel('y co-ordinates');  
        title('x against y co-ordinates of the fish per frame');

        %defines the figure window size, in pixels
        set(gcf, 'Position',  [15, 15, 1900, 950]);

        % sets the scale for the figure axes
        xlim([0,2000]);
        ylim([0,2000]);
        pause(.006);
    end
    
end




