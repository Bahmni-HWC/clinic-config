SELECT
    l.name AS Location,
    SUM(CASE WHEN v.visit_type_id = 4 THEN 1 ELSE 0 END) AS `Online Registrations`,
    SUM(CASE WHEN v.visit_type_id = 6 THEN 1 ELSE 0 END) AS `Offline Registrations`,
    SUM(CASE WHEN v.visit_type_id = 4 THEN 1 ELSE 0 END) + SUM(CASE WHEN v.visit_type_id = 6 THEN 1 ELSE 0 END) AS `Total Registrations`
FROM
    location l
        LEFT JOIN visit v ON l.location_id = v.location_id
WHERE
        cast(CONVERT_TZ(v.date_started, '+00:00', '+5:30') AS DATE) BETWEEN '#startDate#' AND '#endDate#'
        AND
        v.visit_type_id IN (4, 6)
GROUP BY
    l.name;
