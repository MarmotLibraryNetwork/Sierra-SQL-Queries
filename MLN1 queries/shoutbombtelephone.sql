select phone_number, barcode, iii_language_pref_code
from sierra_view.patron_view v
join sierra_view.patron_record_phone r ON v.id = r.patron_record_id
join sierra_view.patron_record_phone_type ty ON r.patron_record_phone_type_id = ty.id
left join sierra_view.varfield v2 on v.id = v2.record_id
where code = 't'
and expiration_date_gmt > current_date
and home_library_code like 'mp%'
and v2.varfield_type_code = 'w'
and v2.field_content = 'v'