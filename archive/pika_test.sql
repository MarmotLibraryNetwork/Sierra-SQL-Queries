SELECT
	br.marc_tag,
	br.record_num,
	br.content
FROM
	sierra_view.subfield_view as br
WHERE
	br.marc_tag = '989'		  


