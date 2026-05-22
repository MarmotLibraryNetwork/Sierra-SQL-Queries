SELECT 
  concat(
    patron_record_fullname.last_name,
    CASE
      WHEN patron_record_fullname.first_name IS NULL THEN ''
      ELSE ', '||patron_record_fullname.first_name
    END, 
    CASE
      WHEN patron_record_fullname.middle_name IS NULL THEN ''
      ELSE ' '||patron_record_fullname.middle_name
    END
  )                                              AS "Patron Name",
  patron_record.home_library_code,
  patron_record.birth_date_gmt,
  pv.barcode
FROM 
  sierra_view.patron_record_fullname
JOIN 
  sierra_view.patron_record
ON
  sierra_view.patron_record_fullname.patron_record_id=sierra_view.patron_record.record_id
INNER JOIN
  sierra_view.varfield_view as var
ON
  var.record_id = patron_record.record_id
INNER JOIN
  sierra_view.patron_view as pv
ON
  pv.record_num = var.record_num    
WHERE
  patron_record.home_library_code LIKE 'gc%'
AND
  patron_record.birth_date_gmt IS NOT NULL
AND
  patron_record_fullname.last_name = 'Allen Kristin'
OR
  patron_record.home_library_code LIKE 'gc%'
AND
  patron_record.birth_date_gmt IS NOT NULL
AND
  patron_record_fullname.last_name = 'Alvarez'
AND
  patron_record_fullname.first_name = 'Jorge'
OR
  patron_record.home_library_code LIKE 'gc%'
AND
  patron_record.birth_date_gmt IS NOT NULL
AND
  patron_record_fullname.last_name = 'Boatwright'
AND
  patron_record_fullname.first_name = 'Connie'
OR
  patron_record.home_library_code LIKE 'gc%'
AND
  patron_record.birth_date_gmt IS NOT NULL
AND
  patron_record_fullname.last_name = 'Cassetty'
AND
  patron_record_fullname.first_name = 'Maeve'
OR
  patron_record.home_library_code LIKE 'gc%'
AND
  patron_record.birth_date_gmt IS NOT NULL
AND
  patron_record_fullname.last_name = 'Castillo'
AND
  patron_record_fullname.first_name = 'Petra'
OR
  patron_record.home_library_code LIKE 'gc%'
AND
  patron_record.birth_date_gmt IS NOT NULL
AND
  patron_record_fullname.last_name = 'Cisneros'
AND
  patron_record_fullname.first_name = 'Edwin'
OR
  patron_record.home_library_code LIKE 'gc%'
AND
  patron_record.birth_date_gmt IS NOT NULL
AND
  patron_record_fullname.last_name = 'Dudley'
AND
  patron_record_fullname.first_name = 'Paul'
AND
  patron_record.birth_date_gmt = '1941-02-15'  
OR
  patron_record.home_library_code LIKE 'gc%'
AND
  patron_record.birth_date_gmt IS NOT NULL
AND
  patron_record_fullname.last_name = 'Elliott'
AND
  patron_record_fullname.first_name = 'Tracy'
OR
  patron_record.home_library_code LIKE 'gc%'
AND
  patron_record.birth_date_gmt IS NOT NULL
AND
  patron_record_fullname.last_name = 'Eshelman'
AND
  patron_record_fullname.first_name = 'Amelia'
AND
  patron_record.birth_date_gmt = '1956-10-06'  
OR
  patron_record.home_library_code LIKE 'gc%'
AND
  patron_record.birth_date_gmt IS NOT NULL
AND
  patron_record_fullname.last_name = 'Garcia'
AND
  patron_record_fullname.first_name = 'Areli'
OR
  patron_record.home_library_code LIKE 'gc%'
AND
  patron_record.birth_date_gmt IS NOT NULL
AND
  patron_record_fullname.last_name = 'Gomez'
AND
  patron_record_fullname.first_name = 'Jose'
AND
  patron_record.birth_date_gmt = '2007-04-24'  
OR
  patron_record.home_library_code LIKE 'gc%'
AND
  patron_record.birth_date_gmt IS NOT NULL
AND
  patron_record_fullname.last_name = 'Hernandez'
AND
  patron_record_fullname.first_name = 'Irene'
OR
  patron_record.home_library_code LIKE 'gc%'
AND
  patron_record.birth_date_gmt IS NOT NULL
AND
  patron_record_fullname.last_name = 'Hoffman'
AND
  patron_record_fullname.first_name = 'Kenneth'
OR
  patron_record.home_library_code LIKE 'gc%'
AND
  patron_record.birth_date_gmt IS NOT NULL
AND
  patron_record_fullname.last_name = 'Holbrook'
AND
  patron_record_fullname.first_name = 'Haley'
OR
  patron_record.home_library_code LIKE 'gc%'
AND
  patron_record.birth_date_gmt IS NOT NULL
AND
  patron_record_fullname.last_name = 'Loya'
AND
  patron_record_fullname.first_name = 'Scarlett'
OR
  patron_record.home_library_code LIKE 'gc%'
AND
  patron_record.birth_date_gmt IS NOT NULL
AND
  patron_record_fullname.last_name = 'Mariscal'
AND
  patron_record_fullname.first_name = 'Crystal'
OR
  patron_record.home_library_code LIKE 'gc%'
AND
  patron_record.birth_date_gmt IS NOT NULL
AND
  patron_record_fullname.last_name = 'Maruri'
AND
  patron_record_fullname.first_name = 'Luis'
OR
  patron_record.home_library_code LIKE 'gc%'
AND
  patron_record.birth_date_gmt IS NOT NULL
AND
  patron_record_fullname.last_name = 'Mauer'
AND
  patron_record_fullname.first_name = 'Kauston'
OR
  patron_record.home_library_code LIKE 'gc%'
AND
  patron_record.birth_date_gmt IS NOT NULL
AND
  patron_record_fullname.last_name = 'Meador'
AND
  patron_record_fullname.first_name = 'Claire' 
OR
  patron_record.home_library_code LIKE 'gc%'
AND
  patron_record.birth_date_gmt IS NOT NULL
AND
  patron_record_fullname.last_name = 'Ortiz'
AND
  patron_record_fullname.first_name = 'Anthony'
AND
  patron_record.birth_date_gmt = '2004-12-15'  
OR
  patron_record.home_library_code LIKE 'gc%'
AND
  patron_record.birth_date_gmt IS NOT NULL
AND
  patron_record_fullname.last_name = 'Ortiz'
AND
  patron_record_fullname.first_name = 'Carlos'
AND
  patron_record.birth_date_gmt = '2002-10-29'  
OR
  patron_record.home_library_code LIKE 'gc%'
AND
  patron_record.birth_date_gmt IS NOT NULL
AND
  patron_record_fullname.last_name = 'Pallares'
AND
  patron_record_fullname.first_name = 'Andy'
OR
  patron_record.home_library_code LIKE 'gc%'
AND
  patron_record.birth_date_gmt IS NOT NULL
AND
  patron_record_fullname.last_name = 'Penaloza'
AND
  patron_record_fullname.first_name = 'Keyri'
OR
  patron_record.home_library_code LIKE 'gc%'
AND
  patron_record.birth_date_gmt IS NOT NULL
AND
  patron_record_fullname.last_name = 'Ruiz'
AND
  patron_record_fullname.first_name = 'Vanessa'
AND
  patron_record.birth_date_gmt = '2001-12-13'  
OR
  patron_record.home_library_code LIKE 'gc%'
AND
  patron_record.birth_date_gmt IS NOT NULL
AND
  patron_record_fullname.last_name = 'Salcido'
AND
  patron_record_fullname.first_name = 'Kareli'
OR
  patron_record.home_library_code LIKE 'gc%'
AND
  patron_record.birth_date_gmt IS NOT NULL
AND
  patron_record_fullname.last_name = 'Simon'
AND
  patron_record_fullname.first_name = 'Jimena'
OR
  patron_record.home_library_code LIKE 'gc%'
AND
  patron_record.birth_date_gmt IS NOT NULL
AND
  patron_record_fullname.last_name = 'Torres'
AND
  patron_record_fullname.first_name = 'Ricardo'
OR
  patron_record.home_library_code LIKE 'gc%'
AND
  patron_record.birth_date_gmt IS NOT NULL
AND
  patron_record_fullname.last_name = 'Van Deursen'
AND
  patron_record_fullname.first_name = 'Emily'                                                     
GROUP BY
 "Patron Name", patron_record.home_library_code, patron_record.birth_date_gmt, pv.barcode
ORDER By
  "Patron Name"        
  ;  
