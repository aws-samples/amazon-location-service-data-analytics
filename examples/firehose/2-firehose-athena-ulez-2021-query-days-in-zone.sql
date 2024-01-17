SELECT
  deviceid,
  COUNT(DISTINCT DATE(sampletime)) AS totaldaysinsidezone,
  COUNT(DISTINCT DATE(sampletime)) * ? AS totalcharges
FROM "location-analytics-glue-database"."ulezvehicleanalysis_firehose"
WHERE insidezone = true
GROUP BY deviceid