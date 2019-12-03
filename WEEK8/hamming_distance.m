function[x] = hamming_distance(record, query)
% Function to find the hamming distance between the record and the query
x = pdist2(record, query, 'hamming');
return
