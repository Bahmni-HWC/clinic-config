SELECT
    IFNULL(SUM(visit_type_name LIKE 'OPD%'),0)                                                                                            AS `Total number of OPD cases`,
    IFNULL(SUM(age > 30 AND visit_type_name LIKE 'OPD%'),0)                                                                               AS `Number of OPD cases above the age of 30`,
    CONCAT(ROUND((IFNULL(SUM(age > 30 AND visit_type_name LIKE 'OPD%'),0) / IFNULL(SUM(visit_type_name = 'OPD New'), 1) * 100), 2), '%')  AS `Percentage of OPD cases above the age of 30`
FROM
    (
        SELECT
            vt.name AS visit_type_name,
            FLOOR(DATEDIFF(NOW(), p.birthdate) / 365) AS age
        FROM
            visit v
            INNER JOIN person p ON p.person_id = v.patient_id
            INNER JOIN visit_type vt ON vt.visit_type_id = v.visit_type_id
        WHERE
            CAST(CONVERT_TZ(v.date_started,'+00:00','+05:30') AS DATE) BETWEEN '#startDate#' AND '#endDate#'
    ) 
AS raw_result;
