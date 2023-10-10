select distinct(concat('i',record_num,'a')), location_code
from sierra_view.item_view iv
left join sierra_view.varfield v 
on iv.id = v.record_id
where location_code in ('bmaaj','bmabj','bmacj','bmavj','bmbcj','bmdwj','bmej','bmfbj','bmfcj','bmfej','bmfgj','bmfpj','bmfxj','bmktj','bmlfj','bmlpj','bmmcj','bmnfj','bmnpj','bmpxj','bmraj','bmrcj','bmsej','bmsfj','bmspj','bmstj','bmvdj')
and v.varfield_type_code = 't'
and v.field_content != '3'
or location_code in ('bmaaj','bmabj','bmacj','bmavj','bmbcj','bmdwj','bmej','bmfbj','bmfcj','bmfej','bmfgj','bmfpj','bmfxj','bmktj','bmlfj','bmlpj','bmmcj','bmnfj','bmnpj','bmpxj','bmraj','bmrcj','bmsej','bmsfj','bmspj','bmstj','bmvdj')
and record_num not in (
	select record_num
	from sierra_view.item_view iv
	left join sierra_view.varfield v 
	on iv.id = v.record_id
	where location_code in ('bmaaj','bmabj','bmacj','bmavj','bmbcj','bmdwj','bmej','bmfbj','bmfcj','bmfej','bmfgj','bmfpj','bmfxj','bmktj','bmlfj','bmlpj','bmmcj','bmnfj','bmnpj','bmpxj','bmraj','bmrcj','bmsej','bmsfj','bmspj','bmstj','bmvdj')
	and v.varfield_type_code = 't'
	and v.field_content = '3')