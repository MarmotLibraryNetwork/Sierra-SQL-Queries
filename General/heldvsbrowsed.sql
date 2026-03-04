WITH checkouts AS (
    SELECT
        ct.item_location_code AS location_code,
        ln.name AS location_name,
        SUM(CASE WHEN ct.op_code = 'o' THEN 1 ELSE 0 END) as total_checkouts,
        SUM(CASE WHEN ct.op_code = 'f' THEN 1 ELSE 0 END) AS hold_checkouts
    FROM
        sierra_view.circ_trans ct
        JOIN sierra_view.location AS loc ON loc.code = ct.item_location_code
        JOIN sierra_view.location_name AS ln ON ln.location_id = loc.id
    WHERE
        -- code r doesn't do anything due to the sum cases in select line above
        ct.op_code IN ('o', 'r', 'f')
        -- change this to the agency code for the library. Can also add patron agency filter
        AND ct.item_agency_code_num = 3
        -- Uncomment to filter by date range:
        -- AND ct.transaction_gmt >= '2025-01-01'
        -- AND ct.transaction_gmt <  '2026-01-01'
    GROUP BY
        ct.item_location_code,
        ln.name
)
SELECT
    location_code           AS [Location],
    location_name           AS [Label],
    total_checkouts         AS [BPL Checkouts],
    hold_checkouts          AS [BPL Holds],
    ROUND(
        CAST(hold_checkouts AS NUMERIC) / NULLIF(total_checkouts, 0) * 100, 0
    )                       AS [% of Hold Transactions],
    (total_checkouts - hold_checkouts)
                            AS [Browsed],
    ROUND(
        CAST(total_checkouts - hold_checkouts AS NUMERIC) / NULLIF(total_checkouts, 0) * 100, 0
    )                       AS [% Browsed]
FROM
    checkouts
ORDER BY
    total_checkouts DESC;
