select prf.last_name, prf.first_name, pv.barcode, v.field_content, concat(left(prf.last_name,3),right(pv.barcode,4))
from sierra_view.patron_view pv
left join sierra_view.patron_record_fullname prf
on pv.id = prf.patron_record_id 
left join sierra_view.varfield v 
on pv.id = v.record_id
where pv.patron_agency_code_num = 14
and v.varfield_type_code = 'q'
and v.field_content != concat(left(prf.last_name,3),right(pv.barcode,4))