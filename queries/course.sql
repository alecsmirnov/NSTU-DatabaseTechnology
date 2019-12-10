-- Схема репликации

CREATE TABLE product_cdb (n integer PRIMARY KEY,
                          name varchar(20),
                          town varchar(20),
                          operation varchar(40),
                          operation_date timestamp);

CREATE TABLE product_pdb1 (n integer PRIMARY KEY,
                           name varchar(20),
                           town varchar(20),
                           operation varchar(40),
                           operation_date timestamp);

CREATE TABLE product_pdb2 (n integer PRIMARY KEY,
                           name varchar(20),
                           town varchar(20),
                           operation varchar(40),
                           operation_date timestamp);

CREATE TABLE product_pdb3 (n integer PRIMARY KEY,
                           name varchar(20),
                           town varchar(20),
                           operation varchar(40),
                           operation_date timestamp);

-- Журнал изменений

CREATE TABLE log (n integer PRIMARY KEY,
                  db_name varchar(20),
                  db_priority integer,
                  operation varchar(40),
                  operation_date timestamp,
                  old_data varchar(100),
                  new_data varchar(100));



-- Инициализация данных

INSERT INTO product_cdb VALUES
    (1, 'Жесткий диск', 'Париж', 'Начальная вставка', DATE_TRUNC('second', NOW())),
    (2, 'Перфоратор', 'Рим', 'Начальная вставка', DATE_TRUNC('second', NOW())),
    (3, 'Считыватель', 'Афины', 'Начальная вставка', DATE_TRUNC('second', NOW())),
    (4, 'Принтер', 'Афины', 'Начальная вставка', DATE_TRUNC('second', NOW())),
    (5, 'Флоппи-диск', 'Лондон', 'Начальная вставка', DATE_TRUNC('second', NOW())),
    (6, 'Терминал', 'Осло', 'Начальная вставка', DATE_TRUNC('second', NOW())),
    (7, 'Лента', 'Лондон', 'Начальная вставка', DATE_TRUNC('second', NOW())),
    (8, 'Кулер', 'Чикаго', 'Начальная вставка', DATE_TRUNC('second', NOW())),
    (9, 'Процессор', 'Пекин', 'Начальная вставка', DATE_TRUNC('second', NOW())),
    (10, 'Блок питания', 'Томск', 'Начальная вставка', DATE_TRUNC('second', NOW()));

INSERT INTO product_pdb1
SELECT *
FROM product_cdb

INSERT INTO product_pdb2
SELECT *
FROM product_cdb

INSERT INTO product_pdb3
SELECT *
FROM product_cdb