ALTER TABLE cs.workflowtemplate ADD show_in_list BOOLEAN;
UPDATE cs.workflowtemplate SET show_in_list = TRUE WHERE show_in_list IS NULL;