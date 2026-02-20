SELECT
    r.id                                   AS renewal_circ_trans_id,
    r.transaction_gmt                      AS renewal_gmt,
    r.item_record_id,
    r.patron_record_id,
    r.stat_group_code_num                  AS renewal_stat_group_code_num,

    co.id                                  AS checkout_circ_trans_id,
    co.transaction_gmt                     AS checkout_gmt,
    co.stat_group_code_num                 AS checkout_stat_group_code_num,

    sg.id                                  AS checkout_stat_group_id,
    sg.code_num                            AS checkout_stat_group_code_num_confirm,

    sgn.name                               AS checkout_stat_group_name

FROM sierra_view.circ_trans r

LEFT JOIN LATERAL (
    SELECT
        c.id,
        c.transaction_gmt,
        c.stat_group_code_num
    FROM sierra_view.circ_trans c
    WHERE c.item_record_id   = r.item_record_id
      AND c.patron_record_id = r.patron_record_id
      AND c.transaction_gmt  < r.transaction_gmt
      AND c.op_code          = 'o'
    ORDER BY c.transaction_gmt DESC
    LIMIT 1
) co ON TRUE

/* Map code_num -> statistic_group row */
LEFT JOIN sierra_view.statistic_group sg
  ON sg.code_num = co.stat_group_code_num

/* Map statistic_group.id -> statistic_group_name */
LEFT JOIN sierra_view.statistic_group_name sgn
  ON sgn.statistic_group_id = sg.id

WHERE r.op_code = 'r'
and co.stat_group_code_num IN (207,327,357)
ORDER BY r.transaction_gmt DESC;