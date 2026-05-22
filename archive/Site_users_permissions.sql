SELECT
	user_name,
	permission_num,
	permission_name,
	statistic_group_code_num 
FROM 
	sierra_view.iii_user_permission_myuser 
INNER Join
    sierra_view.iii_user
ON    
    sierra_view.iii_user.name = sierra_view.iii_user_permission_myuser.user_name	
WHERE 
	statistic_group_code_num BETWEEN 280 AND 362
ORDER BY 
	user_name;