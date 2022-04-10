--纳入sepsis诊断患者
--unitvisitnumber <= 1
--excluded < 18years old 
--in ICU > 24 hours

DROP MATERIALIZED VIEW IF EXISTS SEPSIS CASCADE;
CREATE MATERIALIZED VIEW SEPSIS AS
WITH vd1 AS (
	SELECT
		patientunitstayid,
		diagnosisoffset,
		diagnosisstring,
		ROW_NUMBER ( ) OVER ( PARTITION BY patientunitstayid ORDER BY diagnosisoffset ) AS srn 
	FROM
		diagnosis 
	WHERE
		(diagnosisstring LIKE'surgery|infections|septic shock|organism identified' OR 
		diagnosisstring LIKE'surgery|infections|septic shock' or 
		diagnosisstring LIKE'surgery|infections|sepsis|severe' OR 
		diagnosisstring LIKE'surgery|infections|sepsis|sepsis with multi-organ dysfunction syndrome' or 
		diagnosisstring LIKE'surgery|infections|sepsis' OR  
		diagnosisstring LIKE'infectious diseases|systemic/other infections|septic shock|organism identified' or 
		diagnosisstring LIKE'infectious diseases|systemic/other infections|septic shock|gram positive organism' OR 
		diagnosisstring LIKE'infectious diseases|systemic/other infections|septic shock|gram negative organism' or 
		diagnosisstring LIKE'infectious diseases|systemic/other infections|septic shock|fungal' OR 
		diagnosisstring LIKE'infectious diseases|systemic/other infections|septic shock' or 
		diagnosisstring LIKE'infectious diseases|systemic/other infections|sepsis|severe' OR 
		diagnosisstring LIKE'infectious diseases|systemic/other infections|sepsis|sepsis with multi-organ dysfunction syndrome' or 
		diagnosisstring LIKE'infectious diseases|systemic/other infections|sepsis' OR 
		diagnosisstring LIKE'hematology|coagulation disorders|DIC syndrome|associated with sepsis/septic shock' or 
		diagnosisstring LIKE'cardiovascular|shock / hypotension|septic shock|organism identified|gram positive organism' or 
		diagnosisstring LIKE'cardiovascular|shock / hypotension|septic shock|organism identified|gram negative organism' OR 
		diagnosisstring LIKE'cardiovascular|shock / hypotension|septic shock|organism identified|fungal' or 
		diagnosisstring LIKE'cardiovascular|shock / hypotension|septic shock|organism identified' OR 
		diagnosisstring LIKE'cardiovascular|shock / hypotension|septic shock' or 
		diagnosisstring LIKE'cardiovascular|shock / hypotension|sepsis|severe' OR 
		diagnosisstring LIKE'cardiovascular|shock / hypotension|sepsis|sepsis with multi-organ dysfunction' or 
		diagnosisstring LIKE'cardiovascular|shock / hypotension|sepsis' )
		and diagnosisoffset <=  1440
		and diagnosispriority like 'Primary'
	GROUP BY
		patientunitstayid,
		diagnosisoffset,
		diagnosisstring 
	ORDER BY
		patientunitstayid 
	),
	vd3 AS ( SELECT vd1.patientunitstayid, diagnosisstring,1 AS sepsis FROM vd1 WHERE srn = 1 ORDER BY patientunitstayid ),
vd4 AS ( SELECT  icustay_detail.*,
sofa.sofatotal,
kdigo_stages_1day.aki_day
FROM vd3
LEFT JOIN icustay_detail ON vd3.patientunitstayid = icustay_detail.patientunitstayid
LEFT JOIN sofa ON vd3.patientunitstayid = sofa.patientunitstayid
LEFT JOIN kdigo_stages_1day on kdigo_stages_1day.patientunitstayid = vd3.patientunitstayid
WHERE icustay_detail.age not like '>%'
ORDER BY patientunitstayid
),
vd5 as ( SELECT vd4.*,
case when CAST (age as int4) <18 then 0 else 1 end as isadult 
FROM vd4 ),
vd6 as (
SELECT  icustay_detail.*,
sofa.sofatotal,kdigo_stages_1day.aki_day,
1 as isadult 
FROM vd3
LEFT JOIN icustay_detail ON vd3.patientunitstayid = icustay_detail.patientunitstayid
LEFT JOIN sofa ON vd3.patientunitstayid = sofa.patientunitstayid
LEFT JOIN kdigo_stages_1day on kdigo_stages_1day.patientunitstayid = vd3.patientunitstayid
WHERE   icustay_detail.age like '>%'
ORDER BY patientunitstayid),
vd7 as (SELECT * FROM vd5
union 
SELECT * FROM vd6)
SELECT  distinct vd7.* FROM vd7
--LEFT JOIN sepsis_infection on sepsis_infection.patientunitstayid = vd7.patientunitstayid
where isadult = 1
AND sofatotal >= 2 
AND unitvisitnumber = 1
and unitdischargeoffset > 1440
--and sepsis_infection.sepsis =1 
--and sepsis_infection.infection = 1