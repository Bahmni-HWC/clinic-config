SELECT
    location,
    IFNULL(SUM(IF(visit_type_name = 'OPD New', 1, 0)), 0) AS OPD,
    IFNULL(SUM(IF(visit_type_name = 'OPD Review', 1, 0)), 0) AS Review,
    IFNULL(SUM(IF(visit_type_name = 'Community Visit', 1, 0)), 0) AS Community

FROM
    (
        SELECT
            v.visit_id,
            vt.name AS visit_type_name,
            p.person_id,
            l.name AS location,
            DATE(v.date_started) AS date_started,
    DATE(p.date_created) AS date_created
    FROM
            visit v
            INNER JOIN person p ON p.person_id = v.patient_id
    INNER JOIN visit_type vt ON vt.visit_type_id = v.visit_type_id
    INNER JOIN location l ON l.location_id = v.location_id
WHERE
    CAST(CONVERT_TZ(v.date_started, '+00:00', '+05:30') AS DATE) BETWEEN '#startDate#' AND '#endDate#'
    ) subquery
GROUP BY
    location;
