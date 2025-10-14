SELECT
    id2reckey(p.id) AS patron_id,
    p.barcode AS patron_barcode,
	co.id AS checkout_id,
    id2reckey(co.item_record_id) as item_record_id,
    co.transaction_gmt AS checkout_date,
    (SELECT ci.id 
     FROM sierra_view.circ_trans ci 
     WHERE ci.item_record_id = co.item_record_id 
       AND ci.op_code = 'i'
       AND ci.transaction_gmt > co.transaction_gmt
     ORDER BY ci.transaction_gmt ASC 
     LIMIT 1) AS checkin_id,
    (SELECT ci.transaction_gmt 
     FROM sierra_view.circ_trans ci 
     WHERE ci.item_record_id = co.item_record_id 
       AND ci.op_code = 'i'
       AND ci.transaction_gmt > co.transaction_gmt
     ORDER BY ci.transaction_gmt ASC 
     LIMIT 1) AS checkin_date,
    CASE 
        WHEN (SELECT ci.transaction_gmt 
              FROM sierra_view.circ_trans ci 
              WHERE ci.item_record_id = co.item_record_id 
                AND ci.op_code = 'i'
                AND ci.transaction_gmt > co.transaction_gmt
              ORDER BY ci.transaction_gmt ASC 
              LIMIT 1) IS NULL 
        THEN 'Still Checked Out'
        ELSE 'Returned'
    END AS status
FROM
    sierra_view.patron_view AS p
    INNER JOIN sierra_view.circ_trans AS co ON p.id = co.patron_record_id
WHERE
    co.op_code = 'o'
    AND co.transaction_gmt >= CURRENT_DATE - INTERVAL '30 days'  -- Look back 30 days
    and co.itype_code_num = 280
ORDER BY
    co.transaction_gmt
LIMIT 100