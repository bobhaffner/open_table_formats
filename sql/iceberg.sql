-- DROP TABLE sampledb.customer_orders_iceberg;
-- create iceberg table from athena table via CTAS query
CREATE TABLE sampledb.customer_orders_iceberg WITH (
    table_type = 'ICEBERG',
    format = 'PARQUET',
    location = 's3://ids-sample-iceberg-datasets/sampledb/customer_orders_iceberg',
    is_external = false
) AS
SELECT *
FROM sampledb.customer_orders;
-- basic queries
SELECT COUNT(*) as cnt
FROM customer_orders_iceberg;
SELECT *
FROM customer_orders_iceberg
LIMIT 5;
SELECT orderstatus,
    COUNT(*) as cnt
FROM customer_orders_iceberg
GROUP BY orderstatus;
-- update a phone number
SELECT phone,
    *
FROM customer_orders_iceberg
WHERE custkey = '448095821'
UPDATE customer_orders_iceberg
SET phone = '8675309'
WHERE custkey = '448095821';
SELECT phone,
    *
FROM customer_orders_iceberg
WHERE custkey = '448095821';
SELECT *
FROM "customer_orders_iceberg$snapshots";
-- point in time query with snapshot id
SELECT phone
FROM customer_orders_iceberg FOR VERSION AS OF 6970628492193375188
WHERE custkey = '448095821';
-- point in time query using timestamp
SELECT phone
FROM customer_orders_iceberg FOR TIMESTAMP AS OF (current_timestamp - interval '4' minute)
WHERE custkey = '448095821';
-- schema evolution - adding Day Of Week
ALTER TABLE customer_orders_iceberg
ADD COLUMNS (dow int);
UPDATE customer_orders_iceberg
SET dow = day_of_week(CAST(orderdate as date));
SELECT orderdate,
    dow
FROM customer_orders_iceberg
LIMIT 5;