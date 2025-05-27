SELECT
	apn."name",
	COUNT(DISTINCT(pv.id))
FROM
	sierra_view.patron_view AS pv
	JOIN sierra_view.agency_property AS ap ON ap.code_num = pv.patron_agency_code_num
	JOIN sierra_view.agency_property_name AS apn ON apn.agency_property_id = ap.id
WHERE
	pv.activity_gmt >= '2023-04-01'
GROUP BY
	apn."name"