
--creation of file format

CREATE FILE FORMAT my_csv_format
TYPE = CSV
FIELD_OPTIONALLY_ENCLOSED_BY = '"'
FIELD_DELIMITER = ','
SKIP_HEADER = 1
NULL_IF = ('NULL', '')
EMPTY_FIELD_AS_NULL = TRUE;


