-- 1) Получить информацию о рекомендованной цене на указанное изделие на заданную дату.

SELECT v.*
FROM v
WHERE v.n_izd ='J2' AND v.date_begin <= '2011-06-01'
ORDER BY v.date_begin DESC
LIMIT 1;


-- 2) Для изделий, в состав которых входит заданная деталь, сдвинуть
--    на месяц назад дату начала действия последней рекомендованной цены.

UPDATE v 
SET date_begin = date_begin - interval '1 month'
WHERE v.n_v IN (SELECT (SELECT v.n_v
                        FROM v
                        WHERE v.n_izd = out_v.n_izd
                        ORDER BY v.date_begin DESC
                        LIMIT 1)
                FROM (SELECT DISTINCT q.n_izd
                      FROM q
                      WHERE q.n_det = 'P5'
                     ) out_v
               );