DROP MATERIALIZED VIEW IF EXISTS kdigo_uo CASCADE;
CREATE MATERIALIZED VIEW kdigo_uo AS
WITH ur_stg AS (
	SELECT
		io.patientunitstayid,
		io.chartoffset,
		SUM ( CASE WHEN io.chartoffset <= iosum.chartoffset + 300 THEN iosum.urineoutput ELSE NULL END ) AS UrineOutput_6hr -- 12 hours
		,
		SUM ( CASE WHEN io.chartoffset <= iosum.chartoffset + 660 THEN iosum.urineoutput ELSE NULL END ) AS UrineOutput_12hr -- 24 hours
		,
		SUM ( iosum.urineoutput ) AS UrineOutput_24hr -- calculate the number of hours over which we've tabulated UO
		,
		ROUND(
			CAST (
				(
					io.chartoffset - -- below MIN() gets the earliest time that was used in the summation
					MIN ( CASE WHEN io.chartoffset <= iosum.chartoffset + 300 THEN iosum.chartoffset ELSE NULL END ) -- convert from EPOCH (seconds) to MINUTEs by dividing by 60.0
						
					) / 60.0 AS NUMERIC 
				),
				4 
			) AS uo_tm_6hr -- repeat extraction for 12 hours and 24 hours
			,
			ROUND(
				CAST (
				( io.chartoffset - MIN ( CASE WHEN io.chartoffset <= iosum.chartoffset + 660 THEN iosum.chartoffset ELSE NULL END ) ) / 60.0 AS NUMERIC 
	),
	4 
	) AS uo_tm_12hr,
	ROUND( CAST ( ( io.chartoffset - MIN ( iosum.chartoffset ) ) / 60.0 AS NUMERIC ), 4 ) AS uo_tm_24hr 
FROM
	pivoted_uo io -- this join gives all UO measurements over the 24 hours preceding this row
	LEFT JOIN pivoted_uo iosum ON io.patientunitstayid = iosum.patientunitstayid 
	AND io.chartoffset >= iosum.chartoffset 
	AND io.chartoffset <= ( iosum.chartoffset + 1380 ) 
GROUP BY
	io.patientunitstayid,
	io.chartoffset 
	) SELECT
	ur.patientunitstayid,
	ur.chartoffset,
	wd.admissionweight,
	ur.UrineOutput_6hr,
	ur.UrineOutput_12hr,
	ur.UrineOutput_24hr -- calculate rates - adding 1 hour as we assume data charted at 10:00 corresponds to previous hour
	,
	ROUND( ( ur.UrineOutput_6hr / wd.admissionweight / ( uo_tm_6hr + 1 ) ) :: NUMERIC, 4 ) AS uo_rt_6hr,
	ROUND( ( ur.UrineOutput_12hr / wd.admissionweight / ( uo_tm_12hr + 1 ) ) :: NUMERIC, 4 ) AS uo_rt_12hr,
	ROUND( ( ur.UrineOutput_24hr / wd.admissionweight / ( uo_tm_24hr + 1 ) ) :: NUMERIC, 4 ) AS uo_rt_24hr -- time of earliest UO measurement that was used to calculate the rate
	,
	uo_tm_6hr,
	uo_tm_12hr,
	uo_tm_24hr 
FROM
	ur_stg ur
	LEFT JOIN icustay_detail wd ON ur.patientunitstayid = wd.patientunitstayid 
	AND ur.chartoffset >= 0 
	AND ur.chartoffset < wd.unitdischargeoffset 
WHERE
	wd.admissionweight IS NOT NULL 
	AND wd.admissionweight>0
ORDER BY
	patientunitstayid,
	chartoffset;