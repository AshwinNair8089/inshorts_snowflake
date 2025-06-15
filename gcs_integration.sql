
--creation of integrations

DROP INTEGRATION gcs_integration_nis
DROP STAGE gcs_stage_user

SHOW STORAGE INTEGRATIONS;

CREATE STORAGE INTEGRATION gcs_integration_nis
TYPE = EXTERNAL_STAGE
STORAGE_PROVIDER = 'GCS'
ENABLED = TRUE
STORAGE_ALLOWED_LOCATIONS = ('gcs://nis_interview_task_de/');


-- creation of stages for each data source
CREATE STAGE gcs_stage_user
STORAGE_INTEGRATION = gcs_integration_nis
URL = 'gcs://nis_interview_task_de/user/'
FILE_FORMAT = (TYPE = CSV, FIELD_OPTIONALLY_ENCLOSED_BY = '"');


CREATE STAGE gcs_stage_event
STORAGE_INTEGRATION = gcs_integration_nis
URL = 'gcs://nis_interview_task_de/event/'
FILE_FORMAT = (TYPE = CSV, FIELD_OPTIONALLY_ENCLOSED_BY = '"');

CREATE STAGE gcs_stage_content
STORAGE_INTEGRATION = gcs_integration_nis
URL = 'gcs://nis_interview_task_de/content/'
FILE_FORMAT = (TYPE = CSV, FIELD_OPTIONALLY_ENCLOSED_BY = '"');

