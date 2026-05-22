SELECT
	count(pv.id),
	"name"
FROM
	sierra_view.patron_view AS pv
	JOIN sierra_view.agency_property ap ON ap.code_num = pv.patron_agency_code_num
	JOIN sierra_view.agency_property_name apn ON apn.agency_property_id = ap.id
WHERE
	apn.iii_language_id = 1
	AND pv.activity_gmt BETWEEN '2022-01-01'
	AND '2024-03-21'
GROUP BY
	"name"