SELECT
    u.username                                                      AS 'User',
    CONCAT_WS(' ', pn.given_name, pn.middle_name, pn.family_name)   AS 'Name',
    COUNT(a.event_type)                                             AS 'Number of times E-Sanjeevani Portal was Accessed'
FROM
    audit_log a
    INNER JOIN users u ON u.user_id = a.user_id
    INNER JOIN person p ON p.person_id = u.person_id
    INNER JOIN person_name pn ON pn.person_id = p.person_id
    WHERE 
        CAST(
                CONVERT_TZ
                (
                    a.date_created, '+00:00', '+5:30'
                ) 
            AS DATE
        ) 
        BETWEEN '#startDate#' AND '#endDate#'
        AND a.event_type LIKE '%ACCESSED_E_SANJEEVANI%'
    GROUP BY u.username;