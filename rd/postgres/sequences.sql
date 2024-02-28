
SELECT 'ALTER TABLE "'|| schemaname || '".' || tablename ||' OWNER TO cs;' FROM pg_tables WHERE NOT schemaname IN ('pg_catalog', 'information_schema') ORDER BY schemaname, tablename;


SELECT 'ALTER TABLE "'|| schemaname || '".' || tablename ||' OWNER TO cs;' FROM pg_tables WHERE NOT schemaname IN ('pg_catalog', 'information_schema') ORDER BY schemaname, tablename;
- прогнать вывод этого запроса
						

SELECT 'ALTER sequence cs.' || relname ||' OWNER TO cs;'
 FROM pg_class
 WHERE relkind = 'S'
   AND relnamespace IN (
                        SELECT oid
                          FROM pg_namespace
                         WHERE nspname NOT LIKE 'pg_%'
                           AND nspname != 'information_schema'
                        );
						
						
						-- show sequences owner
SELECT c.relname,u.usename
  FROM pg_class c, pg_user u
 WHERE c.relowner = u.usesysid and c.relkind = 'S'
   AND relnamespace IN (
                        SELECT oid
                          FROM pg_namespace
                         WHERE nspname NOT LIKE 'pg_%'
                           AND nspname != 'information_schema'
                        );