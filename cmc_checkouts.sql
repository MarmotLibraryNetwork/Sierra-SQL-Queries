select concat('p',pv.record_num,'a') as recordNum, barcode, count(distinct ct.id) as Checkouts
from sierra_view.circ_trans ct
left join sierra_view.patron_view pv 
on pv.id = ct.patron_record_id
where ct.transaction_gmt > current_date - interval '6 months'
and pv.home_library_code like 'cm%'
and ct.op_code = 'o'
group by pv.barcode, pv.record_num
order by pv.record_num;