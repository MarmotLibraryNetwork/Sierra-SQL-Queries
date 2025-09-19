-- Unfilled Holds Query for LibraryIQ
-- Retrieves data about holds that are still unfilled

SELECT
DISTINCT h.id AS "holdID",
rm.record_type_code||rm.record_num AS "bibliographicRecordID",
h.placed_gmt AS "requestedDate",
/*logic for using first 3 characters of location code to designate branch specific to Minuteman*/
SUBSTRING(h.pickup_location_code,1,3) AS "requestedLocation",
CURRENT_DATE AS "reportDate"

FROM sierra_view.hold h
/*Using or in the join to reconcile both bib holds and item holds to a bib record*/
JOIN sierra_view.bib_record_item_record_link li
  ON h.record_id = li.bib_record_id OR h.record_id = li.item_record_id
JOIN sierra_view.record_metadata rm
  ON li.bib_record_id = rm.id
JOIN sierra_view.bib_record_property bp
  ON rm.id = bp.bib_record_id
  AND bp.material_code NOT IN ('b','y','s','h','w','l')

WHERE
  (h.expires_gmt > CURRENT_DATE OR h.expires_gmt IS NULL)
  --limit results to just holds with a status of on hold
  AND h.status = '0'

/*
Union to second query to account for volume level holds in addition to bib and item level ones
Minuteman does not use volume holds but meaningful for other customers
*/

UNION

SELECT
DISTINCT h.id AS "holdID",
rm.record_type_code||rm.record_num AS "bibliographicRecordID",
h.placed_gmt AS "requestedDate",
SUBSTRING(h.pickup_location_code,1,3) AS "requestedLocation",
CURRENT_DATE AS "reportDate"

FROM sierra_view.hold h
JOIN sierra_view.bib_record_volume_record_link lv
  ON h.record_id = lv.volume_record_id
JOIN sierra_view.record_metadata rm
  ON lv.bib_record_id = rm.id
JOIN sierra_view.bib_record_property bp
  ON rm.id = bp.bib_record_id
  AND bp.material_code NOT IN ('b','y','s','h','w','l')

WHERE  
  (h.expires_gmt > CURRENT_DATE OR h.expires_gmt IS NULL)
  --limit results to just holds with a status of on hold
  AND h.status = '0';
