SELECT 
  iii_user.iii_user_group_code, 
  iii_user.name
FROM 
  sierra_view.iii_user
WHERE
  sierra_view.iii_user.iii_user_group_code = '';
