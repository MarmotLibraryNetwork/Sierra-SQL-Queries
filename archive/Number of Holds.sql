SELECT
  pulnam.name                                    AS "Pickup At",
  -- build patron record number
  concat(
    prm.record_type_code,
    prm.record_num,
    'a'
  )                                              AS "Patron Number",
  -- build patron name (last name first)
  concat(
    pnam.last_name,
    CASE
      WHEN pnam.first_name IS NULL THEN ''
      ELSE ', '||pnam.first_name
    END, 
    CASE
      WHEN pnam.middle_name IS NULL THEN ''
      ELSE ' '||pnam.middle_name
    END
  )                                              AS "Patron Name",
  bprop.best_title                               AS "Title",
  lnam.name                                      AS "Item Location",
  regexp_replace(iprop.call_number,'\|.','','g') AS "Call Number",
  iprop.barcode                                  AS "Item Barcode"
FROM
  sierra_view.item_record                        AS i
JOIN
  -- join for item barcode
  sierra_view.item_record_property               AS iprop
  ON
  iprop.item_record_id = i.record_id
JOIN
  -- join for patron who placed hold
  sierra_view.hold                               AS hld
  ON
  hld.record_id = i.record_id
JOIN
  -- join for linked bib record
  sierra_view.bib_record_item_record_link        AS bilink
  ON
  bilink.item_record_id = i.record_id
JOIN
  -- join for bib title
  sierra_view.bib_record_property                AS bprop
  ON
  bprop.bib_record_id = bilink.bib_record_id
JOIN
  -- join for patron name
  sierra_view.patron_record_fullname             AS pnam
  ON
  pnam.patron_record_id = hld.patron_record_id
JOIN
  -- join for patron record number
  sierra_view.record_metadata                    AS prm
  ON
  prm.id = hld.patron_record_id
JOIN
  -- join for item location description
  sierra_view.location_myuser                    AS lnam
  ON
  lnam.code = i.location_code
JOIN
  -- join for pickup location description
  sierra_view.location_myuser                    AS pulnam
  ON
  pulnam.code = hld.pickup_location_code
WHERE
  -- CHANGE THE NEXT LINE TO CHANGE THE BRANCH
  hld.pickup_location_code LIKE 'gc%'
ORDER BY
  -- sort by columns 3 and 4
  3,4
;