SELECT u.name AS User, c.name AS Location, COUNT(DISTINCT e.individual_id) AS "Offline OPD Visit Count"
FROM users AS u
    JOIN catchment AS c ON u.catchment_id = c.id
    JOIN encounter AS e ON u.id = e.created_by_id
WHERE DATE(e.encounter_date_time) BETWEEN '#startDate#' AND '#endDate#'
GROUP BY u.name, c.name
ORDER BY User, Location;