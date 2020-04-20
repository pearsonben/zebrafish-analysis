% This file plots the angle of the tail, for every frame in the recording.
% Useful for visualising important aspects of the zebrafishes movements,
% you can eyeball where the fish is moving in a straight line, and can also
% identify hesitations with ease. 

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
    
    if k+1 <= length(theFilesWT)
        figure(k+1);
    end
    
end

% function which plots the positional xy co-ordinates of the
% zebrafish
function plotFish(dataWT, dataPT)
    clf;
    frames = 600;

    x = rot90(1:frames);

    % storing the angles of the tail
    wt_tail_angles = rad2deg(dataWT{1:frames, 3}) + 180;
    pt_tail_angles = rad2deg(dataPT{1:frames, 3}) + 180;

    %finding local minimas and maximas
    TF1 = islocalmin(wt_tail_angles);
    TF2 = islocalmin(pt_tail_angles);
    TF3 = islocalmax(wt_tail_angles);
    TF4 = islocalmax(pt_tail_angles);
    
    %defines the figure window size, in pixels
    set(gcf, 'Position',  [15, 15, 1500, 950]);

    
    %plotting tail angle for every frame
    plot(x, wt_tail_angles, x, pt_tail_angles, 'LineWidth', 2.0);
    %plot(x, pt_tail_angles, 'LineWidth', 2.0);
    hold on
    %plotting local mins and maxs
    plot(x(TF1), wt_tail_angles(TF1), 'r*', 'LineWidth', 2', 'color', 'g');
   plot(x(TF3), wt_tail_angles(TF3), 'r*', 'LineWidth', 2', 'color', 'c');
    plot(x(TF2), pt_tail_angles(TF2), 'r*', 'LineWidth', 2', 'color', 'g');
    plot(x(TF4), pt_tail_angles(TF4), 'r*', 'LineWidth', 2', 'color', 'c');
    
    yline(180, '--r', 'color', 'k', 'LineWidth', 2.0);
    
    legend('$\textbf{\emph Control Type}$', '$\textbf{\emph Parkinsonian Type}$', '$\textbf{\emph Local Minimas}$', '$\textbf{\emph Local Maximas}$', 'FontSize', 14, 'Interpreter','latex', 'fontweight', 'bold');

    xlabel('$\textbf{\emph Frames}$', 'Interpreter','latex', 'fontweight', 'bold');
    ylabel('$\textbf{\emph Tail Angle (degrees)}$', 'Interpreter','latex', 'fontweight', 'bold');  
    title('$\textbf{\emph Angle of zebrafish tail per frame}$', 'Interpreter','latex', 'fontweight', 'bold');

    %defining the figure boundary sizes
    max_boundary = 0;
    min_boundary = 0;
    
    %calculating plot scales
    if max(wt_tail_angles) > max(pt_tail_angles)
        max_boundary = max(wt_tail_angles) + 5;
    elseif max(wt_tail_angles) < max(pt_tail_angles)
        max_boundary = max(pt_tail_angles) + 5;
    end
    
    if min(wt_tail_angles) < max(pt_tail_angles)
        min_boundary = min(wt_tail_angles) - 5;
    elseif min(wt_tail_angles) > min(pt_tail_angles)
        min_boundary = min(pt_tail_angles) - 5;
    end
    
    
    xlim([0,300]);
    ylim([min_boundary max_boundary]);
    
    length(x(TF1))
    
    txt1 = ['$\textbf{\emph Wild-Type Minimas: ' num2str(sum(TF1(:) == 1)) '}$'];
    txt2 = ['$\textbf{\emph Wild-Type Maximas: ' num2str(sum(TF3(:) == 1)) '}$'];
    txt3 = ['$\textbf{\emph Parkinsons-Type Minimas: ' num2str(sum(TF2(:) == 1)) '}$'];
    txt4 = ['$\textbf{\emph Parkinsons-Type Maximas: ' num2str(sum(TF4(:) == 1)) '}$'];
    
    %defining text at top left of figure
    ylimits = ylim;
    ymax = ylimits(2);
    vert_spacing = ymax/47;  %arbitrary positioning
    
    text(10, ymax-vert_spacing*1, txt1, 'Interpreter','latex');
    text(10, ymax-vert_spacing*2, txt2, 'Interpreter','latex');
    text(10, ymax-vert_spacing*4, txt3, 'Interpreter','latex');
    text(10, ymax-vert_spacing*5, txt4, 'Interpreter','latex');
    
    grid on;

end









