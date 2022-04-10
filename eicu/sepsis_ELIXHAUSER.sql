SELECT ELIXHAUSER_AHRQ.* FROM sepsis 
LEFT JOIN ELIXHAUSER_AHRQ
ON ELIXHAUSER_AHRQ.patientunitstayid = sepsis.patientunitstayid