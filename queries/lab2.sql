-- ВЫБОРКА ИНФОРМАЦИИ

-- 1) Выбрать изделия, для которых поставщик с рейтингом 20 поставлял детали, 
--    постав-лявшиеся для изделия J2.

SELECT j.*
FROM spj
JOIN j ON spj.n_izd = j.n_izd
JOIN s ON spj.n_post = s.n_post
WHERE s.reiting = 20
AND spj.n_det IN (SELECT in_spj.n_det 
                  FROM spj AS in_spj
                  WHERE in_spj.n_izd = 'J2');

-- 2) Найти изделия, для которых детали с весом от 17 до 19 поставлялись поставщиком с рейтингом больше 20. 
--    Вывести полную информацию об изделиях: номер, название, город.

SELECT *
FROM j
WHERE j.n_izd IN (SELECT DISTINCT spj.n_izd
                  FROM spj
                  WHERE spj.n_post IN (SELECT s.n_post
                                       FROM s
                                       WHERE s.reiting > 20)
                  AND spj.n_det IN (SELECT p.n_det
                                    FROM p
                                    WHERE p.ves BETWEEN 17 AND 19));

-- 3) Получить список поставщиков, выполнивших поставки ТОЛЬКО для изделий с красными деталями.

SELECT spj.n_post
FROM spj
WHERE spj.n_det IN (SELECT p.n_det 
                    FROM p
                    WHERE p.cvet = 'Красный')
EXCEPT 
SELECT spj.n_post 
FROM spj 
WHERE NOT spj.n_izd IN (SELECT DISTINCT out_spj.n_izd
                        FROM spj AS out_spj
                        WHERE out_spj.n_det IN (SELECT p.n_det 
                                                FROM p
                                                WHERE p.cvet = 'Красный'));

-- 4) Вывести полный список изделий и для каждого изделия определить, 
--    из скольких разных городов для него поставлялись детали с весом 12. 
--    Изделия в списке должны быть ВСЕ. Список должен быть упорядочен по номеру изделия.

SELECT j.*, COALESCE(counts.town_count, 0) AS town_count
FROM j
LEFT JOIN (SELECT ps.n_izd, COUNT(ps.town) AS town_count
           FROM (SELECT spj.n_izd, p.town
                 FROM spj 
                 JOIN p ON spj.n_det = p.n_det
                 WHERE p.n_det IN (SELECT in_p.n_det 
                                   FROM p AS in_p
                                   WHERE in_p.ves = 12)
                 GROUP BY spj.n_izd, p.town
                ) ps
           GROUP BY ps.n_izd
          ) counts
ON j.n_izd = counts.n_izd
ORDER BY j.n_izd;


-- МОДИФИКАЦИЯ ИНФОРМАЦИИ

-- 1) Построить таблицу с упорядоченным списком городов таких, 
--    что в городе произво-дится какая-либо деталь и собирается какое-либо изделие, 
--    но не размещается ни один поставщик.

CREATE TABLE town AS (SELECT p.town FROM p
                      INTERSECT
                      SELECT j.town FROM j
                      EXCEPT
                      SELECT s.town FROM s);

-- 2) Каждое изделие из Афин перевести в город, из которого для изделия сделано наибольшее число поставок. 
--    Если таких городов больше одного, перевести в послед-ний по алфавиту из этих городов.

UPDATE j 
SET town = (SELECT max_town.town
            FROM (SELECT p.town
                  FROM spj
                  JOIN p
                  ON spj.n_det = p.n_det
                  WHERE spj.n_izd = j.n_izd
                  GROUP BY p.town
                  ORDER BY COUNT(*) DESC, p.town DESC
                  LIMIT 1
                 ) max_town
           )
WHERE j.town = 'Афины';