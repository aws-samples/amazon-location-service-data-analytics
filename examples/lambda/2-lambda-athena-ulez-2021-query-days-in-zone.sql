SELECT
  deviceid,
  meetsemissionstandards,
  MAX(purchasedate) AS purchasedate,
  MAX(mileage) AS mileage,
  DATE_DIFF('year', MAX(purchasedate), CURRENT_DATE) AS ageyears,
  COUNT(DISTINCT CASE WHEN insidezone THEN DATE(sampletime) END) AS distinct_days_inside_zone,
  MAX(mileage)/DATE_DIFF('year', MAX(purchasedate), CURRENT_DATE) AS mileageperyear
FROM "location-analytics-glue-database"."ulezvehicleanalysis_lambda"
WHERE meetsemissionstandards = false
GROUP BY deviceid, meetsemissionstandards
ORDER BY mileageperyear DESC