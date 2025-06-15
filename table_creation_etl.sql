
CREATE OR REPLACE TABLE ETL.user (
    deviceid STRING NOT NULL, 
    lang STRING NOT NULL, 
    district STRING NOT NULL, 
    platform STRING NOT NULL, 
    install_dt DATE NOT NULL, 
    campaign_id STRING NULL -- Optional field
);

CREATE OR REPLACE TABLE ETL.content (
    content_id STRING NOT NULL, 
    createdAt TIMESTAMP NOT NULL, 
    newsLanguage STRING NOT NULL, 
    categories STRING NOT NULL, 
    author STRING NULL -- Optional field
);

CREATE or REPLACE TABLE ETL.event (
    deviceid STRING NOT NULL, 
    content_id STRING not NULL, 
    eventtimestamp INT NOT NULL, 
    timespent FLOAT  NULL, 
    eventname STRING NOT NULL
);

