SELECT
    l.name AS "Location",
    SUM(CASE WHEN et.name = "REG" THEN 1 ELSE 0 END) AS "Online Registration Count",
    SUM(CASE WHEN et.name = "Community Registration Encounter" THEN 1 ELSE 0 END) AS "Offline Registration Count",
    SUM(CASE WHEN et.name = "REG" THEN 1 ELSE 0 END) + SUM(CASE WHEN et.name = "Community Registration Encounter" THEN 1 ELSE 0 END) AS "Total Registrations"
FROM
    encounter e
        INNER JOIN location l ON l.location_id = e.location_id
        INNER JOIN encounter_type et ON e.encounter_type = et.encounter_type_id
        LEFT JOIN (
        SELECT DISTINCT e.patient_id
        FROM encounter e
                 INNER JOIN encounter_type et ON e.encounter_type = et.encounter_type_id
        WHERE et.name = "REG"
    ) AS REG_patients ON e.patient_id = REG_patients.patient_id
WHERE
    (et.name = "REG" OR (et.name = "Community Registration Encounter" AND REG_patients.patient_id IS NULL))
GROUP BY l.name;
