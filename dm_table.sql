CREATE OR REPLACE TABLE foundation.retention_summary (
    install_dt DATE NOT NULL,
    D1_retained INT NOT NULL,
    D2_retained INT NOT NULL,
    W1_retained INT NOT NULL,
    M1_retained INT NOT NULL,
    M3_retained INT NOT NULL
);


CREATE OR REPLACE TABLE foundation.user_retention_details (
    deviceid STRING NOT NULL,
    install_dt DATE NOT NULL,
    retention_period STRING NOT NULL, -- Possible values: 'D1', 'D2', 'W1', 'M1', 'M3'
    retained BOOLEAN NOT NULL
);


CREATE OR REPLACE TABLE foundation.weekly_churn (
    install_dt DATE NOT NULL,
    week_number INT NOT NULL, -- Week since install (e.g., Week 1, Week 2...)
    churned_users INT NOT NULL,
    churn_rate FLOAT NOT NULL -- (1 - Retention Rate)
);


CREATE OR REPLACE TABLE foundation.monthly_churn (
    install_dt DATE NOT NULL,
    month_number INT NOT NULL, -- Month since install (e.g., Month 1, Month 2...)
    churned_users INT NOT NULL,
    churn_rate FLOAT NOT NULL -- (1 - Retention Rate)
);
