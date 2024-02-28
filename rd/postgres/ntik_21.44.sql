alter table objectclassifier add defaultlifecycle BIGINT;
ALTER TABLE objectclassifier ADD CONSTRAINT fk_classifier_lifecycle FOREIGN KEY (defaultlifecycle) REFERENCES lifecycle (ID);
--добавить пакеты MainDocPackage (Документы по поручению, baseobject, множественный) ко всем задачам поручений и связать его с задачей Init и всеми НЕавто тасками
--добавить внешнюю таблицу orderobject_baseobject
ALTER TABLE businessprocessaudit ALTER COLUMN description TYPE varchar(1700);
--добавить внешнюю таблицу workflowpackagetemplateconf
--создать джобу: OrdersToPackagesMigrator - Перенос поручений в пакеты - ru.ntik.cs.custom.ntik.jobs.OrdersToPackagesMigrator - неактивная.
--выполнить джобу, ребутнуть бэк.