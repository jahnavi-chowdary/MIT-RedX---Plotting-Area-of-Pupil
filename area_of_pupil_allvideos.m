function [state_of_light_right state_of_light_left area_pupil_right area_pupil_left] = area_of_pupil_allvideos(video_right,video_left)

    numFrames_right = video_right.NumberOfFrames;
    n=numFrames_right;
    state_of_light_right = zeros(1,n);
    for k = 1:1:n
        
        I = read(video_right,k);
        
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
        
    end
    
    numFrames_left = video_left.NumberOfFrames;
    n=numFrames_left;
    state_of_light_left = zeros(1,n);
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
        
    end

end

