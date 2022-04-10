SELECT
	sepsis.patientunitstayid,
	MIN ( CASE WHEN heartrate > 0 AND heartrate < 300 THEN heartrate ELSE NULL END ) AS heart_rate_min,
	MAX ( CASE WHEN heartrate > 0 AND heartrate < 300 THEN heartrate ELSE NULL END ) AS heart_rate_max,
	avg ( CASE WHEN heartrate > 0 AND heartrate < 300 THEN heartrate ELSE NULL END ) AS heart_rate_mean,
	
	MIN ( CASE WHEN nibp_systolic > 0 AND nibp_systolic < 400 THEN nibp_systolic ELSE NULL END ) AS SBP_Min,
	MAX ( CASE WHEN nibp_systolic > 0 AND nibp_systolic < 400 THEN nibp_systolic ELSE NULL END ) AS SBP_max,
	avg ( CASE WHEN nibp_systolic > 0 AND nibp_systolic < 400 THEN nibp_systolic ELSE NULL END ) AS SBP_Mean,
	
	MIN ( CASE WHEN nibp_diastolic > 0 AND nibp_diastolic < 300 THEN nibp_diastolic ELSE NULL END ) AS dbp_min,
	MAX ( CASE WHEN nibp_diastolic > 0 AND nibp_diastolic < 300 THEN nibp_diastolic ELSE NULL END ) AS dbp_Max,
	avg ( CASE WHEN nibp_diastolic > 0 AND nibp_diastolic < 300 THEN nibp_diastolic ELSE NULL END ) AS dbp_Mean,
	
	MIN ( CASE WHEN nibp_mean > 0 AND nibp_mean < 300 THEN nibp_mean ELSE NULL END ) AS mbp_Min,
	MAX ( CASE WHEN nibp_mean > 0 AND nibp_mean < 300 THEN nibp_mean ELSE NULL END ) AS mbp_Max,
	avg ( CASE WHEN nibp_mean > 0 AND nibp_mean < 300 THEN nibp_mean ELSE NULL END ) AS mbp_Mean,
	
	MIN ( CASE WHEN respiratoryrate > 0 AND respiratoryrate < 70 THEN respiratoryrate ELSE NULL END ) AS resp_rate_min,
	MAX ( CASE WHEN respiratoryrate > 0 AND respiratoryrate < 70 THEN respiratoryrate ELSE NULL END ) AS resp_rate_max,
	avg ( CASE WHEN respiratoryrate > 0 AND respiratoryrate < 70 THEN respiratoryrate ELSE NULL END ) AS resp_rate_mean,
	
	MIN ( CASE WHEN temperature > 10 AND temperature < 50 THEN temperature ELSE NULL END ) AS temperature_min,
	MAX ( CASE WHEN temperature > 10 AND temperature < 50 THEN temperature ELSE NULL END ) AS temperature_Max,
	avg ( CASE WHEN temperature > 10 AND temperature < 50 THEN temperature ELSE NULL END ) AS temperature_Mean,
	MIN ( CASE WHEN spo2 > 0 AND spo2 <= 100 THEN spo2 ELSE NULL END ) AS spo2_min,
	MAX ( CASE WHEN spo2 > 0 AND spo2 <= 100 THEN spo2 ELSE NULL END ) AS spo2_max,
	avg ( CASE WHEN spo2 > 0 AND spo2 <= 100 THEN spo2 ELSE NULL END ) AS spo2_mean
FROM

	sepsis
	LEFT JOIN pivoted_vital ON pivoted_vital.patientunitstayid = sepsis.patientunitstayid 
WHERE
	pivoted_vital.chartoffset BETWEEN 0 AND 1440
	and sepsis.patientunitstayid is not null 
GROUP BY
	sepsis.patientunitstayid 
ORDER BY
	sepsis.patientunitstayid