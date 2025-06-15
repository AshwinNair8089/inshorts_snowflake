

INSERT INTO foundation.retention_summary
SELECT 
    u.install_dt, 
    COUNT(DISTINCT CASE WHEN e.event_date = DATEADD(DAY, 1, u.install_dt) THEN e.deviceid END) AS D1_retained,
    COUNT(DISTINCT CASE WHEN e.event_date = DATEADD(DAY, 2, u.install_dt) THEN e.deviceid END) AS D2_retained,
    COUNT(DISTINCT CASE WHEN e.event_date BETWEEN u.install_dt AND DATEADD(DAY, 7, u.install_dt) THEN e.deviceid END) AS W1_retained,
    COUNT(DISTINCT CASE WHEN e.event_date BETWEEN u.install_dt AND DATEADD(MONTH, 1, u.install_dt) THEN e.deviceid END) AS M1_retained,
    COUNT(DISTINCT CASE WHEN e.event_date BETWEEN u.install_dt AND DATEADD(MONTH, 3, u.install_dt) THEN e.deviceid END) AS M3_retained
FROM ETL.user u
LEFT JOIN (
    SELECT deviceid, DATE(eventtimestamp) AS event_date
    FROM ETL.event
) e ON u.deviceid = e.deviceid
GROUP BY u.install_dt;


INSERT INTO foundation.user_retention_details
SELECT 
    u.deviceid, 
    u.install_dt, 
    retention_period,
    CASE WHEN e.event_date IS NOT NULL THEN TRUE ELSE FALSE END AS retained
FROM (
    SELECT deviceid, install_dt, 'D1' AS retention_period, DATEADD(DAY, 1, install_dt) AS target_date FROM ETL.user
    UNION ALL
    SELECT deviceid, install_dt, 'D2' AS retention_period, DATEADD(DAY, 2, install_dt) AS target_date FROM ETL.user
    UNION ALL
    SELECT deviceid, install_dt, 'W1' AS retention_period, DATEADD(DAY, 7, install_dt) AS target_date FROM ETL.user
    UNION ALL
    SELECT deviceid, install_dt, 'M1' AS retention_period, DATEADD(MONTH, 1, install_dt) AS target_date FROM ETL.user
    UNION ALL
    SELECT deviceid, install_dt, 'M3' AS retention_period, DATEADD(MONTH, 3, install_dt) AS target_date FROM ETL.user
) u
LEFT JOIN (
    SELECT deviceid, DATE(eventtimestamp) AS event_date
    FROM ETL.event
) e ON u.deviceid = e.deviceid AND u.target_date = e.event_date;


---------------------------------------------------------------------------


INSERT INTO foundation.weekly_churn
SELECT 
    u.install_dt, 
    FLOOR(DATEDIFF(DAY, u.install_dt, e.event_date) / 7) + 1 AS week_number,
    COUNT(DISTINCT u.deviceid) - COUNT(DISTINCT e.deviceid) AS churned_users,
    (COUNT(DISTINCT u.deviceid) - COUNT(DISTINCT e.deviceid)) / COUNT(DISTINCT u.deviceid) AS churn_rate
FROM ETL.user u
LEFT JOIN (
    SELECT deviceid, DATE(eventtimestamp) AS event_date
    FROM ETL.event
   
) e ON u.deviceid = e.deviceid
  WHERE e.event_date BETWEEN u.install_dt AND DATEADD(WEEK, 4, u.install_dt)-- Covers first month
GROUP BY u.install_dt, week_number;



INSERT INTO foundation.monthly_churn
SELECT 
    u.install_dt, 
    FLOOR(DATEDIFF(DAY, u.install_dt, e.event_date) / 30) + 1 AS month_number,
    COUNT(DISTINCT u.deviceid) - COUNT(DISTINCT e.deviceid) AS churned_users,
    (COUNT(DISTINCT u.deviceid) - COUNT(DISTINCT e.deviceid)) / COUNT(DISTINCT u.deviceid) AS churn_rate
FROM ETL.user u
LEFT JOIN (
    SELECT deviceid, DATE(eventtimestamp) AS event_date
    FROM ETL.event    
) e ON u.deviceid = e.deviceid
WHERE e.event_date BETWEEN u.install_dt AND DATEADD(MONTH, 3, u.install_dt) -- Covers first quarter
GROUP BY u.install_dt, month_number;

