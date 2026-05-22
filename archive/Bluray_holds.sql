SELECT
	vt.record_num,
	vt.field_content,
	brp.best_title
FROM
	sierra_view.varfield_view as vt
JOIN
	sierra_view.bib_record_property as brp
ON
	brp.bib_record_id = vt.record_id	
JOIN
	sierra_view.bib_record as br
ON
	br.record_id = vt.record_id
JOIN
	sierra_view.bib_record_item_record_link as brit
ON
	brit.bib_record_id = br.record_id
JOIN
		
WHERE
	vt.marc_tag = '250'
AND
	vt.field_content like '%lu-ray%'
GROUP BY 
	vt.record_num, vt.field_content, brp.best_title	ORDER BY
   brp.best_title	
 