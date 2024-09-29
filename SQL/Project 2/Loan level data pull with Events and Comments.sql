--Getting loans  with 03 Event code in the last XX events

WITH remarks AS (
  select
  emili.lnacctno,
  ec.tmstamp,
  ec.rurmktxt
  from ds_ins_risk.ins_risk_last emili

left join cmwdw_insurance.vwdw_loan_account_dim l
on emili.lnacctno = l.cmhc_loan_account_nbr

left join cmwdw_insurance.vwdw_lender_dim len
on emili.AVLENDCD = len.lender_cde

left join cmwdw_insurance.vwdw_costable_unit_dim cu
on emili.cucode = cu.costable_unit_cde

left join dbenp001.tben_eventlog ec
on emili.lnacctno = ec.cmhcno

where emili.aplcrecd between '20150101' and '20231231'
and emili.bulkind = "0"
and l.low_ratio_mortgage_tcd not in ("01","02")
and len.parent_level1_lender_cde = "49020"
and cu.insurance_product_group_desc_en='Homeowner'
and ec.miapevcd ='01')
,
--Ranking the latest records
RankedEvents AS (
    SELECT
        cmhcno,
        tmstamp,
        miapevcd,
        ROW_NUMBER() OVER (PARTITION BY cmhcno ORDER BY tmstamp DESC) AS rn
    FROM
        dbenp001.tben_eventlog
)
--Pulling the rest of the data
SELECT
cmhcno,
RankedEvents.tmstamp,
miapevcd,
emili.lnacctno as loans,
emili.aplcrecd as recieved_date,
substr(cast(emili.aplcrecd as string),1,4) as rec_year,
rurmktxt as RU_remarks

FROM RankedEvents
LEFT JOIN ds_ins_risk.ins_risk_last emili
on RankedEvents.cmhcno= emili.lnacctno 

LEFT JOIN remarks
on RankedEvents.cmhcno=remarks.lnacctno

left join cmwdw_insurance.vwdw_loan_account_dim lad 
on emili.lnacctno = lad.cmhc_loan_account_nbr
 
left join cmwdw_insurance.vwdw_costable_unit_dim cu 
on emili.cucode = cu.costable_unit_cde

left join cmwdw_insurance.vwdw_loan_account_sum las
on lad.loan_account_surrkey = las.loan_account_surrkey 

LEFT JOIN cmwdw_insurance.vwdw_lender_dim len
on las.approved_lender_surrkey=len.lender_surrkey

left join cmwdw_insurance.vwdw_loan_transmission_sum lts
    on lad.loan_account_surrkey = lts.loan_account_surrkey

left join cmwdw_insurance.vwdw_loan_status_dim lsd
    on lts.loan_status_surrkey = lsd.loan_status_surrkey

WHERE
    rn <= 7  -- Select only the last or one before last timestamp per each loan
    AND miapevcd = 03  -- Filter rows where the event code is X
    --and cmhcno=42242733 --to test 
    and emili.aplcrecd between '20210101' and '20231231'
    and lad.low_ratio_mortgage_tcd not in ('01','02')
    and cu.insurance_product_group_cde = '100'
    and len.parent_level1_lender_cde = 49020
    and rurmktxt<>"" --drop empty comments
