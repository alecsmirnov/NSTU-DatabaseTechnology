-- a 1

SELECT j.*
FROM spj
JOIN j ON spj.n_izd = j.n_izd
JOIN s ON spj.n_post = s.n_post
WHERE s.reiting = 20
AND spj.n_det IN (SELECT in_spj.n_det 
                  FROM spj AS in_spj
                  WHERE in_spj.n_izd = 'J2');

-- a 2

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

-- a 3

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

-- a 4

SELECT j.*, COALESCE(counts.town_count, 0) AS town_count
FROM j
LEFT JOIN (SELECT ps.n_izd, COUNT(ps.town) as town_count
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

-- b 1

CREATE TABLE town AS (SELECT p.town FROM p
                      INTERSECT
                      SELECT j.town FROM j
                      EXCEPT
                      SELECT s.town FROM s);

-- b 2

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