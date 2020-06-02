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
% figure;

gradients = zeros(length(theFilesWT), 4);


for k = 1 : length(theFilesWT)
    
    baseFileNameWT = theFilesWT(k).name;
    fullFileNameWT = fullfile(myWTFolder, baseFileNameWT);
    dataWT = readtable(fullFileNameWT);
    
    baseFileNamePT = theFilesPT(k).name;
    fullFileNamePT = fullfile(myPTFolder, baseFileNamePT);
    dataPT = readtable(fullFileNamePT);
    
    val = plotRegression(dataWT, dataPT, frames);
    
%     wt_hesitations, pt_hesitations, wt_avg_amplitude, pt_avg_amplitude
%     respectively
    gradients(k,1) = val(1); 
    gradients(k,2) = val(2);
    gradients(k,3) = val(3);
    gradients(k,4) = val(4);
    
end


% [mean(gradients(1:end,1)) mean(gradients(1:end,2)) mean(gradients(1:end,3)) mean(gradients(1:end,4))]
fprintf('Control Average Tail Speed: %f\t', mean(gradients(1:end,3)));
fprintf('PD Average Tail Speed: %f\n', mean(gradients(1:end,4)));


function values = plotRegression(dataWT, dataPT, frames)

   %fixing figure window size
   %set(gcf, 'Position',  [15, 15, 1500, 950]);
   
   
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
   
    
    
   wt_speed = abs( ( wt_tail_angles(TF3)-wt_tail_angles(TF1) )./( (xRot(TF3)-xRot(TF1))* 0.00333333 ) );
   pt_speed = abs( ( pt_tail_angles(TF4)-pt_tail_angles(TF2) )./( (xRot(TF4)-xRot(TF2))* 0.00333333 ) );

   mean_wt_speed = mean(wt_speed);
   mean_pt_speed = mean(pt_speed);
   
   [wt_hesitation_counter, pt_hesitation_counter] = identify_hesitations(wt_speed, pt_speed);
   
   values = [wt_hesitation_counter, pt_hesitation_counter, mean_wt_speed, mean_pt_speed];
   
   
end


function [wt_hesitation_counter, pt_hesitation_counter] = identify_hesitations(wt_speed, pt_speed)

    
    
    wt_hesitation_counter = 0;
    pt_hesitation_counter = 0;
    
    for i = 1 : size(wt_speed)
        
        if(wt_speed(i) <= 0.05*max(wt_speed))
            wt_hesitation_counter = wt_hesitation_counter + 1;
        end
    end
    
    for i = 1 : size(pt_speed)
        
        if(pt_speed(i) <= 0.05*max(pt_speed))
            pt_hesitation_counter = pt_hesitation_counter + 1;
        end
    end
    
    
end





