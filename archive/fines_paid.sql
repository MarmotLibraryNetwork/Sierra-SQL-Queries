SELECT
 patron_view.barcode,
 fine.assessed_gmt,
 fine.item_charge_amt,
 fine.paid_gmt,
 fine.paid_amt,
 patron_view.owed_amt
FROM
 sierra_view.fine
 join sierra_view.patron_view ON patron_view.id=fine.patron_record_id
WHERE
 patron_view.barcode Like 'p000%'
ORDER BY
 patron_view.barcode