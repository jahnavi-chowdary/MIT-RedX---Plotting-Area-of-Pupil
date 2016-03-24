
clc;
clear;
close all;

dir_seg = dir('..\Videos\*.avi');
len = length(dir_seg);

for k = 3:len
    
    clear area_pupil_right;
    clear area_pupil_left;
    clear state_of_light_right;
    clear state_of_light_left;
    clear area_state_right;
    clear area_state_left;
    
    fname = dir_seg(k).name;
    [ID rem1] = strtok(fname,'_');
    [Attempt rem2] = strtok(rem1,'_');
    [temp rem3] = strtok(rem2,'_');
    [Side rem4] = strtok(temp,'.');
    
    if strcmp(Side,'right')
        
    fname_right = strcat(ID,'_',Attempt,'_','right','.avi');
    fname_left = strcat(ID,'_',Attempt,'_','left','.avi');

    video_right = VideoReader(fullfile('..\Videos', fname_right));
    video_left = VideoReader(fullfile('..\Videos', fname_left));
    
    fname_right_txt = strcat(ID,'_',Attempt,'_','right','.txt');
    fname_left_txt = strcat(ID,'_',Attempt,'_','left','.txt');
    
    [hour_right var1 min_right var2 sec_right] = textread(fullfile('..\Videos', fname_right_txt), '%d %c %d %c %f');
    time_right = [hour_right,min_right,sec_right];
    
    [hour_left var1 min_left var2 sec_left] = textread(fullfile('..\Videos', fname_left_txt), '%d %c %d %c %f');
    time_left = [hour_left,min_left,sec_left];
    
    [state_of_light_right state_of_light_left area_pupil_right area_pupil_left] = area_of_pupil_allvideos(video_right,video_left);
      
    % Getting the timestamps of Right eye

    h = time_right(1,1);
    m = time_right(1,2);
    s = time_right(1,3);
    hour_right = time_right(:,1) - h;
    min_right = time_right(:,2) - m;
    sec_right = time_right(:,3) - s;
    time_right = (3600 .* hour_right) + (60 .* min_right) + sec_right; 
        
    % Getting the timestamps of Left eye
    
    h = time_left(1,1);
    m = time_left(1,2);
    s = time_left(1,3);
    hour_left = time_left(:,1) - h;
    min_left = time_left(:,2) - m;
    sec_left = time_left(:,3) - s;
    time_left = (3600 .* hour_left) + (60 .* min_left) + sec_left; 
            
    area_state_time_right = [area_pupil_right' state_of_light_right' time_right];
    area_state_time_left = [area_pupil_left' state_of_light_left' time_left];
    
    fname_right_csv = strcat(ID,'_',Attempt,'_','right','.csv');
    fname_left_csv = strcat(ID,'_',Attempt,'_','left','.csv');
    
    xlswrite(fullfile('..\CSV', fname_right_csv),area_state_time_right);
    xlswrite(fullfile('..\CSV', fname_left_csv),area_state_time_left);
    
    % Plotting the Area of Right and Left
    
    figure;
    ys = smooth(time_right,area_pupil_right,0.1,'rloess');
    plot(time_right,ys,'r')
    hold on
    
    ys = smooth(time_left,area_pupil_left,0.1,'rloess');
    plot(time_left,ys,'b')
    hold on
    
    state_of_light_right = state_of_light_right * 10^4;
    plot(time_right,state_of_light_right,'g')
    hold on
    state_of_light_left = state_of_light_left * 10^4;
    plot(time_right,state_of_light_left,'y')
    
    % Saving and returning the plot as an image
    F = getframe(gca);
    Image = F.cdata;
    figure; imshow( Image );
    plot_area = Image;
    
    fname_plot = strcat(ID,'_',Attempt,'_','right','_','plot','.jpg');
    imwrite(plot_area,fullfile('..\Plots',fname_plot));
    else
        continue
    end
end
