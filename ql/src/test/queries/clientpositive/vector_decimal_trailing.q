set hive.mapred.mode=nonstrict;
SET hive.vectorized.execution.enabled=true;
set hive.fetch.task.conversion=none;

DROP TABLE IF EXISTS DECIMAL_TRAILING_txt;
DROP TABLE IF EXISTS DECIMAL_TRAILING;

CREATE TABLE DECIMAL_TRAILING_txt (
  id int,
  a decimal(10,4),
  b decimal(15,8)
  )
ROW FORMAT DELIMITED
   FIELDS TERMINATED BY ','
STORED AS TEXTFILE;

LOAD DATA LOCAL INPATH '../../data/files/kv10.txt' INTO TABLE DECIMAL_TRAILING_txt;

CREATE TABLE DECIMAL_TRAILING (
  id int,
  a decimal(10,4),
  b decimal(15,8)
  )
STORED AS ORC;

INSERT OVERWRITE TABLE DECIMAL_TRAILING SELECT * FROM DECIMAL_TRAILING_txt;

EXPLAIN VECTORIZATION DETAIL
SELECT * FROM DECIMAL_TRAILING ORDER BY id;
SELECT * FROM DECIMAL_TRAILING ORDER BY id;

DROP TABLE DECIMAL_TRAILING_txt;
DROP TABLE DECIMAL_TRAILING;
