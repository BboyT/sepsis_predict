SELECT calciumfirstday.*
FROM sepsis 
LEFT JOIN calciumfirstday 
ON calciumfirstday.patientunitstayid = sepsis.patientunitstayid AND calciumfirstday.uniquepid = sepsis.uniquepid 
AND calciumfirstday.patienthealthsystemstayid = sepsis.patienthealthsystemstayid