DROP MATERIALIZED VIEW IF EXISTS kdigo_stages_1day;
CREATE MATERIALIZED VIEW kdigo_stages_1day AS
-- get the worst staging of creatinine in the first 48 hours
WITH cr_aki AS
(
  SELECT
    k.patientunitstayid
    , k.chartoffset
    , k.creat
    , k.aki_stage_creat
    , ROW_NUMBER() OVER (PARTITION BY k.patientunitstayid ORDER BY k.aki_stage_creat DESC, k.creat DESC) AS rn
  FROM patient pe
  INNER JOIN kdigo_stages k
    ON pe.patientunitstayid = k.patientunitstayid
  WHERE k.chartoffset > -360
  AND k.chartoffset <= 1440
  AND k.aki_stage_creat IS NOT NULL
)
-- get the worst staging of urine output in the first 48 hours
, uo_aki AS
(
  SELECT
    k.patientunitstayid
    , k.chartoffset
    , k.uo_rt_6hr, k.uo_rt_12hr, k.uo_rt_24hr
    , k.aki_stage_uo
    , ROW_NUMBER() OVER 
    (
      PARTITION BY k.patientunitstayid
      ORDER BY k.aki_stage_uo DESC, k.uo_rt_24hr DESC, k.uo_rt_12hr DESC, k.uo_rt_6hr DESC
    ) AS rn
  FROM patient pe
  INNER JOIN kdigo_stages k
    ON pe.patientunitstayid = k.patientunitstayid
  WHERE k.chartoffset > 360
  AND k.chartoffset <= 1440
  AND k.aki_stage_uo IS NOT NULL
)
-- final table is aki_stage, include worst cr/uo for convenience
select
    pe.patientunitstayid
  , cr.chartoffset as charttime_creat
  , cr.creat
  , cr.aki_stage_creat
  , uo.chartoffset as charttime_uo
  , uo.uo_rt_6hr
  , uo.uo_rt_12hr
  , uo.uo_rt_24hr
  , uo.aki_stage_uo

  -- Classify AKI using both creatinine/urine output criteria
  , GREATEST(cr.aki_stage_creat,uo.aki_stage_uo) AS aki_stage_day
  , CASE WHEN GREATEST(cr.aki_stage_creat, uo.aki_stage_uo) > 0 THEN 1 ELSE 0 END AS aki_day

FROM patient pe
LEFT JOIN cr_aki cr
  ON pe.patientunitstayid = cr.patientunitstayid
  AND cr.rn = 1
LEFT JOIN uo_aki uo
  ON pe.patientunitstayid = uo.patientunitstayid
  AND uo.rn = 1
order by pe.patientunitstayid;