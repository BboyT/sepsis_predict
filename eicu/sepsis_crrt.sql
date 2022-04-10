SELECT DISTINCT sepsis.patientunitstayid, 1 as crrt FROM sepsis
LEFT JOIN dialysis on dialysis.patientunitstayid  = sepsis.patientunitstayid
WHERE dialysis  = 1 or dialysis.chronic_dialysis = 1
and sepsis.patientunitstayid is not null 