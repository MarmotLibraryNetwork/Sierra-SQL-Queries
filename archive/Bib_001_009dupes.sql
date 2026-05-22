SELECT
	vt.record_type_code,
	vt.record_num,
	vt.marc_tag,
	vt.field_content
FROM
	sierra_view.varfield_view as vt
WHERE
	vt.marc_tag = '019'
OR
   vt.marc_tag = '001'
ORDER BY
   vt.record_num	
 