WITH concept_uuid AS (
    SELECT uuid
    FROM concept
    WHERE name = 'Attendance Time'
    LIMIT 1
)
SELECT
    u.username AS "User Name",
    CASE WHEN s.name = 'Center' THEN i.first_name ELSE NULL END AS "Center Name",
    TO_CHAR(e.encounter_date_time, 'DD-Mon-YYYY') AS "Attendance Date",
    CASE WHEN obs.key = cu.uuid THEN replace(obs.value::text, '"', '') ELSE NULL END AS "Attendance Time"
FROM encounter e
JOIN individual i ON e.individual_id = i.id
JOIN users u ON e.created_by_id = u.id
JOIN subject_type s ON i.subject_type_id = s.id
LEFT JOIN jsonb_each(e.observations) obs ON true
CROSS JOIN concept_uuid cu
WHERE obs.key = cu.uuid and cast(DATE(e.encounter_date_time) as date) BETWEEN '#startDate#' AND '#endDate#'
ORDER BY e.encounter_date_time DESC;