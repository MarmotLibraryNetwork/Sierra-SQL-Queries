SELECT 
    COUNT(*) as blocked_patrons,
    AVG(fine_totals.amount_owed) as avg_amount_blocking
FROM sierra_view.patron_record as pr
JOIN (
    SELECT 
        patron_record_id,
        SUM(item_charge_amt - paid_amt) as amount_owed
    FROM sierra_view.fine
    GROUP BY patron_record_id
    HAVING SUM(item_charge_amt - paid_amt) > 0
) fine_totals ON pr.id = fine_totals.patron_record_id
WHERE pr.home_library_code LIKE 'ev%'
    AND pr.mblock_code != '-'