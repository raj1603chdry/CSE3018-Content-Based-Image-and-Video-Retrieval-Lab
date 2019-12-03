function[x] = pearson_correlation_coefficient(record, query)
% Function to find the pearson correlation coefficient between the record
% and the query
x = corr2(record, query);
return
