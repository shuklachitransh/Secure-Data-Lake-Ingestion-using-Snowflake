CREATE DATABASE snowdb;
CREATE SCHEMA db_snowflake;

CREATE OR REPLACE STORAGE integration aws_s3_integration
type = external_stage
storage_provider = 'S3'
enabled = true
storage_aws_role_arn = 'arn:aws:iam::767397922128:role/demo-2025-aws-snowflake'
storage_allowed_locations = ('s3://demo-2025-aws-snowflake/');

SHOW INTEGRATIONS;

DESC integration aws_s3_integration;

GRANT usage on  integration aws_s3_integration to role accountadmin;

CREATE OR REPLACE FILE FORMAT demo_format
TYPE = 'CSV'
FIELD_DELIMITER = ','
SKIP_HEADER = 1
ERROR_ON_COLUMN_COUNT_MISMATCH = FALSE;

CREATE OR REPLACE stage demo_aws_stage
storage_integration = aws_s3_integration
file_format = demo_format
url = 's3://demo-2025-aws-snowflake/';

List @demo_aws_stage
remove @demo_aws_stage/Customer_Data.csv;

CREATE OR REPLACE TEMPORARY TABLE demo_customer_info (
  custid STRING,
  balance FLOAT,
  balance_frequency FLOAT,
  purchases FLOAT,
  oneoff_purchases FLOAT,
  installments_purchases FLOAT,
  cash_advance FLOAT,
  purchases_frequency FLOAT,
  oneoff_purchases_frequency FLOAT,
  purchases_installments_frequency FLOAT,
  cash_advance_frequency FLOAT,
  cash_advance_trx INTEGER,
  purchases_trx INTEGER,
  credit_limit FLOAT,
  payments FLOAT,
  minimum_payments FLOAT,
  prc_full_payment FLOAT,
  tenure INTEGER
);

COPY INTO demo_customer_info
FROM @demo_aws_stage/Customer_Data.csv
FILE_FORMAT = (FORMAT_NAME = demo_format) -- purge = true ,means after loading the data into table delete the file
ON_ERROR = 'CONTINUE'; --skips bad records load only good records ; 'skip_file' will skip whole file

select count(*) 
from demo_customer_info
where balance >=3000  