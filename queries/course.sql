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