function[x] = canberra_distance(record, query)
% Function to find the canberra distance between the record and the query
x = (abs(record - query)) / (abs(record) + abs(query));
return