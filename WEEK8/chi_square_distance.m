function[x] = chi_square_distance(record, query)
% Function to find the chi square distance between the record and the query
x = sum((record - query).^2 / (record + query)) / 2;
return