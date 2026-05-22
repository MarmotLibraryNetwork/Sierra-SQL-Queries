SELECT
location,
itype,
ptype,
GROUP_CONCAT(DISTINCT id) AS determiner_row

FROM
determiner_expanded

GROUP BY 1,2,3
HAVING COUNT(rule_number) > 1
