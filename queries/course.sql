-- Схема репликации

CREATE TABLE product_cdb (n serial PRIMARY KEY,
                          name varchar(20),
                          operation varchar(40),
                          operation_date timestamp);

CREATE TABLE product_pdb1 (n serial PRIMARY KEY,
                           name varchar(20),
                           operation varchar(40),
                           operation_date timestamp);

CREATE TABLE product_pdb2 (n serial PRIMARY KEY,
                           name varchar(20),
                           operation varchar(40),
                           operation_date timestamp);

CREATE TABLE product_pdb3 (n serial PRIMARY KEY,
                           name varchar(20),
                           operation varchar(40),
                           operation_date timestamp);

-- Журнал изменений

CREATE TABLE log (n serial PRIMARY KEY,
                  db_name varchar(20),
                  db_priority integer,
                  operation varchar(40),
                  operation_date timestamp,
                  n_data integer,
                  old_data varchar(20),
                  new_data varchar(20));

-- Репликация 

SELECT log.n_data, log.operation, log.operation_date, log.new_data
FROM log
WHERE log.n IN (SELECT (SELECT in_log.n
                        FROM log AS in_log
                        WHERE in_log.n_data = out_log.n_data
                        ORDER BY in_log.operation_date DESC, in_log.db_priority ASC
                        LIMIT 1
                       ) AS late
                FROM log AS out_log
                GROUP BY out_log.n_data)
AND log.new_data != '';


SELECT t1.new_n_izd, t1.new_name,t1.new_o_type,t1.new_date
FROM
(SELECT old_n_izd, MAX(date_operation)
FROM log
WHERE new_n_izd IS NOT NULL
GROUP BY old_n_izd
) as t
JOIN log as t1 on t1.date_operation = max and t1.old_n_izd = t.old_n_izd
ORDER BY new_n_izd asc