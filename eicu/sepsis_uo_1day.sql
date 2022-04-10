SELECT
	sepsis.patientunitstayid,
	SUM ( CASE WHEN urineoutput > 0 THEN urineoutput ELSE urineoutput END ) AS urineoutput 
FROM
	sepsis
	LEFT JOIN pivoted_uo ON sepsis.patientunitstayid = pivoted_uo.patientunitstayid 
WHERE pivoted_uo.chartoffset BETWEEN 0 and 1440
GROUP BY
	sepsis.patientunitstayid 
ORDER BY
	sepsis.patientunitstayid