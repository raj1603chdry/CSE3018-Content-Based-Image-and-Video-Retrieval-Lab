function[x] = city_block_distance(record, query)
% Function to find the city block distance between the record and the query
x = sum(abs(record - query));
return