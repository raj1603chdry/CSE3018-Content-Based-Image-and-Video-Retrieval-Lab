function [positive_count,total_count]=get_n(n,x,y,color,img_no_dither,X,Y)
% This function is useful to get the validity map of the neighborhood case.
% It can handle any number of neighborhood distances.
% Input
% n=The order of the neighborhood
% x & y= x y co-ordinates of the given pixel
% color= particular quantized color
% img_no_dither= The color quantized image matrix
% X & Y= The original dimensions of the input image
% Output
% positive_count= The number of occurences which have the same color
% total_count= The total number of valid cases for this particular instant
    valid_vector8n=zeros(1,8*n); % This is because of the propoerty of inf-norm. Each distance has 8 times the order
    positive_count=0;   total_count=0;
    nbrs_x=zeros(1,8*n);    nbrs_y=zeros(1,8*n);
    % The counting of the pixels is done in the following manner: From the
    % given pixel, go left-->up-->right-->down-->left-->up
    % Y co-ordinates of nbrs
    nbrs_y(1)=y;
    d=1;
    for k=2:1+n
       nbrs_y(k)=y-d;
       d=d+1;
    end
    
    nbrs_y(1+n:1:3*n+1)=y-n;
    
    d=0;
    for k=3*n+1:5*n+1
       nbrs_y(k)=y-n+d;
       d=d+1;
    end
    
    nbrs_y(5*n+1:1:7*n+1)=y+n;
    
    d=0;
    for k=7*n+1:1:7*n+1+(n-1)
       nbrs_y(k)=y+n-d;
       d=d+1;
    end
    
    % X co-ordinates of nbrs
    nbrs_x(1)=x-n;
    
    nbrs_x(2:1:1+n)=x-n;
    
    d=0;
    for k=1+n:1:3*n+1
        nbrs_x(k)=x-n+d;
        d=d+1;
    end
    
    nbrs_x(3*n+1:5*n+1)=x+n;
    
    d=0;
    for k=5*n+1:7*n+1
        nbrs_x(k)=x+n-d;
        d=d+1;
    end
        
    nbrs_x(7*n+1:7*n+1+(n-1))=x-n;
    
    % Assigning the validity of the neighborhood
    for i=1:8*n
        
        if nbrs_x(i)>0 && nbrs_x(i)<=X && nbrs_y(i)>0 && nbrs_y(i)<=Y
            valid_vector8n(i)=1;
        
        else
            valid_vector8n(i)=0;
    
        end
    
    end
    
    
    % Couting the number of common colors in the valid areas of the
    % neighborhood.
    for j=1:8*n
       if valid_vector8n(j)==1
          data= img_no_dither(nbrs_y(j),nbrs_x(j));
          if (data==color)
              positive_count=positive_count+1;
          end
          total_count=total_count+1;
       end
    end
end