DROP MATERIALIZED VIEW IF EXISTS antibiotic CASCADE;
create materialized view antibiotic as
with abx as
(
  SELECT DISTINCT
    drugname
		, routeadmin
    , case
      when lower(drugname) like '%adoxa%' then 1
      when lower(drugname) like '%ala-tet%' then 1
      when lower(drugname) like '%alodox%' then 1
      when lower(drugname) like '%amikacin%' then 1
      when lower(drugname) like '%amikin%' then 1
      when lower(drugname) like '%amoxicill%' then 1
      when lower(drugname) like '%amphotericin%' then 1
      when lower(drugname) like '%anidulafungin%' then 1
      when lower(drugname) like '%ancef%' then 1
      when lower(drugname) like '%clavulanate%' then 1
      when lower(drugname) like '%ampicillin%' then 1
      when lower(drugname) like '%augmentin%' then 1
      when lower(drugname) like '%avelox%' then 1
      when lower(drugname) like '%avidoxy%' then 1
      when lower(drugname) like '%azactam%' then 1
      when lower(drugname) like '%azithromycin%' then 1
      when lower(drugname) like '%aztreonam%' then 1
      when lower(drugname) like '%axetil%' then 1
      when lower(drugname) like '%bactocill%' then 1
      when lower(drugname) like '%bactrim%' then 1
      when lower(drugname) like '%bactroban%' then 1
      when lower(drugname) like '%bethkis%' then 1
      when lower(drugname) like '%biaxin%' then 1
      when lower(drugname) like '%bicillin l-a%' then 1
      when lower(drugname) like '%cayston%' then 1
      when lower(drugname) like '%cefazolin%' then 1
      when lower(drugname) like '%cedax%' then 1
      when lower(drugname) like '%cefoxitin%' then 1
      when lower(drugname) like '%ceftazidime%' then 1
      when lower(drugname) like '%cefaclor%' then 1
      when lower(drugname) like '%cefadroxil%' then 1
      when lower(drugname) like '%cefdinir%' then 1
      when lower(drugname) like '%cefditoren%' then 1
      when lower(drugname) like '%cefepime%' then 1
      when lower(drugname) like '%cefotan%' then 1
      when lower(drugname) like '%cefotetan%' then 1
      when lower(drugname) like '%cefotaxime%' then 1
      when lower(drugname) like '%ceftaroline%' then 1
      when lower(drugname) like '%cefpodoxime%' then 1
      when lower(drugname) like '%cefpirome%' then 1
      when lower(drugname) like '%cefprozil%' then 1
      when lower(drugname) like '%ceftibuten%' then 1
      when lower(drugname) like '%ceftin%' then 1
      when lower(drugname) like '%ceftriaxone%' then 1
      when lower(drugname) like '%cefuroxime%' then 1
      when lower(drugname) like '%cephalexin%' then 1
      when lower(drugname) like '%cephalothin%' then 1
      when lower(drugname) like '%cephapririn%' then 1
      when lower(drugname) like '%chloramphenicol%' then 1
      when lower(drugname) like '%cipro%' then 1
      when lower(drugname) like '%ciprofloxacin%' then 1
      when lower(drugname) like '%claforan%' then 1
      when lower(drugname) like '%clarithromycin%' then 1
      when lower(drugname) like '%cleocin%' then 1
      when lower(drugname) like '%clindamycin%' then 1
      when lower(drugname) like '%cubicin%' then 1
      when lower(drugname) like '%dicloxacillin%' then 1
      when lower(drugname) like '%dirithromycin%' then 1
      when lower(drugname) like '%doryx%' then 1
      when lower(drugname) like '%doxycy%' then 1
      when lower(drugname) like '%duricef%' then 1
      when lower(drugname) like '%dynacin%' then 1
      when lower(drugname) like '%ery-tab%' then 1
      when lower(drugname) like '%eryped%' then 1
      when lower(drugname) like '%eryc%' then 1
      when lower(drugname) like '%erythrocin%' then 1
      when lower(drugname) like '%erythromycin%' then 1
      when lower(drugname) like '%factive%' then 1
      when lower(drugname) like '%flagyl%' then 1
      when lower(drugname) like '%fortaz%' then 1
      when lower(drugname) like '%furadantin%' then 1
      when lower(drugname) like '%garamycin%' then 1
      when lower(drugname) like '%gentamicin%' then 1
      when lower(drugname) like '%kanamycin%' then 1
      when lower(drugname) like '%keflex%' then 1
      when lower(drugname) like '%kefzol%' then 1
      when lower(drugname) like '%ketek%' then 1
      when lower(drugname) like '%levaquin%' then 1
      when lower(drugname) like '%levofloxacin%' then 1
      when lower(drugname) like '%lincocin%' then 1
      when lower(drugname) like '%linezolid%' then 1
      when lower(drugname) like '%macrobid%' then 1
      when lower(drugname) like '%macrodantin%' then 1
      when lower(drugname) like '%maxipime%' then 1
      when lower(drugname) like '%mefoxin%' then 1
      when lower(drugname) like '%metronidazole%' then 1
      when lower(drugname) like '%meropenem%' then 1
      when lower(drugname) like '%methicillin%' then 1
      when lower(drugname) like '%minocin%' then 1
      when lower(drugname) like '%minocycline%' then 1
      when lower(drugname) like '%monodox%' then 1
      when lower(drugname) like '%monurol%' then 1
      when lower(drugname) like '%morgidox%' then 1
      when lower(drugname) like '%moxatag%' then 1
      when lower(drugname) like '%moxifloxacin%' then 1
      when lower(drugname) like '%mupirocin%' then 1
      when lower(drugname) like '%myrac%' then 1
      when lower(drugname) like '%nafcillin%' then 1
      when lower(drugname) like '%neomycin%' then 1
      when lower(drugname) like '%nicazel doxy 30%' then 1
      when lower(drugname) like '%nitrofurantoin%' then 1
      when lower(drugname) like '%norfloxacin%' then 1
      when lower(drugname) like '%noroxin%' then 1
      when lower(drugname) like '%ocudox%' then 1
      when lower(drugname) like '%ofloxacin%' then 1
      when lower(drugname) like '%omnicef%' then 1
      when lower(drugname) like '%oracea%' then 1
      when lower(drugname) like '%oraxyl%' then 1
      when lower(drugname) like '%oxacillin%' then 1
      when lower(drugname) like '%pc pen vk%' then 1
      when lower(drugname) like '%pce dispertab%' then 1
      when lower(drugname) like '%panixine%' then 1
      when lower(drugname) like '%pediazole%' then 1
      when lower(drugname) like '%penicillin%' then 1
      when lower(drugname) like '%periostat%' then 1
      when lower(drugname) like '%pfizerpen%' then 1
      when lower(drugname) like '%piperacillin%' then 1
      when lower(drugname) like '%tazobactam%' then 1
      when lower(drugname) like '%primsol%' then 1
      when lower(drugname) like '%proquin%' then 1
      when lower(drugname) like '%raniclor%' then 1
      when lower(drugname) like '%rifadin%' then 1
      when lower(drugname) like '%rifampin%' then 1
      when lower(drugname) like '%rocephin%' then 1
      when lower(drugname) like '%smz-tmp%' then 1
      when lower(drugname) like '%septra%' then 1
      when lower(drugname) like '%septra ds%' then 1
      when lower(drugname) like '%septra%' then 1
      when lower(drugname) like '%solodyn%' then 1
      when lower(drugname) like '%spectracef%' then 1
      when lower(drugname) like '%streptomycin%' then 1
      when lower(drugname) like '%sulfadiazine%' then 1
      when lower(drugname) like '%sulfamethoxazole%' then 1
      when lower(drugname) like '%trimethoprim%' then 1
      when lower(drugname) like '%sulfatrim%' then 1
      when lower(drugname) like '%sulfisoxazole%' then 1
      when lower(drugname) like '%suprax%' then 1
      when lower(drugname) like '%synercid%' then 1
      when lower(drugname) like '%tazicef%' then 1
      when lower(drugname) like '%tetracycline%' then 1
      when lower(drugname) like '%timentin%' then 1
      when lower(drugname) like '%tobramycin%' then 1
      when lower(drugname) like '%trimethoprim%' then 1
      when lower(drugname) like '%unasyn%' then 1
      when lower(drugname) like '%vancocin%' then 1
      when lower(drugname) like '%vancomycin%' then 1
      when lower(drugname) like '%vantin%' then 1
      when lower(drugname) like '%vibativ%' then 1
      when lower(drugname) like '%vibra-tabs%' then 1
      when lower(drugname) like '%vibramycin%' then 1
      when lower(drugname) like '%zinacef%' then 1
      when lower(drugname) like '%zithromax%' then 1
      when lower(drugname) like '%zosyn%' then 1
      when lower(drugname) like '%zyvox%' then 1
    else 0
    end as antibiotic
  from medication
  -- we exclude routes via the eye, ears, or topically
	where routeadmin not in ('OU','OS','OD','AU','AS','AD', 'TP')
  and lower(routeadmin) not like '%ear%'
  and lower(routeadmin) not like '%eye%'
  -- we exclude certain types of antibiotics: topical creams, gels, desens, etc
  and lower(drugname) not like '%cream%'
  and lower(drugname) not like '%desensitization%'
  and lower(drugname) not like '%ophth oint%'
  and lower(drugname) not like '%gel%'
  -- other routes not sure about...
  -- for sure keep: ('IV','PO','PO/NG','ORAL', 'IV DRIP', 'IV BOLUS')
  -- ? VT, PB, PR, PL, NS, NG, NEB, NAS, LOCK, J TUBE, IVT
  -- ? IT, IRR, IP, IO, INHALATION, IN, IM
  -- ? IJ, IH, G TUBE, DIALYS
  -- ?? enemas??
)
select 
ie.uniquepid, ie.patienthealthsystemstayid, medication.patientunitstayid
, medication.drugname as antibiotic
, medication.routeadmin
, medication.drugstartoffset
, medication.drugstopoffset
from medication
-- inner join to subselect to only antibiotic prescriptions
inner join abx
    on medication.drugname = abx.drugname
    -- route is never NULL for antibiotics
    -- only ~4000 null rows in prescriptions total.
    AND medication.routeadmin = abx.routeadmin
-- add in stay_id as we use this table for sepsis-3
LEFT JOIN patient ie
    ON medication.patientunitstayid = ie.patientunitstayid
    AND medication.drugstartoffset >= 0
    AND medication.drugstopoffset < ie.unitdischargeoffset
WHERE abx.antibiotic = 1
;