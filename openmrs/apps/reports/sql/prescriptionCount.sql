
SELECT CONCAT_WS(' ', pn.given_name, pn.middle_name, pn.family_name) AS Provider,
       COUNT(DISTINCT o.encounter_id) AS "Prescription Count"
FROM orders o
    JOIN provider p ON o.orderer = p.provider_id
    JOIN person ON p.person_id = person.person_id
    JOIN person_name pn ON person.person_id = pn.person_id
    JOIN order_type ot ON o.order_type_id = ot.order_type_id
    WHERE ot.name = 'Drug Order'
        AND cast(DATE(o.date_created) AS DATE) BETWEEN '#startDate#' AND '#endDate#'
GROUP BY Provider;