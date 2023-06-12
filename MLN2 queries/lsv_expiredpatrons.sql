SELECT
	distinct sierra_view.varfield.field_content as email,
	fn.first_name as firstname,
	fn.last_name as lastname
FROM
	sierra_view.patron_record
JOIN
   	sierra_view.patron_view as pv
ON
   	pv.id = sierra_view.patron_record.id
JOIN
   	sierra_view.patron_record_fullname as fn
ON
   	fn.patron_record_id = pv.id
JOIN
	sierra_view.varfield
ON
	sierra_view.patron_record.record_id = sierra_view.varfield.record_id
WHERE
	sierra_view.patron_record.expiration_date_gmt between NOW() and NOW() + INTERVAL '60' DAY
AND
	pv.home_library_code like 'ls%'
AND
	sierra_view.varfield.varfield_type_code = 'z'
AND
	pv.barcode IS NOT null
AND
	CONCAT(fn.first_name, ' ', fn.last_name) not like '%,%'
and
	sierra_view.varfield.field_content not like '%,%'
AND
	CONCAT(fn.first_name, ' ', fn.last_name) not like ' %'
and
	sierra_view.varfield.field_content like '%_@_%._%'
and
	sierra_view.patron_record.ptype_code != 44
and 
	age(now(),sierra_view.patron_record.activity_gmt) <= '2 years%'