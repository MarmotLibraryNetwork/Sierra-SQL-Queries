SELECT
	CASE
		WHEN i.item_charge_amt = 0 THEN 'No charge'
		WHEN i.paid_amt = 0 THEN 'Unpaid'
		WHEN i.paid_amt < i.item_charge_amt THEN 'Partially paid'
		ELSE 'Fully paid'
	END AS payment_status,
	COUNT(*) AS COUNT,
	SUM(i.item_charge_amt) AS total_assessed,
	SUM(i.paid_amt) AS total_collected
FROM
	sierra_view.fine AS i
	JOIN sierra_view.patron_record AS pr ON pr.id = i.patron_record_id
WHERE
	pr.home_library_code LIKE 'ev%'
	AND pr.pcode1 IN ('c', 'd')
GROUP BY
	payment_status
ORDER BY
	COUNT DESC;