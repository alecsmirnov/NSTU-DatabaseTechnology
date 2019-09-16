-- Предоставить доступ к схеме для пользователя pmi-b6711

GRANT USAGE ON SCHEMA pmib6706 TO "pmi-b6711";

-- Предоставление прав на чтение

GRANT SELECT ON s, spj TO "pmi-b6711";

-- Предоставление прав на изменение

GRANT UPDATE ON s, spj TO "pmi-b6711";

-- Предоставление прав на удаление

GRANT DELETE ON s, spj TO "pmi-b6711";


-- Отменить доступ к схеме для пользователя pmi-b6711

REVOKE USAGE ON SCHEMA pmib6706 FROM "pmi-b6711";

-- Отменить всех прав

REVOKE ALL ON s, spj FROM "pmi-b6711";


-- 1) Выдать информацию о каждой детали в формате:
--    Деталь <номер детали> <б1> – <б2> / <цвет>
--    где:
--        • <номер детали> – только цифра,
--        • <б1> – первая буква названия,
--        • <б2> – последняя буква названия,
--        • <цвет> – все буквы большие.
--    Например, строка для детали P1 должна выглядеть так:
--                Деталь 1 Г-а / КРАСНЫЙ

SELECT 'Деталь ' || RIGHT(p.n_det, 1) || ' ' || 
       LEFT(p.name, 1) || '-' || RIGHT(p.name, 1) || ' / ' ||
       UPPER(p.cvet) AS det
FROM p;

-- 2) Получить номера деталей, которые поставлялись для КАЖДОГО изделия, 
--    для которо-го поставлялись красные детали.

SELECT spj.n_det
FROM spj
WHERE spj.n_izd IN (SELECT DISTINCT spj.n_izd
                    FROM spj
                    WHERE spj.n_det IN (SELECT p.n_det
                                        FROM p
                                        WHERE p.cvet = 'Красный'))
GROUP BY spj.n_det
HAVING COUNT(DISTINCT spj.n_izd) = (SELECT COUNT(DISTINCT spj.n_izd)
                                    FROM spj
                                    WHERE spj.n_det IN (SELECT p.n_det
                                                        FROM p
                                                        WHERE p.cvet = 'Красный'));