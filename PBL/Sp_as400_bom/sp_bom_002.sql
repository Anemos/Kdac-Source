-- file name : pbpdm.sp_bom_002
-- procedure name : pbpdm.sp_bom_002
-- desc : Creation BOM109, 고객사유상사급제외 재료비 생성
-- a_chk : FULL ('A'), 전사 ('B'), 공장별('C') to 'E'
--         ONLY 재료비산출('N')
--         Create BOM113 'K'
--         Create BOM115 'M'
-- a_gubun : 고객사유상사급포함('Y'), 고객사유상사급제외('N')

drop procedure pbpdm.sp_bom_002;
create procedure pbpdm.sp_bom_002 (
in a_comltd char(2),
in a_applydate char(8),
in a_createdate char(8),
in a_chk char(1))
language sql
begin
declare sqlcode integer default 0;
declare p_plant char(1);
declare p_dvsn char(1);
declare p_yyyymm char(6);
declare at_end integer default 0;
declare not_found condition for '02000';

--Get Product item
declare inv902_cursor Cursor for
 select a.xplant,a.div
 from pbinv.inv902 a inner join pbcommon.dac002 b
  on a.div = b.cocode and b.cogubun = 'DAC030' and
  a.inptid = 'A'
 order by a.xplant,a.div;

declare continue handler for not_found
  set at_end = 1;

if a_chk <> 'A' and a_chk <> 'B' and a_chk <> 'C' and
  a_chk <> 'K' and a_chk <> 'M' and a_chk <> 'N' then
  return;
end if;

set p_yyyymm = substring(a_applydate,1,6);

open inv902_cursor;
inc_loop:
loop
  fetch inv902_cursor into p_plant,p_dvsn;
  if sqlcode <> 0 or at_end = 1 then
     leave inc_loop;
  end if;

  -- call sp_bom_101
  call pbpdm.sp_bom_001(a_comltd,p_plant,p_dvsn,
       a_applydate,a_createdate,a_chk);

end loop;
close inv902_cursor;

-- update purchase information
call pbpdm.sp_bom_105(a_comltd,a_applydate,a_createdate);
-- update ygcost
if p_yyyymm <> substring(a_createdate,1,6) then
  update pbpdm.bom113
  set zygcst = ifnull(pbpdm.sf_bom_106(zitno),0)
  where zcmcd = a_comltd and zdate = p_yyyymm and zygchk = 'Y';
  
  update pbpdm.bom115
  set zygcst = ifnull(pbpdm.sf_bom_106(zitno),0)
  where zcmcd = a_comltd and zdate = p_yyyymm and zygchk = 'Y';
else
  update pbpdm.bom113d
  set zygcst = ifnull(pbpdm.sf_bom_106(zitno),0)
  where zcmcd = a_comltd and zdate = p_yyyymm and zygchk = 'Y';

  update pbpdm.bom115d
  set zygcst = ifnull(pbpdm.sf_bom_106(zitno),0)
  where zcmcd = a_comltd and zdate = p_yyyymm and zygchk = 'Y';
end if;

end
