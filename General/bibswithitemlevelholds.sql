SELECT 
    id2reckey(br.record_id) AS bib_record,
    COUNT(ho.id) AS hold_count
FROM sierra_view.item_record AS ir
JOIN sierra_view.varfield AS vr
    ON vr.record_id = ir.record_id
JOIN sierra_view.bib_record_item_record_link AS brirl
    ON brirl.item_record_id = ir.record_id
JOIN sierra_view.bib_record AS br
    ON br.record_id = brirl.bib_record_id
JOIN sierra_view."hold" AS ho
    ON ho.record_id = ir.record_id
WHERE ir.location_code LIKE 'cu%'
    AND vr.varfield_type_code = 'v'
GROUP BY br.record_id
ORDER BY hold_count DESC;