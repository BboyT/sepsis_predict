WITH gcs_final AS
(
    SELECT
        gcs.*
        -- This sorts the data by GCS
        -- rn = 1 is the the lowest total GCS value
        , ROW_NUMBER () OVER
        (
            PARTITION BY gcs.patientunitstayid
            ORDER BY gcs.gcs
        ) as gcs_seq
    FROM pivoted_gcs gcs
)
SELECT
    ie.patientunitstayid
    -- The minimum GCS is determined by the above row partition
    -- we only join if gcs_seq = 1
    , gcs AS gcs_min
    , gcsmotor as gcs_motor
    , gcsverbal as gcs_verbal
    , gcseyes AS gcs_eyes

FROM sepsis ie
LEFT JOIN gcs_final gs
    ON ie.patientunitstayid = gs.patientunitstayid
    AND gs.gcs_seq = 1
;