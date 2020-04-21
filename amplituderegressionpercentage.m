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


gradients = zeros(length(theFilesWT), 2);



for k = 1 : length(theFilesWT)
    
    baseFileNameWT = theFilesWT(k).name;
    fullFileNameWT = fullfile(myWTFolder, baseFileNameWT);
    dataWT = readtable(fullFileNameWT);
    
    baseFileNamePT = theFilesPT(k).name;
    fullFileNamePT = fullfile(myPTFolder, baseFileNamePT);
    dataPT = readtable(fullFileNamePT);
    
    val = plotRegression(dataWT, dataPT, frames);
    
    gradients(k, 1) = val(1);
    gradients(k, 2) = val(2);

end

wt_counter = 0;
pt_counter = 0;

for i = 1 : length(gradients)
    
   if (gradients(i, 1) < 0)
        
       wt_counter = wt_counter + 1;
       
   end
   
   if (gradients(i, 2) < 0)
        
       pt_counter = pt_counter + 1;
       
   end
      
end

wt_SE_percentage = (wt_counter / length(gradients)) * 100;
pt_SE_percentage = (pt_counter / length(gradients)) * 100;

[wt_SE_percentage pt_SE_percentage]



function gradients = plotRegression(dataWT, dataPT, frames)
  
   x = 1:frames;
   
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
    p2 = polyfit(x2, pt_amplitude,1);
 
    gradients = [p1(1) p2(1)];
    
end




