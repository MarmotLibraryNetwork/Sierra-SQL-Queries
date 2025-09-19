SELECT 
    COUNT(DISTINCT i.patron_record_id) as patrons_with_fines,
    COUNT(DISTINCT pr.id) as total_active_patrons,
    ROUND(COUNT(DISTINCT i.patron_record_id) * 100.0 / COUNT(DISTINCT pr.id), 2) as percentage_with_fines,
    AVG(patron_fine_totals.total_owed) as avg_amount_owed
FROM sierra_view.patron_record as pr
LEFT JOIN (
    SELECT 
        patron_record_id,
        SUM(item_charge_amt - paid_amt) as total_owed
    FROM sierra_view.fine 
    WHERE item_charge_amt > paid_amt
    GROUP BY patron_record_id
) patron_fine_totals ON pr.id = patron_fine_totals.patron_record_id
LEFT JOIN sierra_view.fine as i ON pr.id = i.patron_record_id
WHERE pr.home_library_code LIKE 'ev%'