DROP MATERIALIZED VIEW IF EXISTS ELIXHAUSER_AHRQ CASCADE;
CREATE MATERIALIZED VIEW ELIXHAUSER_AHRQ as
with 
icd as (
SELECT diagnosis.patientunitstayid,
CASE 
 WHEN icd9code like '398.91%' then 1
 WHEN icd9code like '428.0%' then 1
 WHEN icd9code like '428.1%' then 1
 WHEN icd9code like '428.2%' then 1
 WHEN icd9code like '428.3%' then 1
 WHEN icd9code like '428.4%' then 1
 WHEN icd9code like '428.5%' then 1
 WHEN icd9code like '428.6%' then 1
 WHEN icd9code like '428.7%' then 1
 WHEN icd9code like '428.8%' then 1
 WHEN icd9code like '428.9%' then 1
 else 0 END AS CHF, 
 
CASE  
	WHEN icd9code like '426.%' THEN 1
	WHEN icd9code like '427.%' THEN 1
	WHEN icd9code like 'V45.00%' THEN 1
	WHEN icd9code like 'V45.01%' THEN 1
	WHEN icd9code like 'V45.02%' THEN 1
	WHEN icd9code like 'V45.09%' THEN 1
	WHEN icd9code like 'V53.3%' THEN 1
else 0 END AS cardiac_arrhythmias, /* Cardiac arrhythmias */

CASE 
  WHEN icd9code like '093.20%' THEN 1
	WHEN icd9code like '093.24%' THEN 1
	WHEN icd9code like '394%' THEN 1
	WHEN icd9code like '395%' THEN 1
	WHEN icd9code like '396%' THEN 1
	WHEN icd9code like '397%' THEN 1
	WHEN icd9code like '424%' THEN 1
	WHEN icd9code like '746.3%' THEN 1
	WHEN icd9code like '746.4%' THEN 1
	WHEN icd9code like '746.5%' THEN 1
	WHEN icd9code like '746.6%' THEN 1
	WHEN icd9code like 'V42.2%' THEN 1
	WHEN icd9code like 'V43.3%' THEN 1
ELSE 0 END as valvular_disease,

case 
  WHEN icd9code like '415.1%' THEN 1
	WHEN icd9code like '416%' THEN 1
	WHEN icd9code like '417.9%' THEN 1
ELSE 0 end as pulmonary_circulation ,

CASE 
 WHEN icd9code like '440%' THEN 1 
 WHEN icd9code like '441%' THEN 1 
 WHEN icd9code like '442%' THEN 1 
 WHEN icd9code like '443%' THEN 1 
 WHEN icd9code like '444.21%' THEN 1 
 WHEN icd9code like '444.22%' THEN 1 
 WHEN icd9code like '447.1%' THEN 1 
 WHEN icd9code like '449%' THEN 1 
 WHEN icd9code like '557.1%' THEN 1 
 WHEN icd9code like '557.9%' THEN 1 
 WHEN icd9code like 'V43.4%' THEN 1 
else 0 end as PERIPHERAL_VASCULAR ,
CASE
  WHEN icd9code like '401.1%' THEN 1 
	WHEN icd9code like '401.9%' THEN 1 
	WHEN icd9code like '401.0%' THEN 1 
	WHEN icd9code like '437.2%' THEN 1 
	WHEN icd9code like '642.00%' THEN 1 
	WHEN icd9code like '642.04%' THEN 1
	WHEN icd9code like '642.2%' THEN 1
	WHEN icd9code like '402.00%' THEN 1
	WHEN icd9code like '402.10%' THEN 1
	WHEN icd9code like '402.90%' THEN 1
	WHEN icd9code like '405.09%' THEN 1
	WHEN icd9code like '405.19%' THEN 1
	WHEN icd9code like '405.99%' THEN 1
	
	WHEN icd9code like '402.01%' THEN 1 /* Hypertensive heart disease with heart failure */
	WHEN icd9code like '402.11%' THEN 1
	WHEN icd9code like '402.91%' THEN 1
	
	WHEN icd9code like '403.00%' THEN 1
	WHEN icd9code like '403.10%' THEN 1
	WHEN icd9code like '403.90%' THEN 1
	WHEN icd9code like '405.01%' THEN 1
	WHEN icd9code like '405.11%' THEN 1
	WHEN icd9code like '405.91%' THEN 1
	WHEN icd9code like '642.1%' THEN 1
	
	WHEN icd9code like '403.01%' THEN 1
	WHEN icd9code like '403.11%' THEN 1	
	WHEN icd9code like '403.91%' THEN 1/* Hypertensive renal disease with renal failure */
	
	WHEN icd9code like '404.10%' THEN 1
	WHEN icd9code like '404.00%' THEN 1	
	WHEN icd9code like '404.90%' THEN 1/* Hypertensive heart and renal disease without heart or renal failure */
	
	WHEN icd9code like '404.01%' THEN 1
	WHEN icd9code like '404.11%' THEN 1	
	WHEN icd9code like '404.91%' THEN 1/* Hypertensive heart and renal disease with heart failure */
	
	
	
	WHEN icd9code like '404.02%' THEN 1
	WHEN icd9code like '404.12%' THEN 1
	WHEN icd9code like '404.92%' THEN 1/* Hypertensive heart and renal disease with renal failure */
	WHEN icd9code like '404.03%' THEN 1
	WHEN icd9code like '404.13%' THEN 1
	WHEN icd9code like '404.93%' THEN 1/* Hypertensive heart and renal disease with heart and renal failure */
	WHEN icd9code like '642.7%' THEN 1
	WHEN icd9code like '642.9%' THEN 1
ELSE 0 END as hypertension ,

CASE 
   WHEN icd9code like '342%' THEN 1 
	 WHEN icd9code like '343%' THEN 1 
	 WHEN icd9code like '344%' THEN 1 
	 WHEN icd9code like '438.2%' THEN 1 
	 WHEN icd9code like '438.3%' THEN 1
	 WHEN icd9code like '438.4%' THEN 1
	 WHEN icd9code like '438.5%' THEN 1
	 WHEN icd9code like '78072%' THEN 1
ELSE 0 END AS paralysis ,

CASE 
 WHEN icd9code like '330.%' THEN 1 
 WHEN icd9code like '331.%' THEN 1 
 WHEN icd9code like '332.0%' THEN 1 
 WHEN icd9code like '333.4%' THEN 1 
 WHEN icd9code like '333.5%' THEN 1
 WHEN icd9code like '333.7%' THEN 1 
 WHEN icd9code like '333.71%' THEN 1 
 WHEN icd9code like '333.72%' THEN 1
 WHEN icd9code like '333.79%' THEN 1 
 WHEN icd9code like '333.85%' THEN 1
 WHEN icd9code like '333.94%' THEN 1 
 WHEN icd9code like '334%' THEN 1
 WHEN icd9code like '335%' THEN 1 
 WHEN icd9code like '338.0%' THEN 1
 WHEN icd9code like '341.1%' THEN 1 
 WHEN icd9code like '340%' THEN 1
 WHEN icd9code like '341.%' THEN 1 
 WHEN icd9code like '345.%' THEN 1
 WHEN icd9code like '348.3%' THEN 1
 WHEN icd9code like '347.11%' THEN 1
 WHEN icd9code like '347.10%' THEN 1
 WHEN icd9code like '649.4%' THEN 1
 WHEN icd9code like '768.7%' THEN 1
 WHEN icd9code like '780.3%' THEN 1
 WHEN icd9code like '780.31%' THEN 1
 WHEN icd9code like '780.32%' THEN 1
 WHEN icd9code like '780.33%' THEN 1
 WHEN icd9code like '780.39%' THEN 1
 WHEN icd9code like '780.97%' THEN 1
 WHEN icd9code like '784.3%' THEN 1
else 0 END AS other_neurological,

case
  when icd9code like '490%' then 1
	when icd9code like '491%' then 1
	when icd9code like '492%' then 1
	when icd9code like '493.%' then 1
	when icd9code like '494%' then 1
	when icd9code like '495%' then 1
	when icd9code like '496%' then 1
	when icd9code like '497%' then 1
	when icd9code like '498%' then 1
	when icd9code like '499%' then 1
	when icd9code like '500%' then 1
	when icd9code like '501%' then 1
	when icd9code like '502%' then 1
	when icd9code like '503%' then 1
	when icd9code like '504%' then 1
	when icd9code like '505%' then 1
	when icd9code like '506.4%' then 1
ELSE 0 END as chronic_pulmonary ,
CASE 
  when icd9code like '250.0%' THEN 1
  when icd9code like '250.1%' THEN 1
  when icd9code like '250.2%' THEN 1
  when icd9code like '250.3%' THEN 1	
	when icd9code like '648.0%' THEN 1
	when icd9code like '249.0%' THEN 1
	when icd9code like '249.1%' THEN 1
	when icd9code like '249.2%' THEN 1
	when icd9code like '249.30%' THEN 1
  when icd9code like '249.31%' THEN 1
ELSE 0 END as diabetes_uncomplicated,

CASE 
  when icd9code like '250.4%' THEN 1
  WHEN icd9code like '250.5%' THEN 1
	WHEN icd9code like '250.6%' THEN 1
	WHEN icd9code like '250.7%' THEN 1
	WHEN icd9code like '250.8%' THEN 1
	WHEN icd9code like '250.9%' THEN 1
	WHEN icd9code like '775.1%' THEN 1
	WHEN icd9code like '249.4%' THEN 1
	WHEN icd9code like '249.5%' THEN 1
	WHEN icd9code like '249.6%' THEN 1
	WHEN icd9code like '249.7%' THEN 1
	WHEN icd9code like '249.8%' THEN 1
	WHEN icd9code like '249.9%' THEN 1
ELSE 0 END as diabetes_complicated,

case 
  when icd9code like '243%' THEN 1
	when icd9code like '244.0%' THEN 1
	when icd9code like '244.1%' THEN 1
	when icd9code like '244.2%' THEN 1
	when icd9code like '244.8%' THEN 1
	when icd9code like '244.9%' THEN 1
else 0 end as hypothyroidism,

CASE 
 WHEN icd9code like '585%' THEN 1
 WHEN icd9code like '585.3%' then 1
 WHEN icd9code like '585.4%' then 1
 WHEN icd9code like '585.5%' then 1
 WHEN icd9code like '585.6%' then 1
 WHEN icd9code like '585.9%' then 1
 WHEN icd9code like '586%' then 1
 WHEN icd9code like 'V42.0%' then 1
 WHEN icd9code like 'V45.1%' then 1
 WHEN icd9code like 'V56.0%' then 1
 WHEN icd9code like 'V56.1%' then 1
 WHEN icd9code like 'V56.2%' then 1
 WHEN icd9code like 'V56.3%' then 1
 WHEN icd9code like 'V56.8%' then 1
 WHEN icd9code like 'V45.11%' then 1
 WHEN icd9code like 'V45.12%' then 1
 
 WHEN icd9code like '404.02%' THEN 1
	WHEN icd9code like '404.12%' THEN 1
	WHEN icd9code like '404.92%' THEN 1/* Hypertensive heart and renal disease with renal failure */
	WHEN icd9code like '404.03%' THEN 1
	WHEN icd9code like '404.13%' THEN 1
	WHEN icd9code like '404.93%' THEN 1/* Hypertensive heart and renal disease with heart and renal failure */
ELSE 0 END as renal_failure,

CASE 
  WHEN icd9code like '070.22%' THEN 1 
	WHEN icd9code like '070.23%' THEN 1
	WHEN icd9code like '070.32%' THEN 1
	WHEN icd9code like '070.44%' THEN 1
	WHEN icd9code like '070.54%' THEN 1
	WHEN icd9code like '456.0%' THEN 1
	WHEN icd9code like '456.1%' THEN 1
	WHEN icd9code like '456.20%' THEN 1
	WHEN icd9code like '456.21%' THEN 1
	WHEN icd9code like '571.0%' THEN 1
	WHEN icd9code like '571.2%' THEN 1
	WHEN icd9code like '571.3%' THEN 1
	WHEN icd9code like '571.5%' THEN 1
	WHEN icd9code like '571.6%' THEN 1
	WHEN icd9code like '571.8%' THEN 1
	WHEN icd9code like '571.9%' THEN 1
	WHEN icd9code like '572.3%' THEN 1
	WHEN icd9code like '572.8%' THEN 1
	WHEN icd9code like '573.5%' THEN 1
  when icd9code like 'V427%' then 1ELSE 0 end as liver_disease ,

CASE 
   WHEN icd9code like '531.41%' THEN 1 
   WHEN icd9code like '531.51%' then 1
	 WHEN icd9code like '531.61%' THEN 1 
   WHEN icd9code like '531.70%' then 1
	 WHEN icd9code like '531.71%' THEN 1 
   WHEN icd9code like '531.91%' then 1
	 WHEN icd9code like '532.41%' THEN 1 
   WHEN icd9code like '532.51%' then 1
	 WHEN icd9code like '532.61%' THEN 1 
   WHEN icd9code like '532.70%' then 1
	 WHEN icd9code like '532.71%' THEN 1 
   WHEN icd9code like '532.91%' then 1
	 WHEN icd9code like '533.41%' THEN 1 
   WHEN icd9code like '533.51%' then 1
	 WHEN icd9code like '533.61%' THEN 1 
   WHEN icd9code like '533.70%' then 1
	 WHEN icd9code like '533.91%' THEN 1 
   WHEN icd9code like '534.41%' then 1
	 WHEN icd9code like '534.51%' THEN 1 
   WHEN icd9code like '534.61%' then 1 
   WHEN icd9code like '534.70%' THEN 1 
   WHEN icd9code like '534.71%' then 1
	 WHEN icd9code like '534.91%' THEN 1 
ELSE 0 END as peptic_ulcer ,

CASE 
  when icd9code like '042%' THEN 1
	when icd9code like '043%' THEN 1
	when icd9code like '044%' THEN 1
else 0 end as AIDS ,

CASE 
 WHEN icd9code like '200.%' THEN 1 
 WHEN icd9code like '201%' THEN 1
 WHEN icd9code like '202.1%' THEN 1
 WHEN icd9code like '202.2%' THEN 1
 WHEN icd9code like '202.3%' THEN 1
 WHEN icd9code like '202.5%' THEN 1
 WHEN icd9code like '202.6%' THEN 1
 WHEN icd9code like '202.7%' THEN 1
 WHEN icd9code like '202.8%' THEN 1
 WHEN icd9code like '202.9%' THEN 1
 WHEN icd9code like '203.0%' THEN 1
 WHEN icd9code like '238.6%' THEN 1
 WHEN icd9code like '273.3%' THEN 1
 WHEN icd9code like '203.02%' THEN 1
 WHEN icd9code like '203.1%' THEN 1
 WHEN icd9code like '203.2%' THEN 1
 WHEN icd9code like '203.3%' THEN 1
 WHEN icd9code like '203.4%' THEN 1
 WHEN icd9code like '203.5%' THEN 1
 WHEN icd9code like '203.6%' THEN 1
 WHEN icd9code like '203.7%' THEN 1
 WHEN icd9code like '203.8%' THEN 1
ELSE 0 END as lymphoma ,

CASE 
  WHEN icd9code like '196.%' THEN 1 
	WHEN icd9code like '197%' THEN 1 
  WHEN icd9code like '198%' THEN 1 
  WHEN icd9code like '199%' THEN 1 
  WHEN icd9code like '209.70%' THEN 1 
  WHEN icd9code like '209.71%' THEN 1
  WHEN icd9code like '209.72%' THEN 1 
  WHEN icd9code like '209.73%' THEN 1 
  WHEN icd9code like '209.74%' THEN 1
  WHEN icd9code like '209.75%' THEN 1
	WHEN icd9code like '209.79%' THEN 1 
	WHEN icd9code like '789.51%' THEN 1 
ELSE 0 END as metastatic_cancer,

case 
  when icd9code like '14%' THEN 1 
	when icd9code like '15%' THEN 1
	when icd9code like '16%' THEN 1
	when icd9code like '171%' THEN 1
	when icd9code like '172%' THEN 1
	when icd9code like '174%' THEN 1
	when icd9code like '175%' THEN 1
	when icd9code like '179%' THEN 1
	when icd9code like '18%' THEN 1
	when icd9code like '191%' THEN 1
	when icd9code like '192%' THEN 1
	when icd9code like '193%' THEN 1
	when icd9code like '194%' THEN 1
	when icd9code like '195%' THEN 1
	when icd9code like '209.0%' THEN 1
	when icd9code like '209.1%' THEN 1
	when icd9code like '209.21%' THEN 1
	when icd9code like '209.22%' THEN 1
	when icd9code like '209.23%' THEN 1
	when icd9code like '209.24%' THEN 1
	when icd9code like '209.25%' THEN 1
	when icd9code like '209.30%' THEN 1
	when icd9code like '209.31%' THEN 1
	when icd9code like '209.32%' THEN 1
	when icd9code like '209.33%' THEN 1
	when icd9code like '209.34%' THEN 1
	when icd9code like '209.35%' THEN 1
	when icd9code like '209.36%' THEN 1
	when icd9code like '258.01%' THEN 1
	when icd9code like '258.02%' THEN 1
	when icd9code like '258.03%' THEN 1
ELSE 0 end as solid_tumor ,

CASE 
  when icd9code like '701.0%' THEN 1
	when icd9code like '710%' THEN 1
	when icd9code like '714%' THEN 1
	when icd9code like '720%' THEN 1
	when icd9code like '725%' THEN 1
ELSE 0 END as rheumatoid_arthritis,

CASE
  WHEN icd9code like '286%' THEN 1 
	WHEN icd9code like '287.1%' THEN 1
	WHEN icd9code like '287.3%' THEN 1
	WHEN icd9code like '287.4%' THEN 1
	WHEN icd9code like '287.5%' THEN 1
	WHEN icd9code like '649.30%' THEN 1
	WHEN icd9code like '649.31%' THEN 1
	WHEN icd9code like '649.32%' THEN 1
	WHEN icd9code like '649.33%' THEN 1
	WHEN icd9code like '649.34%' THEN 1
	WHEN icd9code like '289.84%' THEN 1
ELSE 0 END as coagulopathy ,

CASE 
  when icd9code like '278.0%' THEN 1
	WHEN icd9code like '278.00%' THEN 1
	WHEN icd9code like '278.01%' THEN 1
	WHEN icd9code like '278.03%' THEN 1
	WHEN icd9code like '649.10%' THEN 1
	WHEN icd9code like '649.11%' THEN 1
	WHEN icd9code like '649.12%' THEN 1
	WHEN icd9code like '649.13%' THEN 1
	WHEN icd9code like '649.14%' THEN 1
	WHEN icd9code like 'V85.3%' THEN 1
	WHEN icd9code like 'V85.4%' THEN 1
ELSE 0 END as obesity,

CASE 
  WHEN icd9code like '260%' THEN 1 
	WHEN icd9code like '261%' THEN 1
	WHEN icd9code like '262%' THEN 1 
	WHEN icd9code like '263%' THEN 1
	WHEN icd9code like '783.21%' THEN 1 
	WHEN icd9code like '783.22%' THEN 1
ELSE 0 END AS weight_loss,

CASE 
  WHEN icd9code like '276%' THEN 1
ELSE 0 END AS fluid_electrolyte,

CASE 
  WHEN icd9code like '280.0%' THEN 1 
	WHEN icd9code like '648.20%' then 1 
	WHEN icd9code like '648.21%' then 1
	WHEN icd9code like '648.22%' then 1
	WHEN icd9code like '648.23%' then 1
  WHEN icd9code like '648.24%' then 1
ELSE 0 END as blood_loss_anemia ,

CASE 
  WHEN icd9code like '280.1%' THEN 1
	WHEN icd9code like '285.21%' THEN 1
	WHEN icd9code like '285.22%' THEN 1
	WHEN icd9code like '285.23%' THEN 1
	WHEN icd9code like '285.24%' THEN 1
	WHEN icd9code like '285.25%' THEN 1
	WHEN icd9code like '285.26%' THEN 1
	WHEN icd9code like '285.27%' THEN 1
	WHEN icd9code like '285.28%' THEN 1
	WHEN icd9code like '285.29%' THEN 1
	WHEN icd9code like '285.9%' THEN 1
ELSE 0 END as deficiency_anemias ,

CASE 
  WHEN icd9code like '291.0%' THEN 1
	WHEN icd9code like '291.1%' THEN 1
	WHEN icd9code like '291.2%' THEN 1
	WHEN icd9code like '291.3%' THEN 1
	WHEN icd9code like '291.5%' THEN 1
	WHEN icd9code like '291.8%' THEN 1
	WHEN icd9code like '291.81%' THEN 1
	WHEN icd9code like '291.82%' THEN 1
	WHEN icd9code like '291.89%' THEN 1
	WHEN icd9code like '291.9%' THEN 1
	WHEN icd9code like '303.%' THEN 1
	WHEN icd9code like '305.00%' THEN 1
	WHEN icd9code like '305.01%' THEN 1
	WHEN icd9code like '305.02%' THEN 1
	WHEN icd9code like '305.03%' THEN 1
ELSE 0 END AS alcohol_abuse,

case 
  WHEN icd9code like '292.0%' THEN 1
  WHEN icd9code like '292.82%' THEN 1
	WHEN icd9code like '292.83%' THEN 1
	WHEN icd9code like '292.84%' THEN 1
	WHEN icd9code like '292.85%' THEN 1
	WHEN icd9code like '292.86%' THEN 1
	WHEN icd9code like '292.87%' THEN 1
	WHEN icd9code like '292.88%' THEN 1
	WHEN icd9code like '292.89%' THEN 1
	WHEN icd9code like '292.9%' THEN 1
	WHEN icd9code like '304%' THEN 1
	WHEN icd9code like '305.2%' THEN 1
	WHEN icd9code like '305.3%' THEN 1
	WHEN icd9code like '305.4%' THEN 1
	WHEN icd9code like '305.5%' THEN 1
	WHEN icd9code like '305.6%' THEN 1
	WHEN icd9code like '305.7%' THEN 1
	WHEN icd9code like '305.8%' THEN 1
	WHEN icd9code like '305.9%' THEN 1
	WHEN icd9code like '648.30%' THEN 1
	WHEN icd9code like '648.31%' THEN 1
	WHEN icd9code like '648.32%' THEN 1
	WHEN icd9code like '648.33%' THEN 1
	WHEN icd9code like '648.34%' THEN 1
ELSE 0 END AS drug_abuse ,

CASE 
  WHEN icd9code like '295%' THEN 1
	WHEN icd9code like '296%' THEN 1
	WHEN icd9code like '297%' THEN 1
	WHEN icd9code like '298%' THEN 1
	WHEN icd9code like '299.10%' THEN 1
	WHEN icd9code like '299.11%' THEN 1
ELSE 0 END as psychoses ,

CASE 
  WHEN icd9code like '300.4%' THEN 1 
	WHEN icd9code like '301.12%' THEN 1
	WHEN icd9code like '309.0%' THEN 1
	WHEN icd9code like '309.1%' THEN 1
	WHEN icd9code like '311%' THEN 1
ELSE 0 END AS depression
	
	
FROM diagnosis 
) SELECT patientunitstayid,max(CHF) as Congestive_heart_failure,
max(CARDIAC_ARRHYTHMIAS) as CARDIAC_ARRHYTHMIAS ,
max(VALVULAR_DISEASE) as VALVULAR_DISEASE,
max(PULMONARY_CIRCULATION) as PULMONARY_CIRCULATION,
max(PERIPHERAL_VASCULAR) as PERIPHERAL_VASCULAR ,
max(HYPERTENSION) as HYPERTENSION,
max(PARALYSIS) as PARALYSIS,
max(OTHER_NEUROLOGICAL) as OTHER_NEUROLOGICAL,
max(CHRONIC_PULMONARY) as CHRONIC_PULMONARY,
max(DIABETES_UNCOMPLICATED) as DIABETES_UNCOMPLICATED,
max(DIABETES_COMPLICATED) as DIABETES_COMPLICATED,
max(HYPOTHYROIDISM) as HYPOTHYROIDISM,
max(RENAL_FAILURE) as RENAL_FAILURE,
max(LIVER_DISEASE) as LIVER_DISEASE,
max(PEPTIC_ULCER) as PEPTIC_ULCER ,
max(LYMPHOMA) as LYMPHOMA,
max(METASTATIC_CANCER) as METASTATIC_CANCER,
max(SOLID_TUMOR) as SOLID_TUMOR,
max(RHEUMATOID_ARTHRITIS) as RHEUMATOID_ARTHRITIS,
max(COAGULOPATHY) as COAGULOPATHY,
max(WEIGHT_LOSS) as WEIGHT_LOSS,
max(FLUID_ELECTROLYTE) as FLUID_ELECTROLYTE,
max(BLOOD_LOSS_ANEMIA) as BLOOD_LOSS_ANEMIA,
max(DEFICIENCY_ANEMIAS) as DEFICIENCY_ANEMIAS,
max(ALCOHOL_ABUSE) as ALCOHOL_ABUSE,
max(DRUG_ABUSE) as DRUG_ABUSE,
max(PSYCHOSES) as PSYCHOSES,
max(DEPRESSION) as DEPRESSION 

FROM 
icd
GROUP BY patientunitstayid 
ORDER BY patientunitstayid