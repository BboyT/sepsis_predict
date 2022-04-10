DROP MATERIALIZED VIEW IF EXISTS kdigo_creat CASCADE;
CREATE MATERIALIZED VIEW kdigo_creat as
-- Extract all creatinine values from labevents around patient's ICU stay
with cr as
(
select
    pe.patientunitstayid
  , pe.unitdischargeoffset
  , le.labresult as creat
  , le.labresultoffset
  from patient pe
  left join lab le
    on pe.patientunitstayid = le.patientunitstayid
    and le.labname in ('creatinine')
    and le.labresult is not null
    and le.labresultoffset between -10080 and 10080
)
-- add in the lowest value in the previous 48 hours/7 days
SELECT
  cr.patientunitstayid
  , cr.labresultoffset
  , cr.creat
  , MIN(cr48.creat) AS creat_low_past_48hr
  , MIN(cr7.creat) AS creat_low_past_7day
FROM cr
-- add in all creatinine values in the last 48 hours
LEFT JOIN cr cr48
  ON cr.patientunitstayid = cr48.patientunitstayid
  AND cr48.labresultoffset <  cr.labresultoffset
  AND cr48.labresultoffset >= (cr.labresultoffset - 2880)
-- add in all creatinine values in the last 7 days hours
LEFT JOIN cr cr7
  ON cr.patientunitstayid = cr7.patientunitstayid
  AND cr7.labresultoffset <  cr.labresultoffset
  AND cr7.labresultoffset >= (cr.labresultoffset - 10080)
GROUP BY cr.patientunitstayid, cr.labresultoffset, cr.creat
ORDER BY cr.patientunitstayid, cr.labresultoffset, cr.creat;