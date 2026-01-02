SELECT
	rmi.record_type_code || rmi.record_num AS "ItemNum",
	ip.barcode AS "Barcode",
	rmb.record_type_code || rmb.record_num AS "BibNum",
	rmp.record_type_code || rmp.record_num AS "PatronNum",
	TO_CHAR(t.transaction_gmt, 'YYYY-MM-DD HH24:MI:SS') AS "CheckoutDate",
	CASE
		WHEN LOWER(SUBSTRING(sg.location_code, 1, 3)) = 'all'
		AND t.op_code = 'r' THEN SUBSTRING(p.home_library_code, 1, 3)
		ELSE SUBSTRING(sg.location_code, 1, 3)
	END AS "BranchCodeNum",
	CASE
		WHEN t.op_code = 'r' THEN 'RENEWAL'
		WHEN t.op_code = 'o' THEN 'CHECKOUT'
		WHEN t.op_code = 'u' THEN 'USE COUNT'
	END AS "TransactionType",
	t.due_date_gmt::DATE AS "DueDate",
	i.last_checkin_gmt::DATE AS "CheckInDate"
FROM
	sierra_view.circ_trans t
	JOIN sierra_view.item_record i ON t.item_record_id = i.id
	JOIN sierra_view.record_metadata rmi ON i.id = rmi.id
	JOIN sierra_view.item_record_property ip ON i.id = ip.item_record_id
	JOIN sierra_view.record_metadata rmb ON t.bib_record_id = rmb.id
	JOIN sierra_view.record_metadata rmp ON t.patron_record_id = rmp.id
	JOIN sierra_view.patron_record p ON t.patron_record_id = p.id
	JOIN sierra_view.statistic_group_myuser sg ON t.stat_group_code_num = sg.code
WHERE
	t.op_code IN ('o', 'r', 'u')
	AND t.transaction_gmt::DATE > CURRENT_DATE - INTERVAL '4 days'
	AND p.patron_agency_code_num = 88
UNION ALL
-- Subquery 2: Patrons from any agency having transactions on items from agency = 3
SELECT
	rmi.record_type_code || rmi.record_num AS "ItemNum",
	ip.barcode AS "Barcode",
	rmb.record_type_code || rmb.record_num AS "BibNum",
	rmp.record_type_code || rmp.record_num AS "PatronNum",
	TO_CHAR(t.transaction_gmt, 'YYYY-MM-DD HH24:MI:SS') AS "CheckoutDate",
	CASE
		WHEN LOWER(SUBSTRING(sg.location_code, 1, 3)) = 'all'
		AND t.op_code = 'r' THEN SUBSTRING(p.home_library_code, 1, 3)
		ELSE SUBSTRING(sg.location_code, 1, 3)
	END AS "BranchCodeNum",
	CASE
		WHEN t.op_code = 'r' THEN 'RENEWAL'
		WHEN t.op_code = 'o' THEN 'CHECKOUT'
		WHEN t.op_code = 'u' THEN 'USE COUNT'
	END AS "TransactionType",
	t.due_date_gmt::DATE AS "DueDate",
	i.last_checkin_gmt::DATE AS "CheckInDate"
FROM
	sierra_view.circ_trans t
	JOIN sierra_view.item_record i ON t.item_record_id = i.id
	JOIN sierra_view.record_metadata rmi ON i.id = rmi.id
	JOIN sierra_view.item_record_property ip ON i.id = ip.item_record_id
	JOIN sierra_view.record_metadata rmb ON t.bib_record_id = rmb.id
	LEFT JOIN sierra_view.record_metadata rmp ON t.patron_record_id = rmp.id
	LEFT JOIN sierra_view.patron_record p ON t.patron_record_id = p.id
	JOIN sierra_view.statistic_group_myuser sg ON t.stat_group_code_num = sg.code
WHERE
	t.op_code IN ('o', 'r', 'u')
	AND t.transaction_gmt::DATE > CURRENT_DATE - INTERVAL '4 days'
	AND i.agency_code_num = 88;