SELECT COUNT(*) AS 'Total number of OPD cases',
       ifnull(SUM(gender = "F"),0) AS 'Number of Female OPD cases' ,
       CONCAT(ROUND(SUM(gender = "F")/count(*) * 100, 2),'%') AS 'Percentage of Female OPD cases'
FROM (SELECT v.visit_id,
             p.person_id,
             p.gender AS gender
      FROM visit v
               INNER JOIN person p on p.person_id = v.patient_id
               INNER JOIN visit_type vt on vt.visit_type_id = v.visit_type_id
      WHERE cast(CONVERT_TZ(v.date_started, '+00:00', '+5:30') AS DATE) BETWEEN '#startDate#' AND '#endDate#'
        AND vt.name LIKE 'OPD%'
     )
AS raw_result;