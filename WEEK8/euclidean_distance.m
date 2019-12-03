function[x] = euclidean_distance(record, query)
% Function to find the euclidean distance between the record and the query
x = norm(record - query);
return