SELECT
	barcode,
	itype_code_num,
	location_code
FROM
	sierra_view.item_view as iv
WHERE
	location_code LIKE 'gu%'	
ORDER BY
	itype_code_num
	