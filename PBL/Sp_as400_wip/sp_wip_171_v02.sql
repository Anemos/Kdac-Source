-- file name : sp_wip_171
-- procedure name : pbwip.sp_wip_171
-- desc : Creation AnualQty KnockDown

drop procedure pbwip.sp_wip_171;
create procedure pbwip.sp_wip_171 (
in a_cmcd     char(2),
in a_plant    char(1),
in a_dvsn     char(1),
in a_year     char(4),
in a_month    char(2),
in a_adjdate  char(8),
in a_empno    char(6),
in a_inputdate char(8))
language sql
begin
declare sqlcode integer default 0;
declare p_itno      char(12);
declare p_ppitn     char(12);
declare p_pcitn     char(12);
declare p_cls       char(2);
declare p_srce      char(2);
declare p_itcls     char(2);
declare p_itsrce    char(2);
declare p_sumphqt   numeric(15,4);
declare p_ohqt      numeric(15,4);
declare p_qty1      numeric(8,3);
declare p_lolevel   integer;
declare p_chkint    integer;
declare p_rtn       char(1);
declare at_end integer default 0;
declare not_found condition for '02000';

-- Summary wfphqt to item having dept '9999'
declare wip_006_summary Cursor for
  select aa.wfitno, sum(wfphqt)
  from pbwip.wip006 aa, pbinv.inv101 bb
  where aa.wfcmcd = bb.comltd and aa.wfplant = bb.xplant and
    aa.wfdvsn = bb.div and aa.wfitno = bb.itno and
    aa.wfyear = a_year and
    aa.wfmonth = a_month and aa.wfcmcd = a_cmcd and
    aa.wfplant = a_plant and aa.wfdvsn = a_dvsn and
    aa.wfdept <> '9999'
  group by aa.wfitno;

declare continue handler for not_found
        set at_end = 1;

-- check pbwip.wip006 whether wfdept is not '9999'
select count(*) into p_chkint
from pbwip.wip006
where wfyear = a_year and wfmonth = a_month and
      wfcmcd = a_cmcd and wfplant = a_plant and
      wfdvsn = a_dvsn and wfdept <> '9999';
if p_chkint < 1 then
  return;
end if;
-- update wfohqt, wfphqt having 0
delete from pbwip.wip006
where wfyear = a_year and wfmonth = a_month and
      wfcmcd = a_cmcd and wfplant = a_plant and
      wfdvsn = a_dvsn and wfdept = '9999';

set at_end = 0;
-- Step1 : summary wfphqt
open wip_006_summary;
inc_loop:
loop
  fetch wip_006_summary into p_itno, p_sumphqt;
  if sqlcode <> 0 or at_end = 1 then
    leave inc_loop;
  end if;

  INSERT INTO PBWIP.WIP006(WFYEAR,WFMONTH,WFCMCD,WFPLANT,WFDVSN,
    WFDEPT,WFITNO,WFSERIAL,WFDEPTNM,WFITNM,WFSPEC,WFPDCD,WFPDNM,
    WFUNIT,WFOHQT,WFPHQT,WFSTSCD,WFEXTD,WFIPADDR,WFMACADDR,
    WFINPTDT,WFUPDTDT)
  select a_year, a_month, bb.comltd, bb.xplant, bb.div,
    '9999', bb.itno,0,' ',' ',' ',substring(bb.pdcd,1,2),' ',
    bb.xunit, 0, p_sumphqt, 'A', ' ', ' ', ' ', a_empno, a_inputdate
    from pbinv.inv101 bb
    where bb.comltd = a_cmcd and bb.xplant = a_plant and
      bb.div = a_dvsn and bb.itno = p_itno;

end loop;
close wip_006_summary;

-- update wfohqt, wfphqt having 0
update pbwip.wip006
set wfohqt = 0, wfextd = ' ', wfinptdt = a_empno, wfupdtdt = a_inputdate
where wfyear = a_year and wfmonth = a_month and
      wfcmcd = a_cmcd and wfplant = a_plant and
      wfdvsn = a_dvsn and wfdept = '9999';

end
