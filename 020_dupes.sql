SELECT
    b.record_id,
    p.index_entry,
    brp.best_title,
    brp.best_author,
    ir.location_code,
    h.pickup_location_code,
    h.id,
    ord.accounting_unit_code_num,
    apn."name" 
FROM
    sierra_view.phrase_entry AS p
    JOIN sierra_view.bib_record AS b ON p.record_id = b.record_id
    join sierra_view.bib_record_property as brp on p.record_id = brp.bib_record_id
    join sierra_view.bib_record_item_record_link as bri on bri.bib_record_id = b.id 
    join sierra_view.item_record as ir on ir.id = bri.item_record_id 
    join sierra_view.agency_property ap on ap.code_num = ir.agency_code_num 
    join sierra_view.agency_property_name apn on apn.agency_property_id = ap.id 
    left join sierra_view.bib_record_order_record_link bro on bro.bib_record_id = b.id
    left join sierra_view.order_record as ord on ord.id = bro.order_record_id 
    left join sierra_view."hold" h on h.record_id = b.id
WHERE
    --presently limited to e-books
    p.index_tag = 'i'
    AND p.index_entry IN (
        SELECT
            p.index_entry
        FROM
            sierra_view.phrase_entry AS p
        WHERE
            p.index_tag = 'v'
        GROUP BY
            p.index_entry
        HAVING
            count(p.id) > 1)