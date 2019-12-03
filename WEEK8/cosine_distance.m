function[x] = cosine_distance(record, query)
% Function to find the cosine distance between the record and the query
x = 1 - (sum(record .* query) / sqrt(sum(record.^2)*sum(query.^2)));
return