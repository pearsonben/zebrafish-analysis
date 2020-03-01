wildType1 = readtable('WT_1.A.csv');
mutantType1 = readtable('Duchenne_1.A.csv');

frames = 100;
counter = 0;
for i = 1 : frames
    
    % unmaintainable, needs to be a dynamic array of arrays for all datasets
    
    % WT = wild type
    % MT = mutant type
    
    %reading values of the 7 xy co-ordinates on the zebrafish spine
    xWT1 = wildType1{i, [8 10 12 14 16 18 20]};
    yWT1 = wildType1{i, [9 11 13 15 17 19 21]};
    
    
    xMT1 = mutantType1{i, [8 10 12 14 16 18 20]};
    yMT1 = mutantType1{i, [9 11 13 15 17 19 21]};
    
    
    %first plots yWT against xWT, then yMT against xMT
    plot(yWT1,xWT1, yMT1, xMT1, 'LineWidth', 2.0);
    
    
    xlabel('x co-ordinates');
    ylabel('y co-ordinates');  
    title('x against y co-ordinates of the fish per frame');
    
    %defines the figure window size, in pixels
    set(gcf, 'Position',  [25, 25, 1200, 1900]);
    
    % sets the scale for the figure axes
    xlim([0,800]);
    ylim([0,700]);
    
    pause(.05);
    disp(counter);
end


% so far, i have tried to add one to the counter every time the spine angle
% is larger than 45 degrees, however it seems that almost every movement is
% larger than 45 degrees so something is wrong. Needs looking over tomorrow


