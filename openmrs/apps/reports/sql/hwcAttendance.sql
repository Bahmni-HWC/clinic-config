select
u.name AS "User Name",
center_name.first_name AS "Center Name",
DATE(encounter_date_time) AS "Attendance Date",
"Attendance Time"
from gok.center_attendance_form gaf
JOIN users u ON gaf.created_by_id = u.id
JOIN gok.center center_name ON gaf.individual_id = center_name.id
where cast(DATE(encounter_date_time) as date) BETWEEN '#startDate#' AND '#endDate#'; 


