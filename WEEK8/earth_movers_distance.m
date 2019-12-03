function[x] = earth_movers_distance(record, query)
% Function to find the earth movers distance between the record and the
% query
x = sum(abs(cumsum(record) - cumsum(query)));
return
