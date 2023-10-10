SELECT
	record_num,
	record_metadata_id,
	index_tag,
	process_gmt,
	cataloging_date_gmt,
	program_code,
	field,
	iii_user_name,
	title
FROM
	sierra_view.catmaint AS ct
	LEFT JOIN sierra_view.record_metadata AS rm ON ct.record_metadata_id = rm.id
WHERE
	rm.record_num = 3064212
ORDER BY
	"process_gmt" ASC