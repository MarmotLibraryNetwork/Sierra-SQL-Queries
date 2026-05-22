select item_view.barcode, item_view.location_code, CONCAT('i',record_num,'a') as record_number
from sierra_view.item_view
where item_view.location_code like 'pr%'
and barcode like ''
  ;  
