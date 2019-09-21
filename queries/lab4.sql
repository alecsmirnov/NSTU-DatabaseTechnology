-- 1) Выдать число деталей, поставлявшихся для изделий, у которых
--    есть поставки с весом от 5000 до 6000.

SELECT COUNT(DISTINCT spj.n_det)
FROM spj
WHERE spj.n_izd IN (SELECT spj.n_izd
                    FROM spj
                    JOIN p ON spj.n_det = p.n_det
                    WHERE spj.kol * p.ves BETWEEN 5000 AND 6000);

-- 2) Поменять местами вес деталей из Рима и из Парижа, т. е. деталям из Рима 
--    установить вес детали из Парижа, а деталям из Парижа установить вес детали из Рима. 
--    Если деталей несколько, брать наименьший вес.

UPDATE p SET ves = (CASE WHEN p.town = 'Париж'
                         THEN (SELECT MIN(p.ves)
                               FROM p
                               WHERE p.town = 'Рим')
                         ELSE (SELECT MIN(p.ves)
                               FROM p
                               WHERE p.town = 'Париж')
                    END)
WHERE p.town IN ('Рим', 'Париж');

-- 3) Найти детали, имеющие поставки, объем которых не превышает
--    половину максимального объема поставки этой детали поставщиком из Парижа.

SELECT DISTINCT spj.n_det
FROM spj
JOIN (SELECT spj.n_det, MAX(spj.kol)
      FROM spj
      JOIN s ON spj.n_post = s.n_post
      WHERE s.town = 'Париж'
      GROUP BY spj.n_det
     ) max_post ON spj.n_det = max_post.n_det
WHERE spj.kol <= max_post.max / 2
ORDER BY spj.n_det

-- 4) Выбрать поставщиков, не поставивших ни одной из деталей, поставляемых 
--    для изделий из Парижа.

SELECT s.n_post
FROM s
EXCEPT
SELECT DISTINCT spj.n_post
FROM spj
WHERE spj.n_det IN (SELECT DISTINCT spj.n_det
                    FROM spj
                    WHERE spj.n_izd IN (SELECT j.n_izd 
                                        FROM j
                                        WHERE j.town = 'Париж'));

-- 5) Выдать полную информацию о деталях, которые поставлялись ТОЛЬКО поставщиками, проживающими в Афинах.

SELECT p.*
FROM p
WHERE p.n_det IN (SELECT spj.n_det
                  FROM spj
                  WHERE spj.n_post IN (SELECT s.n_post
                                       FROM s
                                       WHERE s.town = 'Афины')
                  EXCEPT 
                  SELECT spj.n_det
                  FROM spj
                  WHERE NOT spj.n_post IN (SELECT s.n_post
                                           FROM s
                                           WHERE s.town = 'Афины'))