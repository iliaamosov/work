--Добавление дополнительного состояния жц для объектов "Приказ о предоставлении отпуска":
--Добавить в жизненный цикл "Приказ о предоставлении отпуска" новое состояние:
        -- Имя: ApprovedByGenDir
        -- Описание: Утверждено генеральным директором
--Разместить новое состояние жизненного цикла между состояниями Draft и Approve (порядковый номер 1).
--В бизнес-процесс "Отпуск" после задачи "approval" ("Подписание приказа на отпуск электронной подписью")
--добавить автометод WritPromote (Продвижение приказа по состоянию ЖЦ)
--Добавить в новую задачу действие: ru.ntik.cs.custom.ntik.workflow.common.BasedocPromote
--Далее добавить в новую задачу параметр задачи: MainDocPackage -> order

update orderobject oo set maindocument = null
where oo.maindocument is not null
  and  not exists (select bo.id from baseobject bo where bo.id = oo.maindocument);

ALTER TABLE orderobject ADD CONSTRAINT "fk_orderobject_baseobject"
    FOREIGN KEY (maindocument) REFERENCES baseobject(id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION;

delete from favoritesobjectlink a
    USING favoritesobjectlink b
WHERE a.id > b.id
  AND a.csuser = b.csuser
  AND a.objid = b.objid
  AND a.classname = b.classname;

ALTER TABLE favoritesobjectlink
    ADD UNIQUE (csuser, objid, classname);