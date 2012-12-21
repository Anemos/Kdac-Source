-- file name : pbpdm.sp_bom_108
-- procedure name : pbpdm.sp_bom_108
-- desc : 공장간 Running BOM 이동

drop procedure pbpdm.sp_bom_108;
create procedure pbpdm.sp_bom_108 (
in a_comltd char(2),
in a_plant char(1),
in a_dvsn char(1),
in a_itno varchar(15),
in a_applydate char(8),
in a_createdate char(8),
in a_tplant char(1),
in a_tdvsn char(1))
language sql
begin
declare sqlcode integer default 0;
declare p_tcitn varchar(15);
declare p_opcd char(1);
declare p_exprtn char(1);
declare p_rtn integer default 0;
declare at_end integer default 0;
declare not_found condition for '02000';

declare continue handler for not_found
  set at_end = 1;

set at_end = 0;
set p_exprtn = pbpdm.sf_bom_exp(a_comltd,a_plant,a_dvsn,
            a_itno,a_applydate,'A');

set p_tcitn = '';

inc_loop:
loop
 select rtrim(a.tcitn),a.topcd
 into p_tcitn,p_opcd
 from qtemp.tmp_bom a
 where a.tcitn > p_tcitn
 order by a.tcitn
 fetch first 1 row only;

  if sqlcode <> 0 or at_end = 1 then
     leave inc_loop;
  end if;

select count(*) into p_rtn from pbinv.inv101
where  comltd = '01' and
xplant = a_tplant and div = a_tdvsn and itno = p_tcitn;

-- First Step
if p_rtn = 0 then
insert into pbinv.inv101
(COMLTD,XPLANT,DIV,ITNO,CLS,SRCE,PDCD,XUNIT,UNIT1,
COSTDIV,XPLAN,MLAN,CONVQTY,CONVQTY1,
AUTCD,MDNO,WLOC,WCCD,ISCD,ISBOX,NUSE,ABCCD,KBCD,MASS,IRTCD,
MAXQ,MINQ,SAFT,SFWQ,ADJQTY,ORPT,PULS,ISLS,PULT,BGQTY,BGAMT,
INTQTY,INTAMT,OUTQTY,OUTAMT,OHUQTY,OHRQTY,OHSQTY,OHAMT,
EXQTY,COSTAV,COSTLS,SAUP,SAUD,IUNPR,IUNRC,ISPQT,
IPERP,IPEIS,IPERP1,PKSZ,SHPCD,ILUDT,LPDT,MCNO,FOBCOST,CURR,
CHKCD,HSCD,TXRT,FSTDT,INDUS,COMCD,EXTD,
INPTID,INPTDT,UPDTID,UPDTDT,IPADDR,MACADDR)
SELECT COMLTD,a_tplant,a_tdvsn,ITNO,CLS,SRCE,PDCD,XUNIT,UNIT1,
COSTDIV,XPLAN,MLAN,CONVQTY,CONVQTY1,
AUTCD,MDNO,WLOC,WCCD,ISCD,ISBOX,NUSE,ABCCD,KBCD,MASS,IRTCD,
MAXQ,MINQ,SAFT,SFWQ,ADJQTY,ORPT,PULS,ISLS,PULT,BGQTY,BGAMT,
INTQTY,INTAMT,OUTQTY,OUTAMT,OHUQTY,OHRQTY,OHSQTY,OHAMT,
EXQTY,COSTAV,COSTLS,SAUP,SAUD,IUNPR,IUNRC,ISPQT,
IPERP,IPEIS,IPERP1,PKSZ,SHPCD,ILUDT,LPDT,MCNO,FOBCOST,CURR,
CHKCD,HSCD,TXRT,FSTDT,INDUS,COMCD,EXTD,
INPTID,INPTDT,'000030','20121106',IPADDR,MACADDR
FROM PBinv.inv101
where comltd = '01' and xplant = a_plant
and div = a_dvsn and itno = p_tcitn;
end if;

SELECT count(*) into p_rtn
FROM PBPDM.BOM001 B
WHERE B.PCMCD = '01' AND B.PLANT = a_tplant AND
B.PDVSN = a_tdvsn AND B.PPITN = p_tcitn AND
( (B.PEDTM <= B.PEDTE AND B.PEDTE <> ' ' AND
B.PEDTE >= a_applydate ) OR  ( B.PEDTE = ' ' )) ;

-- second step
if p_rtn = 0 then
INSERT INTO PBPDM.BOM001
( PCMCD,PLANT,PDVSN,PPITN,PROUT,PCITN,PCHDT,
PQTYM,PQTYE,PWKCT,PEDTM,PEDTE,POPCD,PEXPLANT,PEXDV,
PCHCD,POSCD,PEBST,PMACADDR,PIPADDR,PINDT,PEMNO,PREMK )
SELECT PCMCD,a_tplant,a_tdvsn,PPITN,PROUT,PCITN,PCHDT,
PQTYM,PQTYE,PWKCT,PEDTM,PEDTE,POPCD,PEXPLANT,PEXDV,
PCHCD,POSCD,PEBST,PMACADDR,PIPADDR,'20121106','000030',PREMK
FROM PBPDM.BOM001
WHERE ( PCMCD = '01' ) AND ( PLANT = a_plant ) AND
( PDVSN = a_dvsn ) AND (PPITN = p_tcitn) AND
( PQTYM <> 0 ) AND ( (PEDTM <= PEDTE AND PEDTE <> ' '
AND PEDTE >= a_applydate ) OR  ( PEDTE = ' ' ))
;
end if;

SELECT count(*) into p_rtn
FROM PBPDM.BOM003 B
WHERE B.OCMCD = '01' AND
B.OPLANT = a_tplant AND B.ODVSN = a_tdvsn AND B.OPITN = p_tcitn AND
( (B.OEDTM <= B.OEDTE AND B.OEDTE <> ' ' AND
B.OEDTE >= a_applydate ) OR ( B.OEDTE = ' ' ));

-- third step
if p_rtn = 0 then
  if p_opcd = '1' then

INSERT INTO PBPDM.BOM003
( OCMCD,OPLANT,ODVSN,OPITN,OFITN,OCHDT,OEDTM,OEDTE,
ORATE,OCHCD,OFOCD,OMACADDR,OIPADDR,OEMNO,OINDT )
SELECT OCMCD,a_tplant,a_tdvsn,OPITN,OFITN,OCHDT,OEDTM,OEDTE,
ORATE,OCHCD,OFOCD,OMACADDR,OIPADDR,'000030','20121106'
FROM PBPDM.BOM003 A
WHERE ( OCMCD = '01' ) AND ( OPLANT = a_plant ) AND
( ODVSN = a_dvsn ) AND ( OPITN = p_tcitn ) AND
( (OEDTM <= A.OEDTE AND OEDTE <> ' ' AND
OEDTE >= a_applydate ) OR ( OEDTE = ' ' ))
;

  end if;
end if;

  set at_end = 0;
end loop;

end
