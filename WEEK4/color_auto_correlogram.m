function correlogram_vector=color_auto_correlogram(I,distance_vector)
% This function creates the auto-correlogram vector for an input image of
% any size. The different distances which is assumed apriori can be user-defined in a vector.
% It implements the algorithm as defined in Huang et al. paper 'Image Indexing using color
% autocorelogram'
% Input:
% I=The uint8 matrix representing the color image
% distance_vector= The vector representating the different distances in
% which the color distribution is calculated.
% Output:
% correlogram_vector=This is a straight vector representating the
% probabilities of occurence of 64 quantized colors. Its total dimension is
% 64n X 1; where n is the number of different inf-norm distances
% Usage: (To create the auto-correlogram vector for user-defined distances)
% I=imread('peppers.png'); distance_vector=[1 3];
% correlogram_vector=color_auto_correlogram(I,distance_vector);
% Contact Author:
% Soumyabrata Dev
% E-mail: soumyabr001@e.ntu.edu.sg
% http://www3.ntu.edu.sg/home2012/soumyabr001/
correlogram_vector=[];
[Y,X]=size(rgb2gray(I));
% quantize image into 64 colors = 4x4x4, in RGB space
[img_no_dither, ~] = rgb2ind(I, 256, 'nodither');
% figure, imshow(img_no_dither, map);
%rgb = ind2rgb(img_no_dither, map); % rgb = double(rgb)
[~,d]=size(distance_vector);
count_matrix=zeros(256,d);   total_matrix=zeros(256,d);
prob_dist=cell(1,d);
for serial_no=1:1:d
    for x=1:X
        for y=1:Y
            color=img_no_dither(y,x);
       
            % At the given distance 
            [positive_count,total_count]=get_n(distance_vector(serial_no),x,y,color,img_no_dither,X,Y);
            count_matrix(color+1,serial_no)=count_matrix(color+1,serial_no)+positive_count;
            total_matrix(color+1,serial_no)=total_matrix(color+1,serial_no)+total_count;       
        end
    end
    prob_dist{serial_no}=count_matrix(:,serial_no)./(1+total_matrix(:,serial_no));
end
for serial_no=1:d
    correlogram_vector=cat(1,correlogram_vector,prob_dist{serial_no});
end
end