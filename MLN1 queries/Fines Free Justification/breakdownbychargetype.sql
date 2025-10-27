SELECT
	i.charge_code,
	CASE
		WHEN i.charge_code = '1' THEN 'Manual charge'
		WHEN i.charge_code = '2' THEN 'Overdue'
		WHEN i.charge_code = '3' THEN 'Replacement'
		WHEN i.charge_code = '4' THEN 'Adjustment (OVERDUEX)'
		WHEN i.charge_code = '5' THEN 'Lost book'
		WHEN i.charge_code = '6' THEN 'Overdue renewed'
		WHEN i.charge_code = '7' THEN 'Rental'
		WHEN i.charge_code = '8' THEN 'Rental adjustment (RENTALX)'
		WHEN i.charge_code = '9' THEN 'Debit'
		WHEN i.charge_code = 'a' THEN 'Notice'
		WHEN i.charge_code = 'b' THEN 'Credit card'
		WHEN i.charge_code = 'p' THEN 'Program (Program Registration)'
		ELSE 'Other'
	END AS charge_type,
	COUNT(*) AS total_charges,
	SUM(i.item_charge_amt) AS total_assessed,
	SUM(i.paid_amt) AS total_collected,
	SUM(i.item_charge_amt - i.paid_amt) AS outstanding_balance,
	ROUND(AVG(i.item_charge_amt), 2) AS avg_charge_amount,
	ROUND((SUM(i.paid_amt) / NULLIF(SUM(i.item_charge_amt), 0)) * 100, 2) AS collection_rate_percent
FROM
	sierra_view.fine AS i
	JOIN sierra_view.patron_record AS pr ON pr.id = i.patron_record_id
WHERE
	pr.home_library_code LIKE 'ev%'
	AND pr.pcode1 IN ('c', 'd')
GROUP BY
	i.charge_code
ORDER BY
	total_assessed DESC;