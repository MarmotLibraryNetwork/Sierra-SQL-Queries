SELECT 
    DATE_TRUNC('month', i.assessed_gmt) as month,
    COUNT(*) as total_fines,
    SUM(i.item_charge_amt) as total_amount_assessed,
    SUM(i.paid_amt) as total_amount_collected,
    SUM(i.item_charge_amt - i.paid_amt) as outstanding_balance
FROM sierra_view.fine as i
JOIN sierra_view.patron_record as pr ON pr.id = i.patron_record_id
WHERE pr.home_library_code LIKE 'ev%'
    AND i.assessed_gmt >= CURRENT_DATE - INTERVAL '2 years'
GROUP BY DATE_TRUNC('month', i.assessed_gmt)
ORDER BY month;