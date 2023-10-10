SELECT record_num
FROM sierra_view.item_view iv
JOIN sierra_view.varfield v ON v.record_id = iv.id
WHERE location_code IN ('bmnfa', 'bmpra', 'bmrfa')
AND v.varfield_type_code = 't'
AND v.field_content != '2'
OR location_code IN ('bmnfa', 'bmpra', 'bmrfa')
AND record_num NOT IN (
    SELECT record_num
    FROM sierra_view.item_view iv
    LEFT JOIN sierra_view.varfield v ON iv.id = v.record_id
    WHERE location_code IN ('bmnfa', 'bmpra', 'bmrfa')
    AND v.varfield_type_code = 't'
    AND v.field_content = '2'
)
