create index eventaudit_objid1_index
    on eventaudit (objid1);

create index eventaudit_objid2_index
    on eventaudit (objid2);

create index eventaudit_objid3_index
    on eventaudit (objid3);

create index eventaudit_objid4_index
    on eventaudit (objid4);

create index idx_po_u_name_d_id
    on persistentobject (upper(name::text), d, id);

create index idx_po_u_description_d_id
    on persistentobject (upper(description::text), d, id);

create index wfpackageaudit_docchronid_index
    on wfpackageaudit (docchronid);

create index wfpackageaudit_docid_index
    on wfpackageaudit (docid);

create index wfpackageaudit_task_index
    on wfpackageaudit (task);

create index wfpackageaudit_task_repeatcounter_index
    on wfpackageaudit (task, repeatcounter);

create index wfpackageaudit_workflow_index
    on wfpackageaudit (workflow);

create index noteaudit_taskid_repeatcounter_index
    on noteaudit (taskid, repeatcounter);

create index noteaudit_usernote_index
    on noteaudit (usernote);

create index attachobjtaskaudit_objid_index
    on attachobjtaskaudit (objid);

create index attachobjtaskaudit_taskid_index
    on attachobjtaskaudit (taskid);

create index attachobjtaskaudit_wfid_index
    on attachobjtaskaudit (wfid);

create index taskdelegateaudit_taskid_index
    on taskdelegateaudit (taskid);

ALTER TABLE jobschedule ADD COLUMN schedule_type VARCHAR(10);
ALTER TABLE jobschedule ADD COLUMN selecteddays VARCHAR(255);
UPDATE jobschedule SET schedule_type = 'interval' WHERE runmode < 2;
UPDATE jobschedule SET schedule_type = 'exactDates' WHERE runmode > 1;
ALTER TABLE jobschedule ALTER COLUMN runinterval DROP NOT NULL;
UPDATE jobschedule SET runinterval = NULL WHERE runmode > 1;
UPDATE jobschedule SET runinterval = 10 WHERE runinterval = 0 AND runmode < 2;
UPDATE jobschedule SET selecteddays = 'Sat' WHERE runmode = 3;