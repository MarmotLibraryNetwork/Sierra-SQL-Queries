CREATE VIEW determiner_expanded AS WITH split_itype (
	itype,
	str,
	rule_number,
	id
) AS (
	-- alternatively put your query here
	SELECT
		'',
		REPLACE(REPLACE(item_type,
				'[',
				''),
			']',
			'') || ',',
		rule_number,
		id
	FROM
		determiner
	UNION ALL
	SELECT
		substr(str,
			0,
			instr(str,
				',')),
		substr(str,
			instr(str,
				',') + 1),
		rule_number,
		id
	FROM
		split_itype
	WHERE
		str != ''
),
split_ptype (
	ptype,
	str,
	rule_number,
	id
) AS (
	-- alternatively put your query here
	SELECT
		'',
		REPLACE(REPLACE(patron_type,
				'[',
				''),
			']',
			'') || ',',
		rule_number,
		id
	FROM
		determiner
	UNION ALL
	SELECT
		substr(str,
			0,
			instr(str,
				',')),
		substr(str,
			instr(str,
				',') + 1),
		rule_number,
		id
	FROM
		split_ptype
	WHERE
		str != ''
)
SELECT
	d.id, d.location, CAST(TRIM(i.itype) AS INTEGER) AS itype, CAST(TRIM(p.ptype) AS INTEGER) AS ptype, d.rule_number, d.active
FROM
	determiner d
	JOIN split_itype i ON d.id = i.id
	JOIN split_ptype p ON i.id = p.id
WHERE
	i.itype != ''
	AND p.ptype != ''
ORDER BY
	2,
	1,
	5