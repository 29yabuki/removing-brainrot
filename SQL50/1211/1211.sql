WITH Expanded AS (
    SELECT
        query_name,
        rating::NUMERIC/NULLIF(position, 0) AS quality,
        CASE
            WHEN (rating < 3) THEN 1
            ELSE 0
        END AS poor
    FROM Queries
)
SELECT
    query_name,
    ROUND(AVG(quality), 2) AS quality,
    ROUND((SUM(poor)::NUMERIC/COUNT(*)) * 100, 2) AS poor_query_percentage
FROM Expanded
GROUP BY query_name