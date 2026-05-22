SELECT 
  iii_user.statistic_group_code_num, 
  iii_user.name, 
  iii_user.full_name
FROM 
  sierra_view.iii_user
WHERE 
  iii_user.statistic_group_code_num = 7
ORDER BY
  iii_user.name ASC;
