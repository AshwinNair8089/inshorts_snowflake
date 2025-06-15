

--create table in compact layer:-
-----------------------------------------------------
CREATE or REPLACE TABLE compact.event_content_user (
    deviceid STRING NOT NULL, 
    content_id STRING not NULL, 
    eventtimestamp INT NOT NULL, 
    timespent FLOAT NULL, 
    eventname STRING NOT NULL,
	createdAt TIMESTAMP  NULL, 
    newsLanguage STRING NULL, 
    categories STRING  NULL, 
    author STRING NULL, 
    lang STRING  NULL, 
    district STRING  NULL, 
    platform STRING  NULL, 
    install_dt DATE  NULL, 
    campaign_id STRING NULL
);


-----------------------------------------------------