SELECT
	ind.first_name AS "Activity Name",
    c1.name AS "Activity Type",
    CAST(ind.observations ->> '2d769525-e4b4-4ba7-9253-9d071b83f115' AS TIMESTAMP) AS "Activity Date",
    ind.observations ->> '228cd385-cdf3-46cf-82d5-81a8dc948f86' AS "Activity Description",
	u.username AS "Added By",
	al.title AS "Address",
	ind.registration_location AS "GPS Coordinates"
FROM
	individual ind
	LEFT OUTER JOIN concept c1 ON ind.observations ->> '32d31209-1888-42d4-8d7b-e3770e9e3d6e' = c1.uuid
JOIN users u ON ind.created_by_id = u.id
	LEFT OUTER JOIN address_level al ON ind.address_id = al.id
WHERE
	ind.subject_type_id = 3 and cast( ind.observations ->> '2d769525-e4b4-4ba7-9253-9d071b83f115'  as date ) BETWEEN '#startDate#' AND '#endDate#';