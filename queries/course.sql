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
                  operation varchar(40),
                  operation_date timestamp,
                  n_data integer,
                  old_data varchar(20),
                  new_data varchar(20));

CREATE TABLE general_log (n serial PRIMARY KEY,
                          db_name varchar(20),
                          operation varchar(40),
                          operation_date timestamp,
                          n_data integer,
                          old_data varchar(20),
                          new_data varchar(20));

-- Репликация 

DELETE FROM log
WHERE n NOT IN (SELECT MAX(n) AS n
                FROM log
                WHERE operation_date = (SELECT MAX(operation_date)
                                        FROM log AS in_log
                                        WHERE in_log.n_data = log.n_data)
                GROUP BY n_data)

INSERT INTO product_cdb(n, name, operation, operation_date)
SELECT n_data, new_data, operation, operation_date
FROM log
WHERE new_data != '';