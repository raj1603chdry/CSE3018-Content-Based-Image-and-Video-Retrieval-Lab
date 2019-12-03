function[x] = minkowski_distance(record, query)
% Function to find the minkowski distance between the record and the query
x = pdist2(record, query, 'minkowski');
return