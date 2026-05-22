select
concat('b' || record_num),
deletion_date_gmt,
agency_code_num,
campus_code
from sierra_view.record_metadata
where record_type_code = 'i'
and deletion_date_gmt > (now() - interval '30 day')
and record_num = '5433800' 
order by deletion_date_gmt 
desc limit 500000;