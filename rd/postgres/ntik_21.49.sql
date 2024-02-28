create table contact
(
    id          bigserial,
    description varchar,
    email       varchar not null,
    owner_id    bigint  not null
        constraint contact_csuser_id_fk
            references csuser,
    csuser_id   bigint
        constraint contact_csuser_id_fk_2
            references csuser
);

create unique index contact_id_uindex
    on contact (id);

alter table contact
    add constraint contact_pk
        primary key (id);


-----------------------------------------------------------------------------
-----------------------------------------------------------------------------


-- create type Correspondent
insert into persistentobject (id, name, description, created, creator, modified, modifier, objType, d)
values (
           -30,
           'correspondent',
           'Correspondent object type',
           current_timestamp,
           (select u.id from csuser u join persistentobject po on po.id = u.id where po.name='admin user'),
           current_timestamp,
           (select u.id from csuser u join persistentobject po on po.id = u.id where po.name='admin user'),
           (select ot.id from objecttype ot join persistentobject po on po.id = ot.id where po.name='objecttype'),
           (select distinct po.d from persistentobject po join objecttype ot on po.id = ot.id)
       );

insert into objecttype (id, parentObjType)
values (
           (select po.id from persistentobject po where po.name = 'correspondent'
                                                    and po.d = (select distinct po1.d from persistentobject po1 join objecttype ot1 on po1.id = ot1.id)),
           (select po.id from persistentobject po where po.name = 'persistentobject'
                                                    and po.d = (select distinct po1.d from persistentobject po1 join objecttype ot1 on po1.id = ot1.id))
       );

-- attributes

--id
insert into persistentobject (name, description, created, creator, modified, modifier, objType, d)
values (
           'id',
           'attribute for Correspondent',
           current_timestamp,
           (select u.id from csuser u join persistentobject po on po.id = u.id where po.name='admin user'),
           current_timestamp,
           (select u.id from csuser u join persistentobject po on po.id = u.id where po.name='admin user'),
           (select ot.id from objecttype ot join persistentobject po on po.id = ot.id where po.name='attribute'),
           (select distinct po.d from persistentobject po join attribute at on po.id = at.id)
    );

insert into attribute (id, objectType, attributeSize, attributeType, extended)
values (
           (select po.id from persistentobject po where po.name = 'id'
                                                    and po.description = 'attribute for Correspondent'),
           (select po.id from persistentobject po where po.name = 'correspondent'
                                                    and po.d = (select distinct po1.d from persistentobject po1 join objecttype ot1 on po1.id = ot1.id)),
           19, 1, true
       );

insert into attributeparams (attribute, objtype, showinsearch, own, extendedattrparams, searchable)
values (
           (select po.id from persistentobject po where po.name = 'id'
                                                    and po.description = 'attribute for Correspondent'),
           (select po.id from persistentobject po where po.name = 'correspondent'
                                                    and po.d = (select distinct po1.d from persistentobject po1 join objecttype ot1 on po1.id = ot1.id)),
           false, false, 1, true
       );

--parent's po's attributes

insert into attributeparams (attribute, objtype, showInSearch, indexed, own, predefined, extTableName, extTableValue,
                             extTableLabel, extendedAttrParams, searchable, attrOrderInSearch, extTableTitle)
select ap.attribute,
       (select ot.id from objecttype ot join persistentobject po on po.id = ot.id where po.name = 'correspondent'),
       ap.showInSearch, ap.indexed, ap.own, ap.predefined, ap.extTableName, ap.extTableValue,
       ap.extTableLabel, ap.extendedAttrParams, ap.searchable, ap.attrOrderInSearch, ap.extTableTitle
from attributeparams ap join persistentobject apo on apo.id = ap.attribute
where apo.name in ('name','description','created','creator','modified','modifier','objtype')
  and ap.objtype = (select ot.id from persistentobject po join objecttype ot on po.id = ot.id where po.name = 'persistentobject');

--legaladdress
insert into persistentobject (name, description, created, creator, modified, modifier, objType, d)
values (
           'legaladdress',
           'attribute for Correspondent',
           current_timestamp,
           (select u.id from csuser u join persistentobject po on po.id = u.id where po.name='admin user'),
           current_timestamp,
           (select u.id from csuser u join persistentobject po on po.id = u.id where po.name='admin user'),
           (select ot.id from objecttype ot join persistentobject po on po.id = ot.id where po.name='attribute'),
           (select distinct po.d from persistentobject po join attribute at on po.id = at.id)
    );

insert into attribute (id, objectType, attributeSize, attributeType, extended)
values (
           (select po.id from persistentobject po where po.name = 'legaladdress'
                                                    and po.description = 'attribute for Correspondent'),
           (select po.id from persistentobject po where po.name = 'correspondent'
                                                    and po.d = (select distinct po1.d from persistentobject po1 join objecttype ot1 on po1.id = ot1.id)),
           512, 0, false
       );

insert into attributeparams (attribute, objtype, showinsearch, own, extendedattrparams, searchable)
values (
           (select po.id from persistentobject po where po.name = 'legaladdress'
                                                    and po.description = 'attribute for Correspondent'),
           (select po.id from persistentobject po where po.name = 'correspondent'
                                                    and po.d = (select distinct po1.d from persistentobject po1 join objecttype ot1 on po1.id = ot1.id)),
           false, false, 1, true
       );

--address
insert into persistentobject (name, description, created, creator, modified, modifier, objType, d)
values (
           'address',
           'attribute for Correspondent',
           current_timestamp,
           (select u.id from csuser u join persistentobject po on po.id = u.id where po.name='admin user'),
           current_timestamp,
           (select u.id from csuser u join persistentobject po on po.id = u.id where po.name='admin user'),
           (select ot.id from objecttype ot join persistentobject po on po.id = ot.id where po.name='attribute'),
           (select distinct po.d from persistentobject po join attribute at on po.id = at.id)
    );

insert into attribute (id, objectType, attributeSize, attributeType, extended)
values (
           (select po.id from persistentobject po where po.name = 'address'
                                                    and po.description = 'attribute for Correspondent'),
           (select po.id from persistentobject po where po.name = 'correspondent'
                                                    and po.d = (select distinct po1.d from persistentobject po1 join objecttype ot1 on po1.id = ot1.id)),
           512, 0, false
       );

insert into attributeparams (attribute, objtype, showinsearch, own, extendedattrparams, searchable)
values (
           (select po.id from persistentobject po where po.name = 'address'
                                                    and po.description = 'attribute for Correspondent'),
           (select po.id from persistentobject po where po.name = 'correspondent'
                                                    and po.d = (select distinct po1.d from persistentobject po1 join objecttype ot1 on po1.id = ot1.id)),
           false, false, 1, true
       );

--taxid
insert into persistentobject (name, description, created, creator, modified, modifier, objType, d)
values (
           'taxid',
           'attribute for Correspondent',
           current_timestamp,
           (select u.id from csuser u join persistentobject po on po.id = u.id where po.name='admin user'),
           current_timestamp,
           (select u.id from csuser u join persistentobject po on po.id = u.id where po.name='admin user'),
           (select ot.id from objecttype ot join persistentobject po on po.id = ot.id where po.name='attribute'),
           (select distinct po.d from persistentobject po join attribute at on po.id = at.id)
    );

insert into attribute (id, objectType, attributeSize, attributeType, extended)
values (
           (select po.id from persistentobject po where po.name = 'taxid'
                                                    and po.description = 'attribute for Correspondent'),
           (select po.id from persistentobject po where po.name = 'correspondent'
                                                    and po.d = (select distinct po1.d from persistentobject po1 join objecttype ot1 on po1.id = ot1.id)),
           19, 1, false
       );

insert into attributeparams (attribute, objtype, showinsearch, own, extendedattrparams, searchable)
values (
           (select po.id from persistentobject po where po.name = 'taxid'
                                                    and po.description = 'attribute for Correspondent'),
           (select po.id from persistentobject po where po.name = 'correspondent'
                                                    and po.d = (select distinct po1.d from persistentobject po1 join objecttype ot1 on po1.id = ot1.id)),
           false, false, 1, true
       );


--checkpoint
insert into persistentobject (name, description, created, creator, modified, modifier, objType, d)
values (
           'checkpoint',
           'attribute for Correspondent',
           current_timestamp,
           (select u.id from csuser u join persistentobject po on po.id = u.id where po.name='admin user'),
           current_timestamp,
           (select u.id from csuser u join persistentobject po on po.id = u.id where po.name='admin user'),
           (select ot.id from objecttype ot join persistentobject po on po.id = ot.id where po.name='attribute'),
           (select distinct po.d from persistentobject po join attribute at on po.id = at.id)
    );

insert into attribute (id, objectType, attributeSize, attributeType, extended)
values (
           (select po.id from persistentobject po where po.name = 'checkpoint'
                                                    and po.description = 'attribute for Correspondent'),
           (select po.id from persistentobject po where po.name = 'correspondent'
                                                    and po.d = (select distinct po1.d from persistentobject po1 join objecttype ot1 on po1.id = ot1.id)),
           100, 0, false
       );

insert into attributeparams (attribute, objtype, showinsearch, own, extendedattrparams, searchable)
values (
           (select po.id from persistentobject po where po.name = 'checkpoint'
                                                    and po.description = 'attribute for Correspondent'),
           (select po.id from persistentobject po where po.name = 'correspondent'
                                                    and po.d = (select distinct po1.d from persistentobject po1 join objecttype ot1 on po1.id = ot1.id)),
           false, false, 1, true
       );

--phone
insert into persistentobject (name, description, created, creator, modified, modifier, objType, d)
values (
           'phone',
           'attribute for Correspondent',
           current_timestamp,
           (select u.id from csuser u join persistentobject po on po.id = u.id where po.name='admin user'),
           current_timestamp,
           (select u.id from csuser u join persistentobject po on po.id = u.id where po.name='admin user'),
           (select ot.id from objecttype ot join persistentobject po on po.id = ot.id where po.name='attribute'),
           (select distinct po.d from persistentobject po join attribute at on po.id = at.id)
    );

insert into attribute (id, objectType, attributeSize, attributeType, extended)
values (
           (select po.id from persistentobject po where po.name = 'phone'
                                                    and po.description = 'attribute for Correspondent'),
           (select po.id from persistentobject po where po.name = 'correspondent'
                                                    and po.d = (select distinct po1.d from persistentobject po1 join objecttype ot1 on po1.id = ot1.id)),
           100, 0, false
       );

insert into attributeparams (attribute, objtype, showinsearch, own, extendedattrparams, searchable)
values (
           (select po.id from persistentobject po where po.name = 'phone'
                                                    and po.description = 'attribute for Correspondent'),
           (select po.id from persistentobject po where po.name = 'correspondent'
                                                    and po.d = (select distinct po1.d from persistentobject po1 join objecttype ot1 on po1.id = ot1.id)),
           false, false, 1, true
       );

--email
insert into persistentobject (name, description, created, creator, modified, modifier, objType, d)
values (
           'email',
           'attribute for Correspondent',
           current_timestamp,
           (select u.id from csuser u join persistentobject po on po.id = u.id where po.name='admin user'),
           current_timestamp,
           (select u.id from csuser u join persistentobject po on po.id = u.id where po.name='admin user'),
           (select ot.id from objecttype ot join persistentobject po on po.id = ot.id where po.name='attribute'),
           (select distinct po.d from persistentobject po join attribute at on po.id = at.id)
    );

insert into attribute (id, objectType, attributeSize, attributeType, extended)
values (
           (select po.id from persistentobject po where po.name = 'email'
                                                    and po.description = 'attribute for Correspondent'),
           (select po.id from persistentobject po where po.name = 'correspondent'
                                                    and po.d = (select distinct po1.d from persistentobject po1 join objecttype ot1 on po1.id = ot1.id)),
           100, 0, false
       );

insert into attributeparams (attribute, objtype, showinsearch, own, extendedattrparams, searchable)
values (
           (select po.id from persistentobject po where po.name = 'email'
                                                    and po.description = 'attribute for Correspondent'),
           (select po.id from persistentobject po where po.name = 'correspondent'
                                                    and po.d = (select distinct po1.d from persistentobject po1 join objecttype ot1 on po1.id = ot1.id)),
           false, false, 1, true
       );

--fax
insert into persistentobject (name, description, created, creator, modified, modifier, objType, d)
values (
           'fax',
           'attribute for Correspondent',
           current_timestamp,
           (select u.id from csuser u join persistentobject po on po.id = u.id where po.name='admin user'),
           current_timestamp,
           (select u.id from csuser u join persistentobject po on po.id = u.id where po.name='admin user'),
           (select ot.id from objecttype ot join persistentobject po on po.id = ot.id where po.name='attribute'),
           (select distinct po.d from persistentobject po join attribute at on po.id = at.id)
    );

insert into attribute (id, objectType, attributeSize, attributeType, extended)
values (
           (select po.id from persistentobject po where po.name = 'fax'
                                                    and po.description = 'attribute for Correspondent'),
           (select po.id from persistentobject po where po.name = 'correspondent'
                                                    and po.d = (select distinct po1.d from persistentobject po1 join objecttype ot1 on po1.id = ot1.id)),
           100, 0, false
       );

insert into attributeparams (attribute, objtype, showinsearch, own, extendedattrparams, searchable)
values (
           (select po.id from persistentobject po where po.name = 'fax'
                                                    and po.description = 'attribute for Correspondent'),
           (select po.id from persistentobject po where po.name = 'correspondent'
                                                    and po.d = (select distinct po1.d from persistentobject po1 join objecttype ot1 on po1.id = ot1.id)),
           false, false, 1, true
       );

--url
insert into persistentobject (name, description, created, creator, modified, modifier, objType, d)
values (
           'url',
           'attribute for Correspondent',
           current_timestamp,
           (select u.id from csuser u join persistentobject po on po.id = u.id where po.name='admin user'),
           current_timestamp,
           (select u.id from csuser u join persistentobject po on po.id = u.id where po.name='admin user'),
           (select ot.id from objecttype ot join persistentobject po on po.id = ot.id where po.name='attribute'),
           (select distinct po.d from persistentobject po join attribute at on po.id = at.id)
    );

insert into attribute (id, objectType, attributeSize, attributeType, extended)
values (
           (select po.id from persistentobject po where po.name = 'url'
                                                    and po.description = 'attribute for Correspondent'),
           (select po.id from persistentobject po where po.name = 'correspondent'
                                                    and po.d = (select distinct po1.d from persistentobject po1 join objecttype ot1 on po1.id = ot1.id)),
           512, 0, false
       );

insert into attributeparams (attribute, objtype, showinsearch, own, extendedattrparams, searchable)
values (
           (select po.id from persistentobject po where po.name = 'url'
                                                    and po.description = 'attribute for Correspondent'),
           (select po.id from persistentobject po where po.name = 'correspondent'
                                                    and po.d = (select distinct po1.d from persistentobject po1 join objecttype ot1 on po1.id = ot1.id)),
           false, false, 1, true
       );

--chef
insert into persistentobject (name, description, created, creator, modified, modifier, objType, d)
values (
           'chef',
           'attribute for Correspondent',
           current_timestamp,
           (select u.id from csuser u join persistentobject po on po.id = u.id where po.name='admin user'),
           current_timestamp,
           (select u.id from csuser u join persistentobject po on po.id = u.id where po.name='admin user'),
           (select ot.id from objecttype ot join persistentobject po on po.id = ot.id where po.name='attribute'),
           (select distinct po.d from persistentobject po join attribute at on po.id = at.id)
    );

insert into attribute (id, objectType, attributeSize, attributeType, extended)
values (
           (select po.id from persistentobject po where po.name = 'chef'
                                                    and po.description = 'attribute for Correspondent'),
           (select po.id from persistentobject po where po.name = 'correspondent'
                                                    and po.d = (select distinct po1.d from persistentobject po1 join objecttype ot1 on po1.id = ot1.id)),
           512, 0, false
       );

insert into attributeparams (attribute, objtype, showinsearch, own, extendedattrparams, searchable)
values (
           (select po.id from persistentobject po where po.name = 'chef'
                                                    and po.description = 'attribute for Correspondent'),
           (select po.id from persistentobject po where po.name = 'correspondent'
                                                    and po.d = (select distinct po1.d from persistentobject po1 join objecttype ot1 on po1.id = ot1.id)),
           false, false, 1, true
       );

--responsibleuser
insert into persistentobject (name, description, created, creator, modified, modifier, objType, d)
values (
           'responsibleuser',
           'attribute for Correspondent',
           current_timestamp,
           (select u.id from csuser u join persistentobject po on po.id = u.id where po.name='admin user'),
           current_timestamp,
           (select u.id from csuser u join persistentobject po on po.id = u.id where po.name='admin user'),
           (select ot.id from objecttype ot join persistentobject po on po.id = ot.id where po.name='attribute'),
           (select distinct po.d from persistentobject po join attribute at on po.id = at.id)
    );

insert into attribute (id, objectType, attributeSize, attributeType, extended)
values (
           (select po.id from persistentobject po where po.name = 'responsibleuser'
                                                    and po.description = 'attribute for Correspondent'),
           (select po.id from persistentobject po where po.name = 'correspondent'
                                                    and po.d = (select distinct po1.d from persistentobject po1 join objecttype ot1 on po1.id = ot1.id)),
           512, 0, false
       );

insert into attributeparams (attribute, objtype, showinsearch, own, extendedattrparams, searchable)
values (
           (select po.id from persistentobject po where po.name = 'responsibleuser'
                                                    and po.description = 'attribute for Correspondent'),
           (select po.id from persistentobject po where po.name = 'correspondent'
                                                    and po.d = (select distinct po1.d from persistentobject po1 join objecttype ot1 on po1.id = ot1.id)),
           false, false, 1, true
       );

--ecmsystem
insert into persistentobject (name, description, created, creator, modified, modifier, objType, d)
values (
           'ecmsystem',
           'attribute for Correspondent',
           current_timestamp,
           (select u.id from csuser u join persistentobject po on po.id = u.id where po.name='admin user'),
           current_timestamp,
           (select u.id from csuser u join persistentobject po on po.id = u.id where po.name='admin user'),
           (select ot.id from objecttype ot join persistentobject po on po.id = ot.id where po.name='attribute'),
           (select distinct po.d from persistentobject po join attribute at on po.id = at.id)
    );

insert into attribute (id, objectType, attributeSize, attributeType, extended)
values (
           (select po.id from persistentobject po where po.name = 'ecmsystem'
                                                    and po.description = 'attribute for Correspondent'),
           (select po.id from persistentobject po where po.name = 'correspondent'
                                                    and po.d = (select distinct po1.d from persistentobject po1 join objecttype ot1 on po1.id = ot1.id)),
           5, 1, false
       );

insert into attributeparams (attribute, objtype, showinsearch, own, extendedattrparams, searchable)
values (
           (select po.id from persistentobject po where po.name = 'ecmsystem'
                                                    and po.description = 'attribute for Correspondent'),
           (select po.id from persistentobject po where po.name = 'correspondent'
                                                    and po.d = (select distinct po1.d from persistentobject po1 join objecttype ot1 on po1.id = ot1.id)),
           false, false, 1, true
       );

--active
insert into persistentobject (name, description, created, creator, modified, modifier, objType, d)
values (
           'active',
           'attribute for Correspondent',
           current_timestamp,
           (select u.id from csuser u join persistentobject po on po.id = u.id where po.name='admin user'),
           current_timestamp,
           (select u.id from csuser u join persistentobject po on po.id = u.id where po.name='admin user'),
           (select ot.id from objecttype ot join persistentobject po on po.id = ot.id where po.name='attribute'),
           (select distinct po.d from persistentobject po join attribute at on po.id = at.id)
    );

insert into attribute (id, objectType, attributeSize, attributeType, extended)
values (
           (select po.id from persistentobject po where po.name = 'active'
                                                    and po.description = 'attribute for Correspondent'),
           (select po.id from persistentobject po where po.name = 'correspondent'
                                                    and po.d = (select distinct po1.d from persistentobject po1 join objecttype ot1 on po1.id = ot1.id)),
           19, 1, false
       );

insert into attributeparams (attribute, objtype, showinsearch, own, extendedattrparams, searchable)
values (
           (select po.id from persistentobject po where po.name = 'active'
                                                    and po.description = 'attribute for Correspondent'),
           (select po.id from persistentobject po where po.name = 'correspondent'
                                                    and po.d = (select distinct po1.d from persistentobject po1 join objecttype ot1 on po1.id = ot1.id)),
           false, false, 1, true
       );


--move correspondents to persistentobject

INSERT INTO persistentobject (name, description, created, creator, modified, modifier, objType, d)
select name, 'Корреспондент (мигрирован из таблицы correspondents)',
       now(),
       (select us.id from csuser us join persistentobject upo on upo.id = us.id where upo.name = 'admin user'),
       now(),
       (select us.id from csuser us join persistentobject upo on upo.id = us.id where upo.name = 'admin user'),
       -30, -30
from correspondent;

DROP SEQUENCE correspondent_id_seq CASCADE;

--update links to correspondents in objects (НЕ ВЫПОЛНЯТЬ У КЛИЕНТОВ!!)
UPDATE custom_doc c
SET contragent = subquery.id
    FROM (SELECT po.id, corr.id as corrId FROM persistentobject po, correspondent corr
      WHERE po.name = corr.name
        AND po.description = 'Корреспондент (мигрирован из таблицы correspondents)') AS subquery
WHERE c.contragent = subquery.corrId;

UPDATE income_doc c
SET correspondent = subquery.id
    FROM (SELECT po.id, corr.id as corrId FROM persistentobject po, correspondent corr
      WHERE po.name = corr.name
        AND po.description = 'Корреспондент (мигрирован из таблицы correspondents)') AS subquery
WHERE c.correspondent = subquery.corrId;

--the same for repeating attrs (НЕ ВЫПОЛНЯТЬ У КЛИЕНТОВ!!):

UPDATE r403_correspondents r
SET correspondents = subquery.id
    FROM (SELECT po.id, corr.id as corrId FROM persistentobject po, correspondent corr
      WHERE po.name = corr.name
        AND po.description = 'Корреспондент (мигрирован из таблицы correspondents)') AS subquery
WHERE r.correspondents = subquery.corrId;

--дальнешее - ВЫПОЛНЯТЬ у клиентов!!!!!!!!!!

UPDATE correspondent c
SET id = subquery.id
    FROM (SELECT po.id, po.name FROM persistentobject po
      WHERE po.description = 'Корреспондент (мигрирован из таблицы correspondents)') AS subquery
WHERE c.name = subquery.name;


ALTER TABLE correspondent ADD CONSTRAINT FK_CORR_PERSISTENTOBJECT1 FOREIGN KEY (ID) REFERENCES PERSISTENTOBJECT (ID);


--------------------------------------------------------------------------------------
--обновление типов атрибутов

UPDATE attribute attr
SET attributetype = 5, customobjecttype = (select po.id from persistentobject po
                            where po.name = 'correspondent'
                              and po.d = (select distinct po1.d from persistentobject po1 join objecttype ot1 on po1.id = ot1.id))
WHERE attr.id in(select attribute from attributeparams where exttablename = 'correspondent');

update attributeparams set exttablename = null, exttabletitle = null, exttablelabel = null, exttablevalue = null
where exttablename = 'correspondent';

alter table correspondent drop column name;

-------------------------------------------------------------------------------------------
-- -- бэкап скрпитов для получения связи тип объекта-имя атрибута для атрибутов с внешними таблицами корреспондентов

-- select distinct otpo.name as typename, attrpo.name as attrname
-- from persistentobject otpo, objecttype ot, attribute attr, persistentobject attrpo, attributeparams prms
-- where attr.id = attrpo.id and ot.id = otpo.id and ot.id = attr.objecttype and prms.attribute = attr.id
--   and prms.exttablename='correspondent' and attr.repeating=false;
-- select distinct otpo.name as typename, attrpo.name as attrname
-- from persistentobject otpo, objecttype ot, attribute attr, persistentobject attrpo, attributeparams prms
-- where attr.id = attrpo.id and ot.id = otpo.id and ot.id = attr.objecttype and prms.attribute = attr.id
--   and prms.exttablename='correspondent' and attr.repeating=true;


---------------------

-- select po.id from persistentobject po join objecttype ot on po.id = ot.id where name = 'outcome_doc';
--
-- select r.id, r.correspondents, c.name from r403_correspondents r, correspondent c
-- where c.id = r.correspondents order by r.id;





-----
-- -- бэкап скриптов для создания временной нумерации и выборки документов с атрибутами
--select d.id, c.id as corrid, c.name as corrname from income_doc d, correspondent c where d.correspondent = c.id order by id;

-- CREATE SEQUENCE test_seq;
-- update correspondent set id=nextval('test_seq') where id is not null;
-- -- SELECT nextval('test_seq');
-- drop SEQUENCE test_seq cascade;





------------------------------------------------------------------
------------------------------------------------------------------


--added wf_editor_coordinates
alter table cs.workflowtemplate
    add wf_editor_coordinates varchar(5000);
--added job Transfer WF editor coordinates
INSERT INTO cs.jobschedule (id, name, description, jobclass, runmode, runinterval, startdate,
                            enddate, runlast, runnext, active)
VALUES (DEFAULT, 'Transfer WF editor coordinates', 'Перенос координат из файлов в базу данных',
        'ru.ntik.cs.custom.ntik.jobs.WfCoordinatesTransferJob', 1, 0,
        '2021-12-01 11:57:26.105000 +00:00', '2021-12-01 11:57:44.206000 +00:00', null, null,
        false);