-- On Order Query for LibraryIQ
-- Retrieves data about items that are currently on order
-- breaking out copy calculation to sub query to avoid one-to-many join errors

WITH copies_ordered AS(
SELECT
o.id AS order_record_id,
SUM(cmf.copies) AS copies

FROM sierra_view.order_record o
/*
cmf table handles copies/locations/fund data, which may contain multiple values for a single record
table also contains an extraneous row in these case for a location called 'multi' that displays to staff
filtering those rows out to avoid duplicate data
*/  
  JOIN sierra_view.order_record_cmf cmf
  ON o.id = cmf.order_record_id
  AND o.order_status_code IN ('o','q')
  AND cmf.location_code != 'multi'
GROUP BY 1
),

copies_paid AS(
SELECT
o.id AS order_record_id,
SUM(COALESCE(op.copies,0)) AS copies_paid

FROM sierra_view.order_record o
LEFT JOIN sierra_view.order_record_paid op
  ON o.id = op.order_record_id AND o.order_status_code IN ('o','q')
GROUP BY 1
)

SELECT * FROM(
SELECT
rmb.record_type_code||rmb.record_num AS "bibliographicRecordID",
a.name AS "branchCode",
rmo.record_type_code||rmo.record_num AS "orderID",
--total copies ordered - copies that have been paid for
c.copies - cp.copies_paid AS "copies",
TO_CHAR(CURRENT_DATE,'YYYY-MM-DD') AS "reportDate"

FROM sierra_view.order_record o
JOIN sierra_view.record_metadata rmo
  ON o.id = rmo.id
JOIN sierra_view.bib_record_order_record_link l
  ON o.id = l.order_record_id
JOIN sierra_view.record_metadata rmb
  ON l.bib_record_id = rmb.id
JOIN sierra_view.bib_record_property bp
  ON rmb.id = bp.bib_record_id
  AND bp.material_code NOT IN ('b','y','s','h','w','l')
/*
looking at accounting unit as an easy way to tie record to a single location
Single sites or libraries with a single accounting unit will need to look at order_record_cmf.location_code instead
*/
JOIN sierra_view.accounting_unit_myuser a
  ON o.accounting_unit_code_num = a.code
JOIN copies_ordered c
  ON o.id = c.order_record_id
JOIN copies_paid cp
  ON o.id = cp.order_record_id

WHERE 
  /*Filtering to orders that are still on order or that have only been partially received*/
  order_status_code IN ('o','q')
  AND a.name = 'BPL'
)inner_query
WHERE inner_query."copies" > 0;
