-- 1) Получить информацию о рекомендованной цене на указанное изделие на заданную дату.

SELECT v.*
FROM v
WHERE v.n_izd ='J2' AND v.date_begin <= '2011-06-01'
LIMIT 1;


-- 2) Для изделий, в состав которых входит заданная деталь, сдвинуть
--    на месяц назад дату начала действия последней рекомендованной цены.

UPDATE v 
SET date_begin = date_begin - interval '1 month'
WHERE v.n_v IN (SELECT max_v.n_v
                FROM q
                JOIN (SELECT v.n_v, v.n_izd, max_date.date
                      FROM v
                      CROSS JOIN (SELECT v.n_izd, MAX(v.date_begin) AS date
                                  FROM v
                                  GROUP BY v.n_izd
                                 ) max_date
                      WHERE v.n_izd = max_date.n_izd AND v.date_begin = max_date.date
                     ) AS max_v
                ON q.n_izd = max_v.n_izd
                WHERE q.n_det = 'P2');