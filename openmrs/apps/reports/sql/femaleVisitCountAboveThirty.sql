SELECT
    SUM(visit_type_name = 'OPD New')                                                                             AS `Total number of OPD cases`,
    SUM(age > 30)                                                                                                AS `Number of OPD cases above the age of 30`,
    SUM(age > 30 and gender = 'F')                                                                               AS `Number of Female OPD cases above the age of 30`,
    CONCAT(ROUND((SUM(age > 30 and gender = 'F') / NULLIF(SUM(visit_type_name = 'OPD New'), 0) * 100), 2), '%')  AS `Percentage of Female OPD cases above the age of 30`
FROM
    (
        SELECT
            vt.name AS visit_type_name,
            FLOOR(DATEDIFF(NOW(), p.birthdate) / 365) AS age,
            p.gender as gender
        FROM
            visit v
            INNER JOIN person p ON p.person_id = v.patient_id
            INNER JOIN visit_type vt ON vt.visit_type_id = v.visit_type_id
        WHERE
            CONVERT_TZ(v.date_started, '+00:00', '+5:30') BETWEEN '#startDate#' AND '#endDate#'
    ) 
AS raw_result;
