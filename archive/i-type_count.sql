SELECT 
  item_view.itype_code_num, 
  item_view.barcode
FROM 
  sierra_view.item_view
WHERE 
  item_view.itype_code_num = 0
ORDER BY
  item_view.barcode ASC;
