function[x] = maximum_value_distance(record, query)
% Function to find the maximum value distance between the record and the query
x = max(abs(record - query));
return