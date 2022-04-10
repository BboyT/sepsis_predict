SELECT DISTINCT pivoted_o2.patientunitstayid, 1 as vent
FROM sepsis 
LEFT JOIN pivoted_o2
ON sepsis.patientunitstayid = pivoted_o2.patientunitstayid
WHERE pivoted_o2.o2_device is not null and 
pivoted_o2.chartoffset BETWEEN 0 and 1440