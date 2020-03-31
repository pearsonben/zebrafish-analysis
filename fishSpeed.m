% Using the tailAngle.m file, you can identify sections of each .csv file
% where the fish is travelling in a straight line. Using this information,
% this file takes the sections where the fish is moving straight and
% calculates the speed the fishes are travelling. 

dataWT = readtable('./data/wildTypes/WT_5.A.csv');
dataPT = readtable('./data/parkinsonTypes/Duchenne_5.A.csv');


% row 8 and 9 are respectively the x and y co-ordinates of the head

% 355 to 410 are identified frames where the fish is moving straight
start_wt_x_position = dataWT{355, 8};
start_wt_y_position = dataWT{355, 9};

start_pt_x_position = dataPT{355, 8};
start_pt_y_position = dataPT{355, 9};


end_wt_x_position = dataWT{410, 8};
end_wt_y_position = dataWT{410, 9};

end_pt_x_position = dataPT{410, 8};
end_pt_y_position = dataPT{410, 9};

% distance between co-ords = sqrt( (x1 - x2)^2 + (y1 - y2)^2 )
wt_distance_travelled = sqrt( (end_wt_x_position - start_wt_x_position).^2 + (end_wt_y_position - start_wt_y_position ).^2 );
pt_distance_travelled = sqrt( (end_pt_x_position - start_pt_x_position).^2 + (end_pt_y_position -  start_pt_y_position ).^2 );

%speed = distance/time.
time_elapsed = 410-355;

wt_speed = wt_distance_travelled/time_elapsed;
pt_speed = pt_distance_travelled/time_elapsed;



[wt_speed pt_speed]

% [start_wt_x_position start_wt_y_position]
% [start_pt_x_position start_pt_y_position]
% [end_wt_x_position end_wt_y_position]
% [end_pt_x_position end_pt_y_position]

