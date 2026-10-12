WITH campaign_stats AS (
    SELECT
        ad_campaign,
        CAST(impression_time AS DATE) AS impression_date,
        COUNT(*) AS daily_impressions
    FROM ad_impressions
    GROUP BY
        ad_campaign,
        CAST(impression_time AS DATE)
),
campaign_boundaries AS (
    SELECT
        ad_campaign,
        impression_date,
        daily_impressions,
        SUM(daily_impressions) OVER (
            PARTITION BY ad_campaign
        ) AS total_impressions,
        MIN(impression_date) OVER (
            PARTITION BY ad_campaign
        ) AS first_day,
        MAX(impression_date) OVER (
            PARTITION BY ad_campaign
        ) AS last_day
    FROM campaign_stats
)
SELECT
    ad_campaign,
    ROUND(
        100.0 * SUM(
            CASE WHEN impression_date = first_day
                 THEN daily_impressions ELSE 0 END
        ) / MAX(total_impressions),
        3
    ) AS first_day_pct,
    ROUND(
        100.0 * SUM(
            CASE WHEN impression_date = last_day
                 THEN daily_impressions ELSE 0 END
        ) / MAX(total_impressions),
        3
    ) AS last_day_pct
FROM campaign_boundaries
GROUP BY ad_campaign
ORDER BY ad_campaign;
