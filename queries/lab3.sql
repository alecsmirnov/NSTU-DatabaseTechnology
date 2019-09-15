-- tasks

INSERT INTO s 
VALUES ('S6', 'Смирнов', -99, 'Новосибирск');

INSERT INTO spj 
VALUES ('S6', 'P1', 'J6', 1),
       ('S6', 'P3', 'J5', 2),
       ('S6', 'P5', 'J4', 100);

-- access 

GRANT USAGE ON SCHEMA pmib6706 TO "pmi-b6711";

GRANT SELECT ON s, spj TO "pmi-b6711";

GRANT UPDATE ON s, spj TO "pmi-b6711";

GRANT DELETE ON s, spj TO "pmi-b6711";

REVOKE ALL ON s, spj FROM "pmi-b6711";

-- other scheme

UPDATE pmib6711.s
SET name = 'Смирнов'
WHERE name = 'Трухин';

DELETE FROM pmib6711.s
WHERE pmib6711.s.name = 'Смирнов';

DELETE FROM pmib6711.spj
WHERE pmib6711.spj.n_post = 'S6';

-- 1

SELECT 'Деталь ' || RIGHT(p.n_det, 1) || ' ' || 
       LEFT(p.name, 1) || '-' || RIGHT(p.name, 1) || ' / ' ||
       UPPER(p.cvet) AS det
FROM p;

-- 2

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