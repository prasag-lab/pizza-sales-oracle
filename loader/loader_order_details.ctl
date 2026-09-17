LOAD DATA
INFILE 'order_details.csv'
APPEND
INTO TABLE order_details
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
TRAILING NULLCOLS
(order_details_id, order_id, pizza_id, quantity)
