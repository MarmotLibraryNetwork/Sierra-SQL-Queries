SELECT
	pr.home_library_code AS Home_Library,
	ir.location_code AS Location,
	iv.barcode AS Barcode,
	brp.best_title AS Title,
	to_char(co.due_gmt, 'MM-DD-YYYY') AS due,
	irp.call_number AS Call
FROM
	sierra_view.item_view AS iv
JOIN
	sierra_view.item_record_property AS irp
ON
	irp.barcode = iv.barcode
JOIN
	sierra_view.item_record AS ir
ON
	ir.record_id = irp.item_record_id
JOIN
	sierra_view.checkout AS co
ON
	co.item_record_id = ir.record_id
JOIN
	sierra_view.patron_record as pr
ON
	pr.record_id = co.patron_record_id
JOIN
	sierra_view.bib_record_item_record_link as bri
ON
	bri.item_record_id = ir.record_id
JOIN
	sierra_view.bib_record_property as brp
ON
	brp.bib_record_id = bri.bib_record_id	
WHERE
	due_gmt < NOW() - INTERVAL '1 year'
AND
	due_gmt IS NOT NULL
AND
    iv.barcode != ''
AND
	pr.home_library_code NOT LIKE '9%'    
ORDER BY
	pr.home_library_code    
LIMIT 2000000	
				