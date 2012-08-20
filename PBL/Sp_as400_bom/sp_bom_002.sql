-- file name : pbpdm.sp_bom_002
-- procedure name : pbpdm.sp_bom_002
-- desc : Creation BOM109, �������������� ���� ����
-- a_chk : FULL ('A'), ��ü ('B'), ���庰('C') to 'E'
--         ONLY �������('N')
--         Create BOM113 'K'
--         Create BOM115 'M'
-- a_gubun : ��������������('Y'), ��������������('N')

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

-- update ygcost in 

end
