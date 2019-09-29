-- 1. Вставить поставщика с заданным именем, а также городом и
--    рейтингом, как у поставщика с наименьшим числом поставок.

INSERT INTO s
    SELECT CONCAT('S', (SELECT COUNT(s.*) + 1
                        FROM s)), 
           'Барабашка', s.reiting, s.town
    FROM s
    WHERE s.n_post IN (SELECT MIN(spj.n_post)
                       FROM spj);

-- 2. Удалить самую легкую из деталей, поставлявшихся для изделия
--    из указанного города.

DELETE FROM p
WHERE p.n_det IN (SELECT DISTINCT spj.n_det
                  FROM spj
                  JOIN p ON spj.n_det = p.n_det
                  WHERE spj.n_izd IN (SELECT j.n_izd
                                      FROM j
                                      WHERE j.town = 'Афины')
                  AND p.ves = (SELECT MIN(p.ves)
                               FROM spj
                               JOIN p ON spj.n_det = p.n_det
                               WHERE spj.n_izd IN (SELECT j.n_izd
                                                   FROM j
                                                   WHERE j.town = 'Афины')));

-- 3. Для каждого поставщика вывести его номер и число сделанных
--    им поставок c объемом больше указанного значения (или 0, если таких
--    поставок не было). Поставщики в списке должны быть ВСЕ. Список
--    должен быть упорядочен по номеру поставщика.

SELECT s.n_post, COALESCE(posts.post_kol, 0)
FROM s
LEFT JOIN (SELECT spj.n_post, SUM(spj.kol) AS post_kol
           FROM spj
           GROUP BY spj.n_post
           HAVING SUM(spj.kol) > 700
          ) AS posts 
ON s.n_post = posts.n_post
ORDER BY s.n_post;