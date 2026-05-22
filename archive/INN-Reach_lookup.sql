SELECT 
bib_record_property.bib_level_code, 
bib_record_location.location_code, 
bib_record_property.best_title, 
bib_record_property.best_author, 
item_record_property.barcode, 
patron_record_fullname.first_name, 
patron_record_fullname.last_name, 
patron_view.barcode,
item_record.item_status_code
FROM 
sierra_view.bib_record_location, 
sierra_view.bib_record_item_record_link, 
sierra_view.bib_record_property, 
sierra_view.item_record_property, 
sierra_view.checkout, 
sierra_view.patron_record_fullname, 
sierra_view.patron_view,
sierra_view.item_record
WHERE 
bib_record_item_record_link.bib_record_id = bib_record_location.bib_record_id AND
bib_record_item_record_link.item_record_id = item_record_property.item_record_id AND
bib_record_item_record_link.bib_record_id = bib_record_property.bib_record_id AND
item_record_property.item_record_id = checkout.item_record_id AND
item_record_property.item_record_id = item_record.record_id AND
checkout.patron_record_id = patron_record_fullname.patron_record_id AND
checkout.patron_record_id = patron_view.id AND
bib_record_location.location_code like '9%'AND
item_record.item_status_code not like 'n' AND
bib_record_property.best_title like '%'OR
bib_record_item_record_link.bib_record_id = bib_record_location.bib_record_id AND
bib_record_item_record_link.item_record_id = item_record_property.item_record_id AND
bib_record_item_record_link.bib_record_id = bib_record_property.bib_record_id AND
item_record_property.item_record_id = checkout.item_record_id AND
item_record_property.item_record_id = item_record.record_id AND
checkout.patron_record_id = patron_record_fullname.patron_record_id AND
checkout.patron_record_id = patron_view.id AND
bib_record_location.location_code like '6%'AND
bib_record_property.best_title like '%' AND
item_record.item_status_code not like 'n'
ORDER BY
bib_record_location.location_code