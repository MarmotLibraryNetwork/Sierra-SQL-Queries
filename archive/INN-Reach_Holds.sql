SELECT
	brl.location_code,
	brp.best_title,
	ir.item_status_code,
	prf.first_name,
	prf.last_name,
	irp.barcode
FROM 
	sierra_view.bib_record_location as brl
JOIN
	sierra_view.bib_record_item_record_link as bril
ON	
	bril.bib_record_id = brl.bib_record_id
JOIN
	sierra_view.bib_record_property as brp
ON
	brp.bib_record_id = bril.bib_record_id
JOIN
	sierra_view.item_record as ir
ON
	ir.record_id = bril.item_record_id
JOIN
	sierra_view.hold as h
ON
	h.record_id = ir.record_id
JOIN
	sierra_view.item_record_property as irp
ON
	irp.item_record_id = ir.record_id	
JOIN
	sierra_view.patron_record as pr
ON
	pr.record_id = h.patron_record_id
JOIN
	sierra_view.patron_record_fullname as prf
ON
	prf.patron_record_id = pr.record_id		
WHERE
	brl.location_code like '9%'
AND
	brp.best_title like '%'
ORDER BY 
	brp.best_title			