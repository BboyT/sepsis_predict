SELECT
	pivoted_vital.patientunitstayid,
	MIN ( CASE WHEN heartrate > 0 AND heartrate < 300 THEN heartrate ELSE NULL END ) AS heartrate_min,
	MAX ( CASE WHEN heartrate > 0 AND heartrate < 300 THEN heartrate ELSE NULL END ) AS heartrate_max,
	avg ( CASE WHEN heartrate > 0 AND heartrate < 300 THEN heartrate ELSE NULL END ) AS heartrate_mean,
	
	MIN ( CASE WHEN nibp_systolic > 0 AND nibp_systolic < 400 THEN nibp_systolic ELSE NULL END ) AS SysBP_Min,
	MAX ( CASE WHEN nibp_systolic > 0 AND nibp_systolic < 400 THEN nibp_systolic ELSE NULL END ) AS SysBP_max,
	avg ( CASE WHEN nibp_systolic > 0 AND nibp_systolic < 400 THEN nibp_systolic ELSE NULL END ) AS SysBP_Mean,
	
	MIN ( CASE WHEN nibp_diastolic > 0 AND nibp_diastolic < 300 THEN nibp_diastolic ELSE NULL END ) AS DiasBP_min,
	MAX ( CASE WHEN nibp_diastolic > 0 AND nibp_diastolic < 300 THEN nibp_diastolic ELSE NULL END ) AS DiasBP_Max,
	avg ( CASE WHEN nibp_diastolic > 0 AND nibp_diastolic < 300 THEN nibp_diastolic ELSE NULL END ) AS DiasBP_Mean,
	
	MIN ( CASE WHEN nibp_mean > 0 AND nibp_mean < 300 THEN nibp_mean ELSE NULL END ) AS MeanBP_Min,
	MAX ( CASE WHEN nibp_mean > 0 AND nibp_mean < 300 THEN nibp_mean ELSE NULL END ) AS MeanBP_Max,
	avg ( CASE WHEN nibp_mean > 0 AND nibp_mean < 300 THEN nibp_mean ELSE NULL END ) AS MeanBP_Mean,
	
	MIN ( CASE WHEN respiratoryrate > 0 AND respiratoryrate < 70 THEN respiratoryrate ELSE NULL END ) AS resprate_min,
	MAX ( CASE WHEN respiratoryrate > 0 AND respiratoryrate < 70 THEN respiratoryrate ELSE NULL END ) AS resprate_max,
	avg ( CASE WHEN respiratoryrate > 0 AND respiratoryrate < 70 THEN respiratoryrate ELSE NULL END ) AS resprate_mean,
	
	MIN ( CASE WHEN temperature > 10 AND temperature < 50 THEN temperature ELSE NULL END ) AS TempC_Min,
	MAX ( CASE WHEN temperature > 10 AND temperature < 50 THEN temperature ELSE NULL END ) AS TempC_Max,
	avg ( CASE WHEN temperature > 10 AND temperature < 50 THEN temperature ELSE NULL END ) AS TempC_Mean,
	MIN ( CASE WHEN spo2 > 0 AND spo2 <= 100 THEN spo2 ELSE NULL END ) AS spo2_min,
	MAX ( CASE WHEN spo2 > 0 AND spo2 <= 100 THEN spo2 ELSE NULL END ) AS spo2_max,
	avg ( CASE WHEN spo2 > 0 AND spo2 <= 100 THEN spo2 ELSE NULL END ) AS spo2_mean
FROM

	sepsis
	LEFT JOIN pivoted_vital ON pivoted_vital.patientunitstayid = sepsis.patientunitstayid 
WHERE
	pivoted_vital.chartoffset BETWEEN 8640 AND 10080
GROUP BY
	pivoted_vital.patientunitstayid 
ORDER BY
	pivoted_vital.patientunitstayid