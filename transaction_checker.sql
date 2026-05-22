select (ct.transaction_gmt at time zone 'gmt' at time zone 'america/denver')::TIMESTAMP::DATE,concat('p',pv.record_num,'a'), iv.barcode,
case
	when ct.op_code = 'o' then 'Checkout'
	when ct.op_code = 'r' then 'Renewal'
	else 'other transaction type'
end as transaction_type
from 
	sierra_view.circ_trans ct 
	join sierra_view.item_view iv
	on iv.id = ct.item_record_id
	join sierra_view.patron_view pv
	on pv.id = ct.patron_record_id
where
	iv.barcode = '31813003915922'
and 
	ct.op_code in ('o','r')
order by 
	transaction_gmt 
	