SELECT
	vt.record_type_code,
	vt.record_num,
	vt.marc_tag,
	unnest(string_to_array(vt.field_content, '|a')) AS Stuff,
	brt.best_title
FROM
	sierra_view.varfield_view as vt
JOIN
	sierra_view.bib_record as br
ON
	br.record_id = vt.record_id
JOIN
	sierra_view.bib_record_property as brt
ON
	brt.bib_record_id = br.record_id	
WHERE
	vt.marc_tag = '989'   
ORDER BY
   brt.best_title

