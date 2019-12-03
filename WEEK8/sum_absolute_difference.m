function[x] = sum_absolute_difference(record, query)
% Function to find the sum of absolute difference between the record and
% the query
x = sum(abs(record - query));
return