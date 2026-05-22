select iupm.user_name,iu.full_name,iu.statistic_group_code_num,iupm.permission_num,iupm.permission_name 
from sierra_view.iii_user iu 
join
sierra_view.iii_user_permission_myuser iupm 
on iupm.iii_user_id = iu.id 
where iu.iii_user_group_code like 'ea%'