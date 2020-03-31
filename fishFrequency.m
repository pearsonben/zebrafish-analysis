dataWT = readtable('./data/wildTypes/WT_5.A.csv');
dataPT = readtable('./data/parkinsonTypes/Duchenne_5.A.csv');


wt_x_position = dataWT{355:410, 8};
wt_y_position = dataWT{355:410, 9};

pt_x_position = dataPT{355:410, 8};
pt_y_position = dataPT{355:410, 9};


wt_tail_angles = rad2deg(dataWT{355:410, 3}) + 180;
pt_tail_angles = rad2deg(dataPT{355:410, 3}) + 180;

TF1 = islocalmin(wt_tail_angles);
TF2 = islocalmin(pt_tail_angles);

% 3000 frames for a 30 second recording. 1s = 300 frames. 
% therefore 1 frame = 1/300 = 3.33ms.
% so time elapsed = 3.33ms * number of frames
time = (410-355) * 0.00333333;

wt_minimas = sum(TF1(:) == 1);
pt_minimas = sum(TF2(:) == 1);

% f = 1/t
wt_frequency = (wt_minimas)/(time);
pt_frequency = (pt_minimas)/(time);



[wt_frequency pt_frequency]