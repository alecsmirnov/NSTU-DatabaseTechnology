-- Схема репликации

CREATE TABLE product_cdb (n bigserial PRIMARY KEY,
                          name varchar(20),
                          operation varchar(40),
                          operation_date timestamp);

CREATE TABLE product_pdb1 (n bigserial PRIMARY KEY,
                           name varchar(20),
                           operation varchar(40),
                           operation_date timestamp);

CREATE TABLE product_pdb2 (n bigserial PRIMARY KEY,
                           name varchar(20),
                           operation varchar(40),
                           operation_date timestamp);

CREATE TABLE product_pdb3 (n bigserial PRIMARY KEY,
                           name varchar(20),
                           operation varchar(40),
                           operation_date timestamp);

-- Журнал изменений

CREATE TABLE log (n bigserial PRIMARY KEY,
                  db_name varchar(20),
                  db_priority integer,
                  n_data integer,
                  operation varchar(40),
                  operation_date timestamp,
                  old_data varchar(20),
                  new_data varchar(20));

-- Инициализация данных

INSERT INTO product_cdb(name, operation, operation_date) 
VALUES ('Жесткий диск', 'Начальная вставка', DATE_TRUNC('second', NOW())),
       ('Перфоратор', 'Начальная вставка', DATE_TRUNC('second', NOW())),
       ('Считыватель', 'Начальная вставка', DATE_TRUNC('second', NOW())),
       ('Принтер', 'Начальная вставка', DATE_TRUNC('second', NOW())),
       ('Флоппи-диск', 'Начальная вставка', DATE_TRUNC('second', NOW())),
       ('Терминал', 'Начальная вставка', DATE_TRUNC('second', NOW())),
       ('Лента', 'Начальная вставка', DATE_TRUNC('second', NOW())),
       ('Кулер', 'Начальная вставка', DATE_TRUNC('second', NOW())),
       ('Процессор', 'Начальная вставка', DATE_TRUNC('second', NOW())),
       ('Блок питания', 'Начальная вставка', DATE_TRUNC('second', NOW()));

-- Запись инициализации в журнал

INSERT INTO log(db_name, db_priority, n_data, operation, operation_date, old_data, new_data)
SELECT 'product_cdb', 0, n, operation, operation_date, '', name
FROM product_cdb
WHERE n = LASTVAL();