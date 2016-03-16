
clc;
clear;
close all;

dir_seg = dir('C:\Users\Jahnavi Chowdary\Desktop\IIIT\Mit Redx LVPEI Task\mit redx\Right_Videos\*.avi');
len = length(dir_seg);

for k = 1:len
    
    fname = dir_input(k).name;
    [ID rem1] = strtok(fname,'_');
    [Attempt rem2] = strtok(rem1,'_');
    [temp rem3] = strtok(rem2,'_');
    [Side rem4] = strtok(temp,'.');
    
    fname_right = strcat(ID,'_',Attempt,'_','right','.avi');
    fname_left = strcat(ID,'_',Attempt,'_','left','.avi');

    video_right = VideoReader(fullfile('C:\Users\Jahnavi Chowdary\Desktop\IIIT\Mit Redx LVPEI Task\mit redx\Right_Videos', fname_right));
    video_left = VideoReader(fullfile('C:\Users\Jahnavi Chowdary\Desktop\IIIT\Mit Redx LVPEI Task\mit redx\Left_Videos', fname_left));
    
    fname_right_txt = strcat(ID,'_',Attempt,'_','right','.txt');
    fname_left_txt = strcat(ID,'_',Attempt,'_','left','.txt');
    
    [hour_right var1 min_right var2 sec_right] = textread(fname_right_txt, '%d %c %d %c %f');
    time_right = [hour_right,min_right,sec_right];
    
    [hour_left var1 min_left var2 sec_left] = textread(fname_left_txt, '%d %c %d %c %f');
    time_left = [hour_left,min_left,sec_left];
    
    plot_area = area_of_pupil(video_right,video_left,time_right,time_left);
    fname_plot = strcat(ID,'_',Attempt,'_','right','_','plot','.jpg');
    imwrite(plot_area,fname_plot);

end
