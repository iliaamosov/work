alter table correspondent add checkpoint VARCHAR(100);
alter table correspondent add ecmsystem NUMERIC(2);
alter table correspondent add active BOOLEAN default true;

ALTER TABLE workflowtemplate ADD active BOOLEAN DEFAULT true;

CREATE INDEX taskaudit_workflowaudit_index ON taskaudit (workflowaudit);
CREATE INDEX attachobjtaskaudit_chronid_idx ON attachobjtaskaudit (chronid);
ANALYZE attachobjtaskaudit;
