SELECT
    id2reckey (p.record_id) || 'a' AS rid,
    p.index_entry
FROM
    sierra_view.phrase_entry AS p
    JOIN sierra_view.bib_record AS b ON p.record_id = b.record_id
WHERE
    --presently limited to e-books
    p.index_tag = 'i'
    AND p.index_entry IN (
        SELECT
            p.index_entry
        FROM
            sierra_view.phrase_entry AS p
        WHERE
            p.index_tag = 'i'
        GROUP BY
            p.index_entry
        HAVING
            count(p.id) > 1)
    ORDER BY
        index_entry,
        rid