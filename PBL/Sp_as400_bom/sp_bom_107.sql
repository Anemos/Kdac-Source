-- file name : pbpdm.sp_bom_107
-- procedure name : pbpdm.sp_bom_107
-- desc : 공장간 사업계획 BOM 이동

drop procedure pbpdm.sp_bom_107;
create procedure pbpdm.sp_bom_107 (
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
declare p_xyear char(4);
declare p_revno char(2);
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
set p_xyear = '2013';
set p_revno = '0A';

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

select count(*) into p_rtn from pbbpm.bpm503
where  xyear = p_xyear and  revno = p_revno and
xplant = a_tplant and div = a_tdvsn and itno = p_tcitn;

-- First Step
if p_rtn = 0 then
insert into pbbpm.bpm503
(XYEAR,revno,XPLANT,DIV,ITNO,
CLS,SRCE,PDCD,XUNIT,
COSTDIV,XPLAN,MLAN,CONVQTY,
COMCD,EXTD,INPTID,INPTDT,
UPDTID,UPDTDT,IPADDR,MACADDR,
CRTDT  )
SELECT p_xyear, p_revno, a_tplant, a_tdvsn, ITNO,
CLS,SRCE,PDCD,XUNIT,
COSTDIV,XPLAN,MLAN,CONVQTY,
COMCD,EXTD,'000030',INPTDT,
UPDTID,UPDTDT,IPADDR,MACADDR,
a_createdate
FROM PBinv.inv101
where comltd = '01' and xplant = a_plant
and div = a_dvsn and itno = p_tcitn
and cls in ('10','20','24','50','30')
and xplant || div || trim(itno)
not in (select xplant || div || trim(itno) from pbbpm.bpm503
where  xyear = p_xyear and  revno = p_revno and
xplant = a_tplant and div = a_tdvsn and itno = p_tcitn);
end if;

SELECT count(*) into p_rtn
FROM PBBPM.BPM504 B
WHERE B.PCMCD = '01' AND B.XYEAR = p_xyear AND B.REVNO = p_revno AND
B.PLANT = a_tplant AND B.PDVSN = a_tdvsn AND B.PPITN = p_tcitn AND
( (B.PEDTM <= B.PEDTE AND B.PEDTE <> ' ' AND
B.PEDTE >= a_applydate ) OR  ( B.PEDTE = ' ' )) ;

-- second step
if p_rtn = 0 then
INSERT INTO PBBPM.BPM504
( PCMCD,XYEAR,REVNO,PLANT,PDVSN,PPITN,PROUT,PCITN,PCHDT,
PQTYM,PQTYE,PWKCT,PEDTM,PEDTE,POPCD,PEXPLANT,PEXDV,PCHCD,
POSCD,PEBST,PMACADDR,PIPADDR,PINDT,PEMNO,PREMK )
SELECT A.PCMCD,p_xyear,p_revno,a_tplant,a_tdvsn,A.PPITN,
A.PROUT,A.PCITN,A.PCHDT,A.PQTYM,A.PQTYE,A.PWKCT,A.PEDTM,
A.PEDTE,A.POPCD,A.PEXPLANT,A.PEXDV,A.PCHCD,A.POSCD,A.PEBST,
A.PMACADDR,A.PIPADDR,a_createdate,'000030',A.PREMK
FROM PBPDM.BOM001 A
WHERE ( A.PCMCD = '01' ) AND ( A.PLANT = a_plant ) AND
( A.PDVSN = a_dvsn ) AND (A.PPITN = p_tcitn) AND
( A.PQTYM <> 0 ) AND ( (A.PEDTM <= A.PEDTE AND A.PEDTE <> ' '
AND A.PEDTE >= a_applydate ) OR  ( A.PEDTE = ' ' ))
;
end if;

SELECT count(*) into p_rtn
FROM PBBPM.BPM505 B
WHERE B.OCMCD = '01' AND B.XYEAR = p_xyear AND B.REVNO = p_revno AND
B.OPLANT = a_tplant AND B.ODVSN = a_tdvsn AND B.OPITN = p_tcitn AND
( (B.OEDTM <= B.OEDTE AND B.OEDTE <> ' ' AND
B.OEDTE >= a_applydate ) OR ( B.OEDTE = ' ' ));

-- third step
if p_rtn = 0 then
  if p_opcd = '1' then

INSERT INTO PBBPM.BPM505
( OCMCD,XYEAR,REVNO,OPLANT,ODVSN,OPITN,OFITN,
OCHDT,OEDTM,OEDTE,ORATE,OCHCD,
OFOCD,OMACADDR,OIPADDR,OEMNO,OINDT )
SELECT A.OCMCD,p_xyear,p_revno,a_tplant,a_tdvsn,A.OPITN,A.OFITN,
A.OCHDT,A.OEDTM,A.OEDTE,A.ORATE,A.OCHCD,
A.OFOCD,A.OMACADDR,A.OIPADDR,'000030',a_createdate
FROM PBPDM.BOM003 A
WHERE ( A.OCMCD = '01' ) AND ( A.OPLANT = a_plant ) AND
( A.ODVSN = a_dvsn ) AND ( A.OPITN = p_tcitn ) AND
( (A.OEDTM <= A.OEDTE AND A.OEDTE <> ' ' AND
A.OEDTE >= a_applydate ) OR ( A.OEDTE = ' ' ))
;

  end if;
end if;

  set at_end = 0;
end loop;

end
