SELECT 
  iii_user_permission_myuser.user_name, 
  iii_user_permission_myuser.permission_num
FROM 
  sierra_view.iii_user_permission_myuser
WHERE 
  iii_user_permission_myuser.permission_num = 787
ORDER BY
  iii_user_permission_myuser.user_name ASC;
