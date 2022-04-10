SELECT DISTINCT
	pivoted_treatment_vasopressor.patientunitstayid,
	SUM ( pivoted_treatment_vasopressor.vasopressor ) AS vasonum 
FROM
	sepsis
	LEFT JOIN pivoted_treatment_vasopressor ON sepsis.patientunitstayid = pivoted_treatment_vasopressor.patientunitstayid 
WHERE
	pivoted_treatment_vasopressor.patientunitstayid IS NOT NULL 
	AND chartoffset BETWEEN 0	AND 1440
GROUP BY
	pivoted_treatment_vasopressor.patientunitstayid 
ORDER BY
	pivoted_treatment_vasopressor.patientunitstayid