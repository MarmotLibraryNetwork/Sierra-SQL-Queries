SELECT
DISTINCT h.id AS "holdID",
rm.record_type_code||rm.record_num AS "bibliographicRecordID",
h.placed_gmt AS "requestedDate",
SUBSTRING(h.pickup_location_code,1,3) AS "requestedLocation",
CURRENT_DATE AS "reportDate"

FROM sierra_view.hold h
JOIN sierra_view.patron_record pr
  ON h.patron_record_id = pr.record_id
JOIN sierra_view.bib_record_item_record_link li
  ON h.record_id = li.bib_record_id OR h.record_id = li.item_record_id
JOIN sierra_view.record_metadata rm
  ON li.bib_record_id = rm.id
JOIN sierra_view.bib_record_property bp
  ON rm.id = bp.bib_record_id
WHERE
  (h.expires_gmt > CURRENT_DATE OR h.expires_gmt IS NULL)
  AND h.status = '0'
  AND pr.patron_agency_code_num IN (3,8);