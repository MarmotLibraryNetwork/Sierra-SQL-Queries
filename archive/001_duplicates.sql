select dups.record_type_code || dups.record_num
from sierra_view.varfield_view dups
join (select count(*), field_content, record_type_code
  from sierra_view.varfield_view
  where marc_tag = '001' and record_type_code = 'b'
  group by record_type_code, field_content
  having count(*) > 1
) seed on seed.field_content = dups.field_content and seed.record_type_code = dups.record_type_code
order by dups.field_content