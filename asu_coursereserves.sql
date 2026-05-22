SELECT
    concat('r',cv.record_num,'a') as "Record Number",
    brp.best_title as "Title",
    ir.location_code as "Location Code",
    irp.barcode as "Barcode",
    (regexp_replace(irp.call_number,'\|.',' ','g')) AS "Call Number",
    var.field_content as "Course Name",
    vfrp.field_content as "Instructor",
    ir.year_to_date_checkout_total as "YTDCIRC",
    ir.last_year_to_date_checkout_total as "LYCIRC",
    ir.checkout_total as "Total Checkout",
    ir.last_checkout_gmt as "Last Out Date",
    cv.begin_date as "Start Date",
    cv.end_date as "End Date"
FROM
    sierra_view.course_view as cv
JOIN
    sierra_view.course_record_item_record_link as crirl
ON 
    crirl.course_record_id = cv.id
RIGHT JOIN
    sierra_view.item_record as ir
ON
    ir.record_id = crirl.item_record_id
JOIN
    sierra_view.bib_record_item_record_link as brirl
ON
    brirl.item_record_id = ir.record_id
JOIN
    sierra_view.bib_record_property as brp
ON
    brp.bib_record_id = brirl.bib_record_id
LEFT JOIN
    sierra_view.varfield as var
ON
    var.record_id = cv.id
AND
    var.varfield_type_code = 'r'
AND
    var.occ_num = 0
LEFT JOIN
    sierra_view.varfield as vfrp
ON
    vfrp.record_id = cv.id
AND
    vfrp.varfield_type_code = 'p'
AND
    vfrp.occ_num = 0
JOIN
    sierra_view.item_record_property as irp
ON
    irp.item_record_id = ir.record_id
WHERE
    ir.location_code like 'asre%'
ORDER BY
    cv.record_num