-- Схема репликации

CREATE TABLE product_cdb (n bigserial PRIMARY KEY,
                          name varchar(20),
                          town varchar(20),
                          operation varchar(40),
                          operation_date timestamp);

CREATE TABLE product_pdb1 (n bigserial PRIMARY KEY,
                           name varchar(20),
                           town varchar(20),
                           operation varchar(40),
                           operation_date timestamp);

CREATE TABLE product_pdb2 (n bigserial PRIMARY KEY,
                           name varchar(20),
                           town varchar(20),
                           operation varchar(40),
                           operation_date timestamp);

CREATE TABLE product_pdb3 (n bigserial PRIMARY KEY,
                           name varchar(20),
                           town varchar(20),
                           operation varchar(40),
                           operation_date timestamp);

-- Журнал изменений

CREATE TABLE log (n bigserial PRIMARY KEY,
                  db_name varchar(20),
                  db_priority integer,
                  operation varchar(40),
                  operation_date timestamp,
                  old_data varchar(300),
                  new_data varchar(300));



-- Инициализация данных

INSERT INTO product_cdb(name, town, operation, operation_date) 
VALUES ('Жесткий диск', 'Париж', 'Начальная вставка', DATE_TRUNC('second', NOW())),
       ('Перфоратор', 'Рим', 'Начальная вставка', DATE_TRUNC('second', NOW())),
       ('Считыватель', 'Афины', 'Начальная вставка', DATE_TRUNC('second', NOW())),
       ('Принтер', 'Афины', 'Начальная вставка', DATE_TRUNC('second', NOW())),
       ('Флоппи-диск', 'Лондон', 'Начальная вставка', DATE_TRUNC('second', NOW())),
       ('Терминал', 'Осло', 'Начальная вставка', DATE_TRUNC('second', NOW())),
       ('Лента', 'Лондон', 'Начальная вставка', DATE_TRUNC('second', NOW())),
       ('Кулер', 'Чикаго', 'Начальная вставка', DATE_TRUNC('second', NOW())),
       ('Процессор', 'Пекин', 'Начальная вставка', DATE_TRUNC('second', NOW())),
       ('Блок питания', 'Томск', 'Начальная вставка', DATE_TRUNC('second', NOW()));

INSERT INTO product_pdb1
SELECT *
FROM product_cdb;

INSERT INTO product_pdb2
SELECT *
FROM product_cdb;

INSERT INTO product_pdb3
SELECT *
FROM product_cdb;


INSERT INTO log(db_name, db_priority, operation, operation_date, old_data, new_data)
SELECT 'product_pdb1', 1, operation, operation_date, 'NULL', n || ', ' || name || ', ' || town || ', ' || operation || ', ' ||  operation_date 
FROM product_pdb1;