select concat('p',pv.record_num,'a'), pv.owed_amt as total, sum(f.item_charge_amt) as Overdues
from sierra_view.patron_view pv 
join sierra_view.fine f
on f.patron_record_id = pv.id
join sierra_view.patron_record_address pra
on pra.patron_record_id = pv.id
where pv.patron_agency_code_num = 12
and f.charge_code in ('2','4','6')
group by pv.record_num, pra.postal_code, pv.owed_amt
having sum(f.item_charge_amt) > 10