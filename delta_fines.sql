select pv.home_library_code, f.charge_location_code, pv.owed_amt as total_owed, (sum(f.item_charge_amt)+sum(f.billing_fee_amt)) as odue_and_renewed, sum(f.paid_amt) as partially_paid, (sum(f.item_charge_amt)+sum(f.billing_fee_amt) -sum(f.paid_amt)) as remaining 
from 
sierra_view.patron_view pv
join
sierra_view.fine f
on f.patron_record_id = pv.id 
where
patron_agency_code_num = 14
and 
f.charge_code in ('2','4','6')
and
f.assessed_gmt between '2021-01-01' and '2022-05-01'
group by 
pv.home_library_code,pv.owed_amt,f.charge_location_code 
