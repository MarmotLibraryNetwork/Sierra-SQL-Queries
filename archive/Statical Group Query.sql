SELECT
    id2reckey(bib_record_id) AS "Bib Record Number",
    COUNT(order_record_id) AS "# of Attached Order Records"
  FROM
    sierra_view.bib_record_order_record_link
  GROUP BY
    bib_record_id
  HAVING
    COUNT(order_record_id) = 74
;
