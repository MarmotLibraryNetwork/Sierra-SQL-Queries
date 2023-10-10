SELECT
	(ct.transaction_gmt at time zone 'gmt' at time zone 'america/denver')::TIMESTAMP::DATE,
	concat('p', pv.record_num, 'a'),
	iv.barcode,
	CASE WHEN ct.op_code = 'o' THEN
		'Checkout'
	WHEN ct.op_code = 'r' THEN
		'Renewal'
	ELSE
		'other transaction type'
	END AS transaction_type
FROM
	sierra_view.circ_trans ct
	JOIN sierra_view.item_view iv ON iv.id = ct.item_record_id
	JOIN sierra_view.patron_view pv ON pv.id = ct.patron_record_id
WHERE
	iv.barcode = '{barcode}'
	AND ct.op_code in('o', 'r')
ORDER BY
	transaction_gmt