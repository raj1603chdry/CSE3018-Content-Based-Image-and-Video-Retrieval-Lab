function[x,y] = getCCV(img, i, j, VISITED)
% Function to find the patches in the image for the given pixel at img(i,
% j)

% Finding the dimensions of the image
[s0, s1] = size(img);

% Checking if indices are out of bounds
if i<1 || i>s0 || j<1 || j>s1
    x = 0;
    y = VISITED;
    return
end

% Checking if the current pixel is already visited
if VISITED(i, j) == 1
    x = 0;
    y = VISITED;
    return
end

% Checking if all the pixels in the image are same to prevent infinite
% recursion
if numel(unique(img)) == 1
   x = s0*s1;
   y = ones(s0, s1);
   return
end

% Procedure if current pixel is not visited already

n = 1;  % Initializing the frequency of the current patch
VISITED(i, j) = 1;  % Marking the current pixel as visited

% Checking for the patch in the 8 neighbouring pixels
%%%%%%%%%%%%%%%%%%
% ||   | * |   ||%
% ||   | * |   ||%
% ||   |   |   ||%
%%%%%%%%%%%%%%%%%%
if i ~= 1
    if img(i, j) == img(i-1, j)
        [ni, nv] = getCCV(img, i-1, j, VISITED);
        n = n + ni;
        VISITED = nv;
    end
end
%%%%%%%%%%%%%%%%%%
% ||   |   |   ||%
% ||   | * |   ||%
% ||   | * |   ||%
%%%%%%%%%%%%%%%%%%
if i ~= s0
    if img(i, j) == img(i+1, j)
        [ni, nv] = getCCV(img, i+1, j, VISITED);
        n = n + ni;
        VISITED = nv;
    end
end
%%%%%%%%%%%%%%%%%%
% ||   |   |   ||%
% || * | * |   ||%
% ||   |   |   ||%
%%%%%%%%%%%%%%%%%%
if j ~= 1
    if img(i, j) == img(i, j-1)
        [ni, nv] = getCCV(img, i, j-1, VISITED);
        n = n + ni;
        VISITED = nv;
    end
end
%%%%%%%%%%%%%%%%%%
% ||   |   |   ||%
% ||   | * | * ||%
% ||   |   |   ||%
%%%%%%%%%%%%%%%%%%
if j ~= s1
    if img(i, j) == img(i, j+1)
        [ni, nv] = getCCV(img, i, j+1, VISITED);
        n = n + ni;
        VISITED = nv;
    end
end
%%%%%%%%%%%%%%%%%%
% || * |   |   ||%
% ||   | * |   ||%
% ||   |   |   ||%
%%%%%%%%%%%%%%%%%%
if (i~=1 && j~=1)
    if img(i, j) == img(i-1, j-1)
        [ni, nv] = getCCV(img, i-1, j-1, VISITED);
        n = n + ni;
        VISITED = nv;
    end
end
%%%%%%%%%%%%%%%%%%
% ||   |   | * ||%
% ||   | * |   ||%
% ||   |   |   ||%
%%%%%%%%%%%%%%%%%%
if (i~=1 && j~=s1)
    if img(i, j) == img(i-1, j+1)
        [ni, nv] = getCCV(img, i-1, j+1, VISITED);
        n = n + ni;
        VISITED = nv;
    end
end
%%%%%%%%%%%%%%%%%%
% ||   |   |   ||%
% ||   | * |   ||%
% || * |   |   ||%
%%%%%%%%%%%%%%%%%%
if (i~=s0 && j~=1)
    if img(i, j) == img(i+1, j-1)
        [ni, nv] = getCCV(img, i+1, j-1, VISITED);
        n = n + ni;
        VISITED = nv;
    end
end
%%%%%%%%%%%%%%%%%%
% ||   |   |   ||%
% ||   | * |   ||%
% ||   |   | * ||%
%%%%%%%%%%%%%%%%%%
if (i~=s0 && j~=s1)
    if img(i, j) == img(i+1, j+1)
        [ni, nv] = getCCV(img, i+1, j+1, VISITED);
        n = n + ni;
        VISITED = nv;
    end
end

% Returning the final pixel count in the patch with the updated VISITED matrix 
x = n;
y = VISITED;
return
