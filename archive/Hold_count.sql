SELECT
	count(sierra_view.hold.patron_record_id) as NumHolds,
	sierra_view.patron_view.barcode
FROM
	sierra_view.hold
JOIN
    sierra_view.patron_record
ON
	sierra_view.hold.patron_record_id=sierra_view.patron_record.record_id
JOIN
   sierra_view.patron_view
ON
   sierra_view.patron_record.record_id=sierra_view.patron_view.id
WHERE
	sierra_view.patron_view.home_library_code like 'mp%'
GROUP BY
	sierra_view.hold.patron_record_id, sierra_view.patron_record.record_id, sierra_view.patron_view.barcode
HAVING COUNT (sierra_view.hold.patron_record_id) > 20; 	    	
	