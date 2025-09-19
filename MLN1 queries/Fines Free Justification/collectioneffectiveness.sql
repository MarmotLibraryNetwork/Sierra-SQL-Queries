SELECT 
    CASE 
        WHEN i.item_charge_amt = 0 THEN 'No charge'
        WHEN i.paid_amt = 0 THEN 'Unpaid'
        WHEN i.paid_amt < i.item_charge_amt THEN 'Partially paid'
        ELSE 'Fully paid'
    END as payment_status,
    COUNT(*) as count,
    SUM(i.item_charge_amt) as total_assessed,
    SUM(i.paid_amt) as total_collected
FROM sierra_view.fine as i
JOIN sierra_view.patron_record as pr ON pr.id = i.patron_record_id
WHERE pr.home_library_code LIKE 'ev%'
GROUP BY payment_status
ORDER BY count DESC;