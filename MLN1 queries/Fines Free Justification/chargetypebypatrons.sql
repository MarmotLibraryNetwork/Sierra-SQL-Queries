SELECT
	CASE
		WHEN i.charge_code = '2' THEN 'Overdue'
		WHEN i.charge_code = '3' THEN 'Replacement'
		WHEN i.charge_code = '5' THEN 'Lost book'
		WHEN i.charge_code = '6' THEN 'Overdue renewed'
		WHEN i.charge_code = 'a' THEN 'Notice'
		ELSE 'Other'
	END AS charge_type,
	COUNT(DISTINCT pr.id) AS unique_patrons,
	ROUND(AVG(patron_totals.patron_total), 2) AS avg_per_patron,
	MAX(patron_totals.patron_total) AS max_per_patron,
	MIN(patron_totals.patron_total) AS min_per_patron
FROM
	sierra_view.fine AS i
	JOIN sierra_view.patron_record AS pr ON pr.id = i.patron_record_id
	JOIN (
		SELECT
			patron_record_id,
			charge_code,
			SUM(item_charge_amt - paid_amt) AS patron_total
		FROM
			sierra_view.fine
		WHERE
			item_charge_amt > paid_amt
		GROUP BY
			patron_record_id,
			charge_code
	) patron_totals ON i.patron_record_id = patron_totals.patron_record_id
	AND i.charge_code = patron_totals.charge_code
WHERE
	pr.home_library_code LIKE 'ev%'
	AND i.charge_code IN ('2', '3', '5', '6', 'a')
	AND patron_totals.patron_total > 0
	AND pr.pcode1 IN ('c', 'd')
GROUP BY
	i.charge_code
ORDER BY
	unique_patrons DESC;