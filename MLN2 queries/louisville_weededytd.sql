SELECT
	count(iv.id),
	location_code
FROM
	sierra_view.item_view AS iv
	JOIN sierra_view.record_metadata AS rm ON rm.record_num = iv.record_num
WHERE
	rm.deletion_date_gmt >= '2025-01-01'
	AND iv.location_code LIKE 'ls%'
GROUP BY
	location_code