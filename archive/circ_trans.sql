SELECT 
	EXTRACT(HOUR FROM ct.transaction_gmt)||':00' AS HOUR,
	count(*) AS TRANSACTION
FROM 
	sierra_view.circ_trans ct
WHERE 
	ct.op_code = 'o'
AND 
	ct.item_location_code like 'mp%'
AND
   ct.transaction_gmt between '2017-04-05' and '2017-04-06'
AND 
	EXTRACT(HOUR FROM ct.transaction_gmt) BETWEEN '0' AND '23'
GROUP BY 
	EXTRACT(HOUR FROM ct.transaction_gmt)
ORDER BY 
	EXTRACT(HOUR FROM ct.transaction_gmt);