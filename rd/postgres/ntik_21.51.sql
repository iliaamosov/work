INSERT INTO cs.jobschedule (id, name, description, jobclass, runmode, runinterval, startdate,
                            enddate, runlast, runnext, active)
VALUES (DEFAULT, 'RefreshEncryptionKeysJob', 'Обновление ключей шифрования паролей',
        'ru.ntik.cs.custom.ntik.jobs.RefreshEncryptionKeysJob', 4, 2,
        '2021-09-22 21:00:00.000000 +00:00', '2021-09-22 21:00:00.000000 +00:00', null, null, true);

CREATE TABLE CSUSERSTATUSINFO
(
    ID             BIGSERIAL NOT NULL,
    DELEGATEUSER   BIGINT,
    DELEGATIONFROM TIMESTAMP,
    DELEGATIONTILL TIMESTAMP,
    ABSENCECAUSE   NUMERIC(5, 0),
    COMMENT        VARCHAR(1000),
    CSUSER         BIGINT -- temp field
);

CREATE UNIQUE INDEX IDX_PRIMARY_USERSTATUSINFO ON CSUSERSTATUSINFO (ID);

ALTER TABLE CSUSERSTATUSINFO
    ADD CONSTRAINT FK_USERSTATUS_DELEGATEUSER FOREIGN KEY (DELEGATEUSER) REFERENCES CSUSER (ID);

insert into CSUSERSTATUSINFO (delegateuser, delegationfrom, delegationtill, csuser)
select delegateuser, delegationfrom, delegationtill, id
from csuser;

alter table csuser
    add column STATUSINFO BIGINT;

UPDATE CSUSER u
SET STATUSINFO = (SELECT ID FROM CSUSERSTATUSINFO WHERE CSUSER = u.ID)
WHERE STATUSINFO IS NULL;

ALTER TABLE CSUSER ALTER COLUMN STATUSINFO SET NOT NULL;

ALTER TABLE CSUSER
    ADD CONSTRAINT FK_CSUSER_STATUSINFO FOREIGN KEY (STATUSINFO) REFERENCES CSUSERSTATUSINFO (ID);

-- Добавление внешней таблицы
INSERT INTO persistentobject (name, description, created, creator, modified, modifier, objType, d)
VALUES ('csuserstatusinfo', 'csuserstatusinfo', now(), 102, now(), 102,
        (select ot.id from objecttype ot join persistentobject po on po.id = ot.id where po.name = 'externaltable'),
        (select ot.id from objecttype ot join persistentobject po on po.id = ot.id where po.name = 'externaltable'));
INSERT INTO securedobject (id, acl, owner)
VALUES ((SELECT MAX(id) FROM persistentobject), (SELECT ot.id FROM acl ot join persistentobject po on po.id = ot.id where upper (po.name) like 'DEFAULT ACL'), 102);
INSERT INTO externaltable(id, cssystem) values((SELECT MAX(id) FROM persistentobject), true);



--атрибут  statusinfo for csuser
insert into persistentobject (name, description, created, creator, modified, modifier, objType, d)
values (
           'statusinfo',
           'attribute for CSUser',
           current_timestamp,
           (select u.id from csuser u join persistentobject po on po.id = u.id where po.name='admin user'),
           current_timestamp,
           (select u.id from csuser u join persistentobject po on po.id = u.id where po.name='admin user'),
           (select ot.id from objecttype ot join persistentobject po on po.id = ot.id where po.name='attribute'),
           (select distinct po.d from persistentobject po join attribute at on po.id = at.id)
    );

insert into attribute (id, objectType, attributeSize, attributeType, extended)
values (
           (select po.id from persistentobject po where po.name = 'statusinfo'
                                                    and po.description = 'attribute for CSUser'),
           (select po.id from persistentobject po where po.name = 'csuser'
                                                    and po.d = (select distinct po1.d from persistentobject po1 join objecttype ot1 on po1.id = ot1.id)),
           19, 1, true
       );

insert into attributeparams (attribute, objtype, showinsearch, own, extendedattrparams, searchable)
values (
           (select po.id from persistentobject po where po.name = 'statusinfo'
                                                    and po.description = 'attribute for CSUser'),
           (select po.id from persistentobject po where po.name = 'csuser'
                                                    and po.d = (select distinct po1.d from persistentobject po1 join objecttype ot1 on po1.id = ot1.id)),
           false, true, 1, false
       );

delete from attributeparams where attribute in (select id from persistentobject where name in ('delegateuser', 'delegationfrom', 'delegationtill'));
delete from localeattrs where attribute in (select id from persistentobject where name in ('delegateuser', 'delegationfrom', 'delegationtill'));
delete from attribute where id in (select id from persistentobject where name in ('delegateuser', 'delegationfrom', 'delegationtill'));
delete from persistentobject where name in ('delegateuser', 'delegationfrom', 'delegationtill');

ALTER TABLE CSUSERSTATUSINFO DROP COLUMN CSUSER;
ALTER TABLE CSUSER DROP COLUMN delegateuser;
ALTER TABLE CSUSER DROP COLUMN delegationfrom;
ALTER TABLE CSUSER DROP COLUMN delegationtill;

insert into jobschedule(name, description, jobclass, runmode, runinterval, startdate,
                        enddate, runlast, runnext, active)
values ('BusinesstripVacationStatusesSetter', 'Обновление статусов пользователей по отпускам и командировкам',
        'ru.ntik.cs.custom.ntik.jobs.BusinesstripVacationStatusesSetter', 1, 0,
        '2021-12-01 11:57:26.105000 +00:00', '2021-12-01 11:57:44.206000 +00:00', null, null,
        false);

insert into jobschedule(name, description, jobclass, runmode, runinterval, startdate,
                        enddate, runlast, runnext, active)
values ('RemoveAbsenceStatusesJob', 'Удаление неактуальных статусов отсутствия пользователей',
        'ru.ntik.cs.custom.ntik.jobs.RemoveAbsenceStatusesJob', 1, 0,
        '2021-12-01 11:57:26.105000 +00:00', '2021-12-01 11:57:44.206000 +00:00', null, null,
        false);

