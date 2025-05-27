SELECT
	apn."name",
	count(DISTINCT(pv.id))
FROM
	sierra_view.patron_view AS pv
	JOIN sierra_view.record_metadata AS rm ON rm.record_num = pv.record_num
	JOIN sierra_view.agency_property AS ap ON ap.code_num = pv.patron_agency_code_num
	JOIN sierra_view.agency_property_name AS apn ON apn.agency_property_id = ap.id
WHERE
	rm.creation_date_gmt >= '2024-01-01'
	AND rm.creation_date_gmt < '2025-01-01'
	AND rm.record_type_code = 'p'
GROUP BY
	apn."name"