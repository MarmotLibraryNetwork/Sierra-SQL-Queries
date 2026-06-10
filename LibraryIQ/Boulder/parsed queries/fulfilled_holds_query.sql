SELECT
rm.record_type_code||rm.record_num AS "bibliographicRecordID",
t.id AS "holdID",
SUBSTRING(sg.location_code,1,3) AS "requestedLocation",
t.transaction_gmt AS "fulfilledDate",
CURRENT_DATE AS "reportDate"

FROM sierra_view.circ_trans t
JOIN sierra_view.record_metadata rm
  ON t.bib_record_id = rm.id
JOIN sierra_view.statistic_group_myuser sg
  ON t.stat_group_code_num = sg.code
JOIN sierra_view.bib_record_property bp
  ON rm.id = bp.bib_record_id
WHERE
  t.op_code = 'f'
  AND t.transaction_gmt::DATE > CURRENT_DATE - INTERVAL '4 days'
  AND t.patron_agency_code_num IN (3,8)

ORDER BY t.transaction_gmt;