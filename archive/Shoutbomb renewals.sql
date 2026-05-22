SELECT
	ct.patron_home_library_code,
	ct.patron_agency_code_num,
	ct.item_location_code,
	ct.due_date_gmt
FROM
	sierra_view.circ_trans as ct
WHERE
	ct.stat_group_code_num = '2'
AND
	ct.op_code = 'r'