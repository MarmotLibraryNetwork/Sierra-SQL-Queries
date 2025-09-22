-- Fulfilled Holds Query for LibraryIQ
-- Retrieves data about holds that have been fulfilled

SELECT
rm.record_type_code||rm.record_num AS "bibliographicRecordID",
t.id AS "holdID",
/*stat_group defines login where the transaction occured
how outreach or mobile device transactions are recorded will depend on customer setup*/
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
  AND bp.material_code NOT IN ('b','y','s','h','w','l')

WHERE 
  /*op_code f = filled hold*/
  t.op_code = 'f'
  AND t.transaction_gmt::DATE > CURRENT_DATE - INTERVAL '4 days'
  AND t.patron_agency_code_num = 3

ORDER BY t.transaction_gmt;