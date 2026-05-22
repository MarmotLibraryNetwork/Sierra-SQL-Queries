SELECT
	pr.home_library_code,
	ir.itype_code_num,
	CONCAT('i',record_num,'a') as record_number
FROM
	sierra_view.hold as h
JOIN
    sierra_view.item_record as ir
ON
	ir.record_id=h.record_id
JOIN 
	sierra_view.patron_record as pr
ON
	pr.record_id = h.patron_record_id
JOIN
	sierra_view.item_view as iv
ON
	iv.id = ir.record_id	
WHERE
	ir.itype_code_num = '28'
ORDER BY
	pr.home_library_code	
