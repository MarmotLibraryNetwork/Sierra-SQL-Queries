SELECT 
  CASE 
    WHEN pr.expiration_date_gmt < NOW() THEN 'Expired'
    ELSE 'Not Expired'
  END AS account_status,
  COUNT(*) AS account_count
FROM sierra_view.patron_record AS pr
JOIN sierra_view.agency_property AS ap
  ON ap.code_num = pr.patron_agency_code_num
JOIN sierra_view.agency_property_name AS apn
  ON apn.agency_property_id = ap.id
JOIN sierra_view.patron_record_address AS pra
  ON pra.patron_record_id = pr.id
WHERE apn.name LIKE 'Louis%'
  AND UPPER(pra.city) = 'SUPERIOR'
GROUP BY account_status
ORDER BY account_status;