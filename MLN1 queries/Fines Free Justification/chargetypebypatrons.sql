SELECT 
    CASE 
        WHEN i.charge_code = '2' THEN 'Overdue'
        WHEN i.charge_code = '3' THEN 'Replacement'
        WHEN i.charge_code = '5' THEN 'Lost book'
        WHEN i.charge_code = '6' THEN 'Overdue renewed'
        WHEN i.charge_code = 'a' THEN 'Notice'
        ELSE 'Other'
    END as charge_type,
    COUNT(DISTINCT pr.id) as unique_patrons,
    ROUND(AVG(patron_totals.patron_total), 2) as avg_per_patron,
    MAX(patron_totals.patron_total) as max_per_patron,
    MIN(patron_totals.patron_total) as min_per_patron
FROM sierra_view.fine as i
JOIN sierra_view.patron_record as pr ON pr.id = i.patron_record_id
JOIN (
    SELECT 
        patron_record_id,
        charge_code,
        SUM(item_charge_amt - paid_amt) as patron_total
    FROM sierra_view.fine
    WHERE item_charge_amt > paid_amt
    GROUP BY patron_record_id, charge_code
) patron_totals ON i.patron_record_id = patron_totals.patron_record_id 
    AND i.charge_code = patron_totals.charge_code
WHERE pr.home_library_code LIKE 'ev%'
    AND i.charge_code IN ('2', '3', '5', '6', 'a')
    AND patron_totals.patron_total > 0
GROUP BY i.charge_code
ORDER BY unique_patrons DESC;