-- Лабораторная 8 - Вариант 2

SELECT dets.n_det, posts.n_post
FROM (SELECT spj.n_det
      FROM spj
      GROUP BY spj.n_det
      HAVING SUM(spj.kol) < (SELECT AVG(sums.val)
                             FROM (SELECT SUM(spj.kol) AS val
                                   FROM spj
                                   GROUP BY spj.n_det
                                  ) sums
                            )
     ) dets
LEFT JOIN (SELECT spj.n_det, spj.n_post
           FROM spj
           GROUP BY spj.n_post, spj.n_det
           HAVING COUNT(DISTINCT spj.cost) = 1
          ) posts
ON dets.n_det = posts.n_det;


-- Лабораторная 9 - Вариант 11
-- Для каждого клиента вывести его заказы в хронологическом порядке и вычислить нарастающим итогом уплаченную сумму и долг

SELECT info.*, info.total - info.order AS debt
FROM (SELECT out_r.*, out_r.cost * out_r.kol AS price, 
             COALESCE((SELECT SUM(r.cost * r.kol)
                       FROM r
                       WHERE r.n_cl = out_r.n_cl AND r.date_order < out_r.date_order), 0
                      ) AS order,
             COALESCE((SELECT SUM(r.cost * r.kol)
                       FROM r
                       WHERE r.n_cl = out_r.n_cl AND (r.date_pay < out_r.date_order OR r.date_pay = out_r.date_order AND r.n_real != out_r.n_real)), 0
                      ) AS total
      FROM r AS out_r
      ORDER BY out_r.n_cl, out_r.date_order
     ) info;
