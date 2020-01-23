# CSE3018 Content Based Image and Video Retrieval Lab

## WEEK8 - Implementing various distance/similarity measures

### Available folder:

* _./datas/_ - Folder that contains input csv file and output excel files.

### Available files:

* _main.m_ - The script that reads the csv, calculates all the distances using the different distance measure from the query record. After, finding the individual distance, the individual records are ranked and the top 20 records for each metric are recorded.
* *canberra_distance.m* - Function to find the canberra distance between the record and the query.
* *chi_square_distance.m* - Function to find the chi square distance between the record and the query.
* *city_block_distance.m* - Function to find the city block distance between the record and the query.
* *cosine_distance.m* - Function to find the cosine distance between the record and the query.
* *earth_movers_distance.m* - Function to find the earth movers distance between the record and the query.
* *euclidean_distance.m* - Function to find the euclidean distance between the record and the query.
* *hamming_distance.m* - Function to find the hamming distance between the record and the query.
* *maximum_value_distance.m* - Function to find the maximum value distance between the record and the query.
* *minkowski_distance.m* - Function to find the minkowski distance between the record and the query.
* *pearson_correlation_coefficient.m* - Function to find the pearson correlation coefficient between the record and the query.
* *sum_absolute_difference.m* - Function to find the sum of absolute difference between the record and the query.
* *sum_squared_absolute_difference.m* - Function to find the sum of absolute squared difference between the record and the query.