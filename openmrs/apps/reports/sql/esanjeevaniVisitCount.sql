SELECT
    SUBSTRING_INDEX(SUBSTRING_INDEX(message, ' ', 2),' ',-1)    AS Username,
    count(*)                                                    AS 'Number of eSanjeevani Consultations'
FROM
    audit_log
    WHERE
        CAST(
                CONVERT_TZ
                (
                    date_created, '+00:00', '+5:30'
                )
            AS DATE
        )
        BETWEEN '#startDate#' AND '#endDate#'
        AND event_type LIKE '%ACCESSED_E_SANJEEVANI%'
    GROUP BY Username;
