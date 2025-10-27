SELECT
	DATE_TRUNC('month', i.assessed_gmt) AS MONTH,
	COUNT(*) AS total_fines,
	SUM(i.item_charge_amt) AS total_amount_assessed,
	SUM(i.paid_amt) AS total_amount_collected,
	SUM(i.item_charge_amt - i.paid_amt) AS outstanding_balance
FROM
	sierra_view.fine AS i
	JOIN sierra_view.patron_record AS pr ON pr.id = i.patron_record_id
WHERE
	pr.home_library_code LIKE 'ev%'
	AND i.assessed_gmt >= CURRENT_DATE - INTERVAL '2 years'
	AND pr.pcode1 IN ('c', 'd')
GROUP BY
	DATE_TRUNC('month', i.assessed_gmt)
ORDER BY
	MONTH;