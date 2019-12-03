function[x] = sum_squared_absolute_difference(record, query)
% Function to find the sum of absolute squared difference between the record and
% the query
x = sum((record - query).^2);
return