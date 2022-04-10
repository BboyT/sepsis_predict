SELECT labsfirstday.*
FROM sepsis 
LEFT JOIN labsfirstday 
ON labsfirstday.patientunitstayid = sepsis.patientunitstayid AND labsfirstday.uniquepid = sepsis.uniquepid 
AND labsfirstday.patienthealthsystemstayid = sepsis.patienthealthsystemstayid