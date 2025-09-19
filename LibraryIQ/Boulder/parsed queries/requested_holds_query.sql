-- Requested Holds Query for LibraryIQ
-- Retrieves data about holds that have been requested

SELECT
rm.record_type_code||rm.record_num AS "bibliographicRecordID",
t.id AS "holdID",
/*
home_library_code is the default pickup location for the patron placing the hold
the patron does have the option to change it on the fly when placing the hold
*/
SUBSTRING(p.home_library_code,1,3) AS "patronLocation",
t.transaction_gmt AS "requestedDate",
CURRENT_DATE AS "reportDate"

FROM sierra_view.circ_trans t
JOIN sierra_view.record_metadata rm
  ON t.bib_record_id = rm.id
JOIN sierra_view.patron_record p
  ON t.patron_record_id = p.id
JOIN sierra_view.bib_record_property bp
  ON rm.id = bp.bib_record_id
  AND bp.material_code NOT IN ('b','y','s','h','w','l')

WHERE 
  /*
  different types of holds are assigned different op_code values
  looking for any starting with an n or h will capture all options
  */
  t.op_code ~ '^(n|h)'
  AND t.transaction_gmt::DATE > CURRENT_DATE - INTERVAL '4 days'

ORDER BY t.transaction_gmt;
