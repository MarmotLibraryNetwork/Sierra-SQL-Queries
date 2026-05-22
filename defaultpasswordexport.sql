select pv.barcode,pv.home_library_code,v.field_content
from sierra_view.patron_view pv 
join sierra_view.varfield v 
on v.record_id = pv.id
where v.varfield_type_code = '='
order by home_library_code 