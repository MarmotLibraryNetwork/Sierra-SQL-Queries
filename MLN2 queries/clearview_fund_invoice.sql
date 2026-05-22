SELECT
	fm.code AS fund_name,
	ir.invoice_date_gmt,
	irl.line_cnt,
	irl.lien_amt,
	ir.discount_amt,
	ir.shipping_amt AS service_charge,
	ir.grand_total_amt,
	ir.invoice_number_text
FROM
	sierra_view.invoice_record ir
	JOIN sierra_view.invoice_record_line irl ON irl.invoice_record_id = ir.id
	JOIN sierra_view.fund_master fm ON fm.code_num = irl.fund_code::int
	AND fm.accounting_unit_id = ir.accounting_unit_code_num
WHERE
	ir.accounting_unit_code_num = 7
ORDER BY
	ir.invoice_date_gmt DESC,
	ir.invoice_number_text,
	irl.line_cnt;