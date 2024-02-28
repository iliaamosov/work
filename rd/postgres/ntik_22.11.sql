ALTER TABLE workflowtemplate_config ADD COLUMN objclassifier VARCHAR(63);
ALTER TABLE workflowtemplate_config ALTER COLUMN objtype DROP NOT NULL