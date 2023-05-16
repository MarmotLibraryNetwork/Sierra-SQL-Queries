select b.*, iv.barcode 
from sierra_view.booking b
left join sierra_view.item_view iv 
on b.item_record_id = iv.id