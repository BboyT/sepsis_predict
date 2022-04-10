DROP MATERIALIZED VIEW IF EXISTS calciumfirstday CASCADE;
CREATE materialized VIEW calciumfirstday AS
SELECT
  pvt.uniquepid, pvt.patienthealthsystemstayid, pvt.patientunitstayid
  , min(CASE WHEN labname = 'calcium' THEN labresult ELSE null END) as calcium_min
  , max(CASE WHEN labname = 'calcium' THEN labresult ELSE null END) as calcium_max

FROM
( -- begin query that extracts the data
  SELECT p.uniquepid, p.patienthealthsystemstayid, p.patientunitstayid, le.labname

  -- add in some sanity checks on the values; same checks from original MIMIC version
  -- the where clause below requires all labresult to be > 0, so these are only upper limit checks
  , CASE
     WHEN labname = 'calcium' and le.labresult >    10 THEN null -- 

   ELSE le.labresult
   END AS labresult

  FROM patient p

  LEFT JOIN lab le
    ON p.patientunitstayid = le.patientunitstayid
    AND le.labresultoffset BETWEEN 0 and 1440
		--AND le.labresultoffset BETWEEN (p.unitdischargeoffset - 1440) and p.unitdischargeoffset
    AND le.labname in
    (
    	'calcium'
    )
    AND labresult IS NOT null AND labresult > 0 -- lab values cannot be 0 and cannot be negative
) pvt
GROUP BY pvt.uniquepid, pvt.patienthealthsystemstayid, pvt.patientunitstayid
ORDER BY pvt.uniquepid, pvt.patienthealthsystemstayid, pvt.patientunitstayid;