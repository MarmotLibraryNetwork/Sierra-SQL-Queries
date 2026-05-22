SELECT
	c.checkout_gmt,
	pr.record_id,
	ir.record_id,
	c.checkout_gmt
FROM
	sierra_view.checkout as c
JOIN
	sierra_view.patron_record as pr
ON
	pr.record_id = c.patron_record_id
JOIN
	sierra_view.item_record as ir
ON
	ir.record_id = c.item_record_id
WHERE
	pr.home_library_code like 'mp%'
AND
	c.checkout_gmt between current_date - 1 and current_date - 0
GROUP BY
	pr.record_id, ir.record_id, c.checkout_gmt
ORDER BY
	pr.record_id
		
	