SELECT
	COUNT(DISTINCT i.patron_record_id) AS patrons_with_fines,
	COUNT(DISTINCT pr.id) AS total_active_patrons,
	ROUND(COUNT(DISTINCT i.patron_record_id) * 100.0 / COUNT(DISTINCT pr.id), 2) AS percentage_with_fines,
	AVG(patron_fine_totals.total_owed) AS avg_amount_owed
FROM
	sierra_view.patron_record AS pr
	LEFT JOIN (
		SELECT
			patron_record_id,
			SUM(item_charge_amt - paid_amt) AS total_owed
		FROM
			sierra_view.fine
		WHERE
			item_charge_amt > paid_amt
		GROUP BY
			patron_record_id
	) patron_fine_totals ON pr.id = patron_fine_totals.patron_record_id
	LEFT JOIN sierra_view.fine AS i ON pr.id = i.patron_record_id
WHERE
	pr.home_library_code LIKE 'ev%'
	AND pr.pcode1 IN ('c', 'd')