SELECT
	(SPLIT_PART(brp.best_title,':',1)) ||' by '|| REPLACE(SPLIT_PART(SPLIT_PART(brp.best_author,' (',1),', ',2),'.','')||' '||SPLIT_PART(brp.best_author,', ',1) as title,
	(SELECT barcode from sierra_view.patron_view as pv where pv.id = p.id)  as patron_barcode,
	h.removed_by_program
FROM  sierra_view.hold_removed h
	join
		sierra_view.bib_record_item_record_link bil ON h.record_id  = bil.bib_record_id  
	left join
		sierra_view.patron_view p on h.patron_record_id = p.id
	left join 
		sierra_view.item_record i on bil.item_record_id = i.record_id 
	left join 
		sierra_view.patron_record_phone t ON p.id = t.patron_record_id
	left join 
		sierra_view.itype_property_myuser ip ON i.itype_code_num = ip.code
	left join
		sierra_view.bib_record_property brp on bil.bib_record_id = brp.bib_record_id 
WHERE p.notification_medium_code IN ('a','p','z','-')
and h.removed_gmt > current_timestamp - interval '2 days'
and p.patron_agency_code_num = 11
GROUP BY 1,2,3
union
SELECT
	(SPLIT_PART(brp.best_title,':',1)) ||' by '|| REPLACE(SPLIT_PART(SPLIT_PART(brp.best_author,' (',1),', ',2),'.','')||' '||SPLIT_PART(brp.best_author,', ',1) as title,
	(SELECT barcode from sierra_view.patron_view as pv where pv.id = p.id)  as patron_barcode,
	h.removed_by_program
FROM  sierra_view.hold_removed h
	join
		sierra_view.bib_record_item_record_link bil ON h.record_id  = bil.item_record_id  
	left join
		sierra_view.patron_view p on h.patron_record_id = p.id
	left join 
		sierra_view.item_record i on bil.item_record_id = i.record_id 
	left join 
		sierra_view.patron_record_phone t ON p.id = t.patron_record_id
	left join 
		sierra_view.itype_property_myuser ip ON i.itype_code_num = ip.code
	left join
		sierra_view.bib_record_property brp on bil.bib_record_id = brp.bib_record_id 
WHERE p.notification_medium_code IN ('a','p','z','-')
and h.removed_gmt > current_timestamp - interval '2 days'
and p.patron_agency_code_num = 11
GROUP BY 1,2,3
