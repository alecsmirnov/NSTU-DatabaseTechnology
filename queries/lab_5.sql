-- 1) Получить число поставок для каждого поставщика и найти их среднее.

SELECT ROUND(AVG(posts.p_count)) AS average
FROM (SELECT COUNT(spj.n_post) AS p_count
      FROM spj
      GROUP BY spj.n_post
     ) posts;

-- 2) Для каждого изделия из указанного города найти суммарный объем 
--    поставок по каждой детали, для него поставлявшейся. Вывести
--    номер изделия, название изделия, номер детали, название детали, цвет
--    детали, суммарный объем поставок детали для изделия.

SELECT j.n_izd, j.name, p.n_det, p.name, p.cvet, SUM(spj.kol * p.ves)
FROM spj
JOIN p ON spj.n_det = p.n_det
JOIN j ON spj.n_izd = j.n_izd
WHERE j.town = 'Афины'
GROUP BY j.n_izd, p.n_det

-- 3) Ввести номер детали P*. Найти города, в которые поставлялась
--    деталь P*, и определить, какой процент составляют поставки в каждый
--    город от общего числа поставок детали P*. Вывести город, число поставок 
--    деталей в этот город, общее число поставок детали P*, процент.

SELECT towns.town, towns.count, total.count, ROUND(towns.count * 100 / total.count, 2)
FROM (SELECT DISTINCT j.town, COUNT(spj.n_post) AS count
      FROM spj
      JOIN j ON spj.n_izd = j.n_izd
      WHERE spj.n_det = 'P1'
      GROUP BY j.town
     ) towns
CROSS JOIN (SELECT COUNT(spj.n_post) AS count
            FROM spj
            WHERE spj.n_det = 'P1'
           ) total;