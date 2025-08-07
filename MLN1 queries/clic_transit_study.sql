SELECT DISTINCT
    id2reckey(ir.id) AS "Record Key",
    brl.best_title,
    -- Convert and extract "Check-in Date" from message field
    TO_TIMESTAMP(COALESCE((regexp_match(vf.field_content, '^(\w{3} \w{3} \d{1,2} \d{4} \d{1,2}:\d{2}\w{2})'))[1], ''), 'Dy Mon DD YYYY HH12:MIAM')::DATE AS "Check-in Date",
    ct.item_location_code AS "From Location",
    COALESCE((regexp_match(ln_to.name, '.*\s(C\d+)$'))[1], 'N/A') AS "From Courier Code",
    -- Extract "send to location" from message field
    COALESCE((regexp_match(vf.field_content, 'IN TRANSIT from \w+ to (\w+)'))[1], 'N/A') AS "Send To Location",
    -- Extract courier code based on "Send To Location"
    COALESCE((regexp_match(ln_to_send.name, '.*\s(C\d+)$'))[1], 'N/A') AS "Send To Courier Code",
    -- Calculate "Days in Transit" using extracted date and round up
    CEIL(EXTRACT(EPOCH FROM (CURRENT_DATE - TO_TIMESTAMP(COALESCE((regexp_match(vf.field_content, '^(\w{3} \w{3} \d{1,2} \d{4} \d{1,2}:\d{2}\w{2})'))[1], ''), 'Dy Mon DD YYYY HH12:MIAM'))) / 86400) AS "Days in Transit"
FROM 
    sierra_view.item_record ir
JOIN 
    sierra_view.bib_record_item_record_link brirl ON brirl.item_record_id = ir.id
JOIN 
    sierra_view.bib_record_property brl ON brl.bib_record_id = brirl.bib_record_id
JOIN 
    sierra_view.circ_trans ct ON ct.item_record_id = ir.id
JOIN 
    sierra_view.location l_to ON l_to.code = ct.item_location_code
JOIN 
    sierra_view.location_name ln_to ON ln_to.location_id = l_to.id
JOIN 
    sierra_view.varfield vf ON vf.record_id = ir.id AND vf.varfield_type_code = 'm'
-- Join to match the "Send To Location" from the message
LEFT JOIN 
    sierra_view.location l_to_send ON l_to_send.code = COALESCE((regexp_match(vf.field_content, 'IN TRANSIT from \w+ to (\w+)'))[1], '')
LEFT JOIN 
    sierra_view.location_name ln_to_send ON ln_to_send.location_id = l_to_send.id
WHERE 
    ir.item_status_code = 't'
    AND ct.op_code = 'i'  -- check-in
    AND vf.field_content LIKE '%IN TRANSIT%'  -- Filter only "IN TRANSIT" messages
    AND ct.transaction_gmt = (
        SELECT MAX(transaction_gmt)
        FROM sierra_view.circ_trans
        WHERE item_record_id = ir.id
          AND op_code = 'i'
    )
    AND (
        LEFT(TRIM(ct.item_location_code), 2) != LEFT(TRIM(COALESCE((regexp_match(vf.field_content, 'IN TRANSIT from \w+ to (\w+)'))[1], '')), 2)
        OR LEFT(TRIM(ct.item_location_code), 3) != LEFT(TRIM(COALESCE((regexp_match(vf.field_content, 'IN TRANSIT from \w+ to (\w+)'))[1], '')), 3)
    )  -- Ensure first two or three characters do not match
ORDER BY 
    "Check-in Date" DESC;
