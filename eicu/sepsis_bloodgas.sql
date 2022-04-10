SELECT pivoted_bg.patientunitstayid
, MIN(ph) AS ph_min, MAX(ph) AS ph_max
--, MIN(fio2) AS fio2_min, MAX(fio2) AS fio2_max
, MIN(pao2) AS po2_min, MAX(pao2) AS po2_max
, MIN(paco2) AS pco2_min, MAX(paco2) AS pco2_max
, MIN(aniongap) AS aniongap_min, MAX(aniongap) AS aniongap_max
--, MIN(basedeficit) AS basedeficit_min, MAX(basedeficit) AS basedeficit_max
, MIN(baseexcess) AS baseexcess_min, MAX(baseexcess) AS baseexcess_max
   
FROM sepsis
LEFT JOIN pivoted_bg ON sepsis.patientunitstayid = pivoted_bg.patientunitstayid
WHERE pivoted_bg.chartoffset BETWEEN 0 and 1440
group by pivoted_bg.patientunitstayid