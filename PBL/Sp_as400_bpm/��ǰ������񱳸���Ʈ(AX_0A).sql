SELECT DISTINCT AA.MYEAR,
         AA.MPLANT,
         AA.MDIV,
         AA.MMDCD,
			AA.PRNAME,
         AA.MMDNO,
			AA.AMDNM,
			AA.MSEQGB,
			AA.ADECD,
			AA.ACUST,
         AA.ACUNM,
         AA.AASCD, 
         AA.APRCCD,
         AA.ASRCE,
         AA.ACAR,
         AA.ATYPE,
         AA.MLOSS,
         AA.MTWON,
         AA.MTUSD,
         AA.MTJPY,
         AA.MTDEM,
         AA.MTFRF,
         AA.MTGBP,
         AA.MTAUD,
         AA.MTESP,
         AA.MTEMU,
         AA.MTITL,
         AA.MTCHF,
         AA.MTBFR,
         AA.MTDKK,
         AA.MTATS,
         AA.MTCAD,
         AA.MTSEK,
         AA.MTRMB,
         AA.MTTHB,
         AA.MTETC,
         AA.MOMAT,
         AA.MOLAT,
         AA.ASQTY1,
         AA.ASAMT1,
         AA.ASQTY2,
         AA.ASAMT2,
         AA.ASQTY3,
         AA.ASAMT3,
         AA.ASQTY4,
         AA.ASAMT4,
         AA.ASQTY5,
         AA.ASAMT5,
         AA.ASQTY6,
         AA.ASAMT6,
         AA.ASQTY7,
         AA.ASAMT7,
         AA.ASQTY8,
         AA.ASAMT8,
         AA.ASQTY9,
         AA.ASAMT9,
         AA.ASQTY10,
         AA.ASAMT10,
         AA.ASQTY11,
         AA.ASAMT11,
         AA.ASQTY12,
         AA.ASAMT12,
         AA.ATQTY,
         AA.ATAMT, 
         AA.MCMCD,
         '' AS BLANK,
         BB.MTWON,
         BB.MTUSD,
         BB.MTJPY,
         BB.MTDEM,
         BB.MTFRF,
         BB.MTGBP,
         BB.MTAUD,
         BB.MTESP,
         BB.MTEMU,
         BB.MTITL,
         BB.MTCHF,
         BB.MTBFR,
         BB.MTDKK,
         BB.MTATS,
         BB.MTCAD,
         BB.MTSEK,
         BB.MTRMB,
         BB.MTTHB,
         BB.MTETC,
         BB.MOMAT,
         BB.MOLAT,
         BB.MCMCD
    FROM PBBPM.V110AA_BPM515 AA LEFT OUTER JOIN PBBPM.V10AXA_BPM515 BB
    ON ( AA.COMLTD = BB.COMLTD ) and
       ( AA.MPLANT = BB.MPLANT ) and
       ( AA.MDIV = BB.MDIV ) and
       ( AA.MMDCD = BB.MMDCD ) and
       ( AA.MMDNO = BB.MMDNO ) and
       ( AA.MSEQGB = BB.MSEQGB ) and
       ( AA.ADECD = BB.ADECD ) and
       ( AA.ACUST = BB.ACUST ) );