select distinct zplant,zdiv,zmdcd, zmdno, zitno, zdesc, zsrce, zygchk, 
zmovcost, zrcpcost, zoutcost, zscmovcost, zscrcpcost, zscoutcost from pbpdm.bom113d
where zcmcd = '01' and zdate = '20120517' and zsrce in ('01','02','04') and 
(( zygchk = 'Y' and (zscmovcost + zscrcpcost + zscoutcost) = 0 ) or 
( zygchk <> 'Y' and (zmovcost + zrcpcost + zoutcost) = 0 ))
order by zplant,zdiv,zmdcd, zmdno, zitno;