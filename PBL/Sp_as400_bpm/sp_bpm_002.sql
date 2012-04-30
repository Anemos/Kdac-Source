-- file name : pbbpm.sp_bpm_002
-- procedure name : pbbpm.sp_bpm_002
-- desc : Creation bpm508 : �����ȹ bom ���������� ����
-- �����('A') - BOM����('D' : ȣȯ��ǰ�� ���庰����)
-- �����('B') - BOM����('B' : ȣȯ��ǰ�� ����������)
-- �����ȹ ���� ���� a_rev ('0A'~ )

drop procedure pbbpm.sp_bpm_002;
create procedure pbbpm.sp_bpm_002 (
in a_comltd char(2),
in a_xyear char(4),
in a_applydate char(8),
in a_divcode char(1),
in a_expcode char(1),
in a_rev char(2),
in a_lastdate char(8),
in a_lastemp char(6))
language sql
begin
declare sqlcode integer default 0;
declare p_plant char(1);
declare p_dvsn char(1);
declare at_end integer default 0;
declare not_found condition for '02000';

--Get Product item
declare bpm_002_cursor Cursor for
 select a.xplant,a.div
 from pbinv.inv902 a inner join pbcommon.dac002 b
  on a.div = b.cocode and b.cogubun = 'DAC030' and
  a.inptid = 'A'
 order by a.xplant,a.div;

declare continue handler for not_found
  set at_end = 1;

open bpm_002_cursor;
inc_loop:
loop
  fetch bpm_002_cursor into p_plant,p_dvsn;
  if sqlcode <> 0 or at_end = 1 then
     leave inc_loop;
  end if;

  -- call sp_bom_001
  call pbbpm.sp_bpm_001(a_comltd,p_plant,p_dvsn,a_xyear,
       a_applydate,a_divcode,a_expcode,a_rev,a_lastdate,a_lastemp);

end loop;
close bpm_002_cursor;

end
