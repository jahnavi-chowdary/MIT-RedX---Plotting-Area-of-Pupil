function plot_leftandright = area_of_pupil(video_right,video_left , time_right,time_left)

    numFrames_right = video_right.NumberOfFrames;
    n=numFrames_right;
    state_of_light_right = zeros(1,337);
    for k = 1:1:n
        
        I = read(vid,k);
        
        %Getting frames where light is on
    
        I_g = I(:,:,2);
        histo = imhist(I_g);
        amt_of_green = sum(histo((201:256),1));
        if amt_of_green > 2000
            state_of_light_right(1,k) = 1;
        end

        % Getting area of Pupil
    
        I = rgb2gray(I);
        [hei wid] = size(I);

        for i = 1:hei
            for j = 1:wid
                if I(i,j) < 50
                    I_new(i,j) = 1;
                else
                    I_new(i,j) = 0;
                end
            end
        end

        SE = strel('disk', 2);
        I_ne = imcomplement(I_new);
        I_dil = imdilate(I_ne,SE);
        I_temp = imcomplement(I_dil);
        I_fill = imfill(I_temp,'holes');

        stats = regionprops('table',I_fill,'Centroid','MajorAxisLength','MinorAxisLength');
        centers = stats.Centroid;
        diameters = mean([stats.MajorAxisLength stats.MinorAxisLength],2);
    
        if size(centers) == 0
            radii_right(1,k) = radii_right(1,k-1);
            area_pupil_right(1,k) = area_pupil_right(1,k-1);
        else
            x = centers(1,1);
            y = centers(1,2);
            radii_right(1,k) = diameters/2;
            area_pupil_right(1,k) = pi * radii_right(1,k)^2;

            % Uncomment the below 6 lines to see the contour overlayed on
            % the pupil and write them into a file
            
            % imshow(I);
            % hold on;
            % contour(I_fill,'-r');
            % f=getframe(gca)
            % [X, map] = frame2im(f);
            % imwrite(X,fname2)
        end
        
        % Getting the timestamps

        h = time_right(1,1);
        m = time_right(1,2);
        s = time_right(1,3);
        hour_right = time_right(:,1) - h;
        min_right = time_right(:,2) - m;
        sec_right = time_right(:,3) - s;
        time_right = (3600 .* hour_right) + (60 .* min_right) + sec_right; 
        
        xlswrite('State_of_Light_Right.xlsx',state_of_light_right);
        xlswrite('Area_Pupil_Right.xlsx',area_pupil_right);
        xlswrite('Radii_Right.xlsx',radii_right);
        xlswrite('TimeStamp_Right.xlsx',time_right);
        
    end
    
    numFrames_left = video_left.NumberOfFrames;
    n=numFrames_left;
    state_of_light_left = zeros(1,337);
    for k = 1:1:n
        
        I = read(video_left,k);
        
        %Getting frames where light is on
    
        I_g = I(:,:,2);
        histo = imhist(I_g);
        amt_of_green = sum(histo((201:256),1));
        if amt_of_green > 2000
            state_of_light_left(1,k) = 1;
        end

        % Getting area of Pupil
    
        I = rgb2gray(I);
        [hei wid] = size(I);

        for i = 1:hei
            for j = 1:wid
                if I(i,j) < 50
                    I_new(i,j) = 1;
                else
                    I_new(i,j) = 0;
                end
            end
        end

        SE = strel('disk', 2);
        I_ne = imcomplement(I_new);
        I_dil = imdilate(I_ne,SE);
        I_temp = imcomplement(I_dil);
        I_fill = imfill(I_temp,'holes');

        stats = regionprops('table',I_fill,'Centroid','MajorAxisLength','MinorAxisLength');
        centers = stats.Centroid;
        diameters = mean([stats.MajorAxisLength stats.MinorAxisLength],2);
    
        if size(centers) == 0
            radii_left(1,k) = radii_left(1,k-1);
            area_pupil_left(1,k) = area_pupil_left(1,k-1);
        else
            x = centers(1,1);
            y = centers(1,2);
            radii_left(1,k) = diameters/2;
            area_pupil_left(1,k) = pi * radii_left(1,k)^2;

            % Uncomment the below 6 lines to see the contour overlayed on
            % the pupil and write them into a file
            
            % imshow(I);
            % hold on;
            % contour(I_fill,'-r');
            % f=getframe(gca)
            % [X, map] = frame2im(f);
            % imwrite(X,fname2)
        end
        
        h = time_left(1,1);
        m = time_left(1,2);
        s = time_left(1,3);
        hour_left = time_left(:,1) - h;
        min_left = time_left(:,2) - m;
        sec_left = time_left(:,3) - s;
        time_left = (3600 .* hour_left) + (60 .* min_left) + sec_left; 
        
        xlswrite('State_of_Light_Right.xlsx',state_of_light_left);
        xlswrite('Area_Pupil_Right.xlsx',area_pupil_left);
        xlswrite('Radii_Right.xlsx',radii_left);
        xlswrite('TimeStamp_Left.xlsx',time_left);

    end
    
    % Plotting the Area of Right and Left
    state_of_light_right = state_of_light_right * 10^4;
    state_of_light_left = state_of_light_left * 10^4;
    
    figure;
    ys = smooth(time_stamp_right,area_right,0.1,'rloess');
    plot(time_stamp_right,ys,'r')
    hold on
    
    ys = smooth(time_stamp_left,area_left,0.1,'rloess');
    plot(time_stamp_left,ys,'b')
    
    % Saving and returning the plot as an image
    F = getframe(gca);
    Image = F.cdata;
    figure; imshow( Image );
    
    plot_leftandright = Image;
 
end

