SELECT 
  vv_homeroom.field_content AS homeroom,
  vv_barcode.field_content AS patron_barcode,
  prf.last_name,
  prf.first_name,
  irp.barcode AS item_barcode,
  brp.best_title AS title,
  brp.best_author AS author,
  irp.call_number,
  ct.checkout_gmt AS checkout_date,
  ct.due_gmt AS due_date,
  ir.price,
  ir.item_status_code AS item_status
FROM sierra_view.patron_record pr
JOIN sierra_view.checkout ct ON pr.record_id = ct.patron_record_id
JOIN sierra_view.patron_record_fullname prf ON pr.record_id = prf.patron_record_id
JOIN sierra_view.item_record ir ON ct.item_record_id = ir.id
JOIN sierra_view.item_record_property irp ON ir.id = irp.item_record_id
JOIN sierra_view.bib_record_item_record_link brirl ON brirl.item_record_id = ir.id
JOIN sierra_view.bib_record_property brp ON brirl.bib_record_id = brp.bib_record_id
-- Homeroom (varfield 'r' for patrons)
LEFT JOIN sierra_view.varfield_view vv_homeroom 
  ON pr.id = vv_homeroom.record_id 
  AND vv_homeroom.record_type_code = 'p' 
  AND vv_homeroom.varfield_type_code = 'r'
-- Patron barcode (varfield 'b' for patrons)
LEFT JOIN sierra_view.varfield_view vv_barcode 
  ON pr.id = vv_barcode.record_id 
  AND vv_barcode.record_type_code = 'p' 
  AND vv_barcode.varfield_type_code = 'b'
WHERE pr.home_library_code = 'ssg'
ORDER BY prf.last_name, prf.first_name
LIMIT 10;