SELECT 
  pv.barcode,                                    
  pr.home_library_code,
  pr.birth_date_gmt
FROM 
  sierra_view.patron_record_fullname as prf
JOIN 
  sierra_view.patron_record as pr
ON
  prf.patron_record_id=pr.record_id
JOIN
  sierra_view.varfield_view as var
ON
  var.record_id = pr.record_id
JOIN
  sierra_view.patron_view as pv
ON
  pv.record_num = var.record_num         
WHERE
  pr.home_library_code LIKE '%'
AND
  pr.birth_date_gmt IS NOT NULL 
GROUP BY
  prf.first_name, prf.last_name, prf.middle_name, pr.home_library_code, pr.birth_date_gmt, pv.barcode
HAVING COUNT (concat(
    prf.last_name,
    CASE
      WHEN prf.first_name IS NULL THEN ''
      ELSE ', '||prf.first_name
    END, 
    CASE
      WHEN prf.middle_name IS NULL THEN ''
      ELSE ' '||prf.middle_name
    END
  )) > 1
  ;  
