select
u.name AS "Name",
address."City/Village" AS "Location",
DATE(encounter_date_time) AS "Attendance Date",
"Attendance Time"
from gok.center_attendance_form gaf
JOIN users u ON gaf.created_by_id = u.id
JOIN gok.address address ON gaf.address_id = address.id;


