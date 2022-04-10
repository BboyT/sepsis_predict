SELECT kdigo_stages_1day.patientunitstayid,kdigo_stages_1day.aki_stage_day
FROM sepsis 
LEFT JOIN kdigo_stages_1day
on kdigo_stages_1day.patientunitstayid = sepsis.patientunitstayid