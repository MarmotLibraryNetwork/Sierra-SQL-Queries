select distinct(concat('i',record_num,'a')), iv.location_code
from sierra_view.item_view iv
join sierra_view.varfield v 
on v.record_id = iv.id
where location_code in ('bmaaa','bmaba','bmaca','bmava','bmbba','bmbca','bmea','bmerd','bmey','bmfca','bmfcx','bmfcy','bmfga','bmfma','bmfmx','bmfsa','bmfsx','bmlpa','bmmca','bmmha','bmnfx','bmsta','bmvda')
and v.varfield_type_code = 't'
and v.field_content != '1'
or location_code in ('bmaaa','bmaba','bmaca','bmava','bmbba','bmbca','bmea','bmerd','bmey','bmfca','bmfcx','bmfcy','bmfga','bmfma','bmfmx','bmfsa','bmfsx','bmlpa','bmmca','bmmha','bmnfx','bmsta','bmvda')
and record_num not in (
	select record_num
	from sierra_view.item_view iv
	left join sierra_view.varfield v 
	on iv.id = v.record_id
	where location_code in ('bmaaa','bmaba','bmaca','bmava','bmbba','bmbca','bmea','bmerd','bmey','bmfca','bmfcx','bmfcy','bmfga','bmfma','bmfmx','bmfsa','bmfsx','bmlpa','bmmca','bmmha','bmnfx','bmsta','bmvda')
	and v.varfield_type_code = 't'
	and v.field_content = '1')