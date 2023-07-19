Select * 
from
(
select concat('p', pv.record_num, 'a') as recnum, count(1)over(partition by pv.id) as Cnt
from sierra_view.patron_record_phone prp
join sierra_view.patron_view pv
on pv.id = prp.patron_record_id
where prp.patron_record_phone_type_id = '1'
)a
where Cnt > 1