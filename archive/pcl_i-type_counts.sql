SELECT 
  count(iv.itype_code_num) as number,
  iv.itype_code_num,
  iv.location_code,
  iv.agency_code_num
FROM 
  sierra_view.item_view as iv
WHERE 
  iv.agency_code_num = 76
GROUP BY
  iv.itype_code_num, iv.agency_code_num, iv.location_code
ORDER BY
  iv.itype_code_num ASC
LIMIT 100;  