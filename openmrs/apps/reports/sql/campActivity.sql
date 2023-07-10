select 
first_name AS "Activity Name",
"Activity Type",
"Activity Date",
"Activity Description",
concat(address."State",', ',address."District",', ',address."Sub District",', ',address."City/Village") AS "Address",
u.name AS "Added By",
registration_location AS "GPS Coordinates" 
from gok.camp_activity ca
join gok.address address on ca.address_id = address.id
join public.users u on ca.created_by_id = u.id
where cast("Activity Date" as date) BETWEEN '#startDate#' AND '#endDate#'; 
