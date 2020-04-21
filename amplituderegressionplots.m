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


frames = 1500;
figure;



for k = 1 : 5
    
    baseFileNameWT = theFilesWT(k).name;
    fullFileNameWT = fullfile(myWTFolder, baseFileNameWT);
    dataWT = readtable(fullFileNameWT);
    
    baseFileNamePT = theFilesPT(k).name;
    fullFileNamePT = fullfile(myPTFolder, baseFileNamePT);
    dataPT = readtable(fullFileNamePT);
    
    plotRegression(dataWT, dataPT, frames);

%     
    if k+1 <= 5
        figure(k+1);
    end


end

function plotRegression(dataWT, dataPT, frames)

   %fixing figure window size
   set(gcf, 'Position',  [15, 15, 1500, 950]);
   
   
   x = 1:frames;
   
   xRot = rot90(x);
   
   wt_tail_angles = rad2deg(dataWT{1:frames, 3}) + 180;
   pt_tail_angles = rad2deg(dataPT{1:frames, 3}) + 180;
    
   TF1 = islocalmin(wt_tail_angles);
   TF2 = islocalmin(pt_tail_angles);
   TF3 = islocalmax(wt_tail_angles);
   TF4 = islocalmax(pt_tail_angles);
   
   
   lastTF1 = find(TF1,1,'last');
   lastTF2 = find(TF2,1,'last');
   lastTF3 = find(TF3,1,'last');
   lastTF4 = find(TF4,1,'last');
   
   if length(wt_tail_angles(TF3)) > length(wt_tail_angles(TF1))
        TF3(lastTF3) = [];
   elseif length(wt_tail_angles(TF3)) < length(wt_tail_angles(TF1))
        TF1(lastTF1) = [];
   end
    
   if length(pt_tail_angles(TF4)) > length(pt_tail_angles(TF2))
        TF4(lastTF4) = [];
   elseif length(pt_tail_angles(TF4)) < length(pt_tail_angles(TF2))
        TF2(lastTF2) = [];
   end 
     
   
   wt_amplitude = abs(wt_tail_angles(TF3) - wt_tail_angles(TF1));
   pt_amplitude = abs(pt_tail_angles(TF4) - pt_tail_angles(TF2));

   x1 = rot90(1:length(wt_amplitude));
    x2 = rot90(1:length(pt_amplitude));
    
    p1 = polyfit(x1, wt_amplitude,1);
    f1 = polyval(p1,x1);
     
    p2 = polyfit(x2, pt_amplitude,1);
    f2 = polyval(p2,x2);
   
   
   
   
   
   
   
   
   
%    plot(x1, wt_amplitude, 'r*', 'LineWidth', 2', 'color', 'r');
    plot(x2, pt_amplitude, 'r*', 'LineWidth', 2', 'color', 'b');
   grid on;
   hold on;
%    plot(x1, f1, '--r', 'LineWidth', 2.0, 'color', 'b');
   plot(x2, f2, '--r', 'LineWidth', 2.0, 'color', 'r');

   
   title("$\textbf{\emph Tail Displacement Regression of Zebrafish, for  (" + frames + " frames at 300fps)}$", 'Interpreter','latex', 'FontSize', 20, 'fontweight', 'bold');
    ylabel('$\textbf{\emph Tail Displacement (degrees)}$', 'fontweight', 'bold', 'fontsize', 16, 'Interpreter','latex');
    xlabel('$\textbf{\emph Movement Cycle}$', 'fontweight' ,'bold', 'fontsize', 16, 'Interpreter','latex');
    legend('$\textbf{\emph Amplitude}$', '$\textbf{\emph Regression Line}$', 'FontSize', 14, 'Interpreter','latex', 'fontweight', 'bold');
   
  
   
end




