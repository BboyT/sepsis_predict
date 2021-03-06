DROP MATERIALIZED VIEW IF EXISTS basic_demographics CASCADE;
CREATE MATERIALIZED VIEW basic_demographics as
SELECT pt.patientunitstayid, pt.age, pt.apacheadmissiondx,
       CASE WHEN pt.gender = 'Male' THEN 1
            WHEN pt.gender = 'Female' THEN 2
            ELSE NULL END AS gender,
       CASE WHEN pt.hospitaldischargestatus = 'Alive' THEN 0
            WHEN pt.hospitaldischargestatus = 'Expired' THEN 1
            ELSE NULL END AS hosp_mortality,
       ROUND(pt.unitdischargeoffset/60) AS icu_los_hours
FROM patient pt
ORDER BY pt.patientunitstayid;