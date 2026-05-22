select count(ir.record_id), "name" 
from sierra_view.item_record ir
join sierra_view.agency_property ap 
on ap.code_num = ir.agency_code_num 
join sierra_view.agency_property_name apn 
on apn.agency_property_id = ap.id
where apn.iii_language_id = 1
group by "name" 