with tp1 as (
SELECT antibiotic.*,ROW_NUMBER() over (partition by sepsis.patientunitstayid order by antibiotic ASC) as num FROM sepsis
left join antibiotic on antibiotic.patientunitstayid =  sepsis.patientunitstayid
--AND antibiotic.drugstartoffset > 0
AND antibiotic.drugstartoffset <= 1440
--AND sepsis.icu_los_hours > 24
and sepsis.patientunitstayid is not NULL

)
--,tp2 as (
SELECT DISTINCT tp2.patientunitstayid,antibiotic,num  from (
SELECT tp1.* , 
row_number() over(partition by patientunitstayid order by num DESC) as rwnum from tp1) tp2
 
WHERE  rwnum = 1

--) SELECT DISTINCT tp2.antibiotic FROM tp2 

--取最大次数