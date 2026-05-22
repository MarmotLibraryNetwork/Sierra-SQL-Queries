SELECT
	count(pv.id),
	"name"
FROM
	sierra_view.patron_view AS pv
	JOIN sierra_view.record_metadata AS rm ON rm.record_num = pv.record_num
	JOIN sierra_view.agency_property ap ON ap.code_num = pv.patron_agency_code_num
	JOIN sierra_view.agency_property_name apn ON apn.agency_property_id = ap.id
WHERE
	rm.creation_date_gmt BETWEEN '2023-01-01'
	AND '2023-12-30'
	AND apn.iii_language_id = 1
GROUP BY
	"name"