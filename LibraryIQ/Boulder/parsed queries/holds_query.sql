SELECT
DISTINCT rm.record_type_code||rm.record_num AS "BibNum",
SUBSTRING(h.pickup_location_code,1,3) AS "BranchID",
COUNT(DISTINCT h.id) AS "Number of requests"

FROM sierra_view.hold h
JOIN sierra_view.bib_record_item_record_link l
  ON h.record_id = l.bib_record_id OR h.record_id = l.item_record_id
JOIN sierra_view.record_metadata rm
  ON l.bib_record_id = rm.id
JOIN sierra_view.patron_record pr
  ON h.patron_record_id = pr.id

WHERE h.expires_gmt::DATE > CURRENT_DATE
AND pr.patron_agency_code_num = 3
GROUP BY 1,2;