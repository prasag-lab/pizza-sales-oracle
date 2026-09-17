LOAD DATA
INFILE 'pizza_types.csv'
APPEND
INTO TABLE pizza_types
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
TRAILING NULLCOLS
(pizza_type_id, name, category)
