-- file name : sp_wip_172
-- procedure name : pbwip.sp_wip_172
-- desc : AnualQty KnockDown & Summary Detp to '9999'

drop procedure pbwip.sp_wip_172;
create procedure pbwip.sp_wip_172 (
in a_cmcd     char(2),
in a_plant    char(1),
in a_dvsn     char(1),
in a_year     char(4),
in a_month    char(2),
in a_adjdate  char(8))
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
declare p_toplevel  integer;
declare p_curlevel  integer;
declare p_chkint    integer;
declare p_rtn       char(1);
declare at_end integer default 0;
declare not_found condition for '02000';

-- Summary wfphqt to item having dept '9999'
declare wip_006_summary Cursor for
  select aa.wfitno, wfphqt
  from pbwip.wip006 aa, pbinv.inv101 bb
  where aa.wfcmcd = bb.comltd and aa.wfplant = bb.xplant and
    aa.wfdvsn = bb.div and aa.wfitno = bb.itno and
    aa.wfyear = a_year and
    aa.wfmonth = a_month and aa.wfcmcd = a_cmcd and
    aa.wfplant = a_plant and aa.wfdvsn = a_dvsn and
    aa.wfdept <> '9999';

-- Find Knock-Down Data
declare wip_006_down Cursor for
  select aa.wfitno, bb.cls, bb.srce, cc.lolevel
  from pbwip.wip006 aa, pbinv.inv101 bb, pbinv.inv002 cc
  where aa.wfcmcd = bb.comltd and aa.wfplant = bb.xplant and
    aa.wfdvsn = bb.div and aa.wfitno = bb.itno and
    bb.comltd = cc.comltd and bb.itno = cc.itno and
    wfyear = a_year and
    aa.wfmonth = a_month and aa.wfcmcd = a_cmcd and
    aa.wfplant = a_plant and aa.wfdvsn = a_dvsn and
    aa.wfdept = '9999' and aa.wfphqt <> 0 and
    ( bb.cls in ('30','50') or bb.srce = '03' )
  order by cc.lolevel, bb.srce;

-- SetUp Knock-Down Qty
declare wip_006_setup Cursor for
  select tpitn,tcitn,tqty1,cls,srce
  from qtemp.bomtemp02, pbinv.inv101
  where tcmcd = a_cmcd and tplnt = a_plant and
        tdvsn = a_dvsn and tcmcd = comltd and
        tplnt = xplant and tdvsn = div and tcitn = itno and
        ( cls = '10' or cls = '40' or cls = '50') and
        srce <> '03' and topcd <> '2';

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
update pbwip.wip006
set wfphqt = 0, wfohqt = 0, wfextd = ' '
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
  select count(*) into p_chkint
  from pbwip.wip006
  where wfyear = a_year and wfmonth = a_month and
    wfcmcd = a_cmcd and wfplant = a_plant and
    wfdvsn = a_dvsn and wfitno = p_itno and
    wfdept = '9999';
  if p_chkint > 0 then
    update pbwip.wip006
    set wfphqt = p_sumphqt
    where wfyear = a_year and wfmonth = a_month and
      wfcmcd = a_cmcd and wfplant = a_plant and
      wfdvsn = a_dvsn and wfitno = p_itno and
      wfdept = '9999';
  else
    INSERT INTO PBWIP.WIP006(WFYEAR,WFMONTH,WFCMCD,WFPLANT,WFDVSN,
      WFDEPT,WFITNO,WFSERIAL,WFDEPTNM,WFITNM,WFSPEC,WFPDCD,WFPDNM,
      WFUNIT,WFOHQT,WFPHQT,WFSTSCD,WFEXTD,WFIPADDR,WFMACADDR,
      WFINPTDT,WFUPDTDT)
    select a_year, a_month, bb.comltd, bb.xplant, bb.div,
      '9999', bb.itno,0,' ',' ',' ',substring(bb.pdcd,1,2),' ',
      bb.xunit, 0, p_sumphqt, 'A', ' ', ' ', ' ', ' ', ' '
    from pbinv.inv101 bb
    where bb.comltd = a_cmcd and bb.xplant = a_plant and
      bb.div = a_dvsn and bb.itno = p_itno;
  end if;
end loop;
close wip_006_summary;
set at_end = 0;
--step2 : knock-down
open wip_006_down;
inc_loop01:
loop
  fetch wip_006_down into p_itno, p_cls, p_srce, p_lolevel;
  if sqlcode <> 0 or at_end = 1 then
    leave inc_loop01;
  end if;
  if p_cls = '50' and p_srce = '04' then
    set p_rtn = pbwip.sf_wip_006(a_cmcd,a_plant,a_dvsn,
            p_itno,a_adjdate,'I','Y');
  else
    set p_rtn = pbwip.sf_wip_006(a_cmcd,a_plant,a_dvsn,
            p_itno,a_adjdate,'H','Y');
  end if;
  if p_rtn <> 'Y' then
    update pbwip.wip006
    set wfextd = 'N'
    where wfyear = a_year and wfmonth = a_month and
      wfcmcd = a_cmcd and wfplant = a_plant and
      wfdvsn = a_dvsn and wfitno = p_itno and
      wfdept = '9999';

    goto inc_loop01;
  else
    update pbwip.wip006
    set wfextd = 'Y'
    where wfyear = a_year and wfmonth = a_month and
      wfcmcd = a_cmcd and wfplant = a_plant and
      wfdvsn = a_dvsn and wfitno = p_itno and
      wfdept = '9999';
  end if;

  select (wfohqt + wfphqt) into p_sumphqt
  from pbwip.wip006
  where wfyear = a_year and wfmonth = a_month and
      wfcmcd = a_cmcd and wfplant = a_plant and
      wfdvsn = a_dvsn and wfitno = p_itno and
      wfdept = '9999';

  open wip_006_setup;
  inc_loop02:
  loop
    fetch wip_006_setup into p_ppitn, p_pcitn, p_qty1,
        p_itcls, p_itsrce;
    if sqlcode <> 0 or at_end = 1 then
      leave inc_loop02;
    end if;

    if p_cls = '50' and p_srce = '04' then
      if p_itcls <> '10' or p_itsrce <> '03' then
        goto inc_loop02;
      end if;
    end if;

    select count(*) into p_chkint
    from pbwip.wip006
    where wfyear = a_year and wfmonth = a_month and
      wfcmcd = a_cmcd and wfplant = a_plant and
      wfdvsn = a_dvsn and wfitno = p_pcitn and
      wfdept = '9999';
    if p_chkint > 0 then
      update pbwip.wip006
      set wfohqt = wfohqt + decimal( p_sumphqt * p_qty1, 15, 4)
      where wfyear = a_year and wfmonth = a_month and
        wfcmcd = a_cmcd and wfplant = a_plant and
        wfdvsn = a_dvsn and wfitno = p_pcitn and
        wfdept = '9999';
    else
      INSERT INTO PBWIP.WIP006(WFYEAR,WFMONTH,WFCMCD,WFPLANT,WFDVSN,
        WFDEPT,WFITNO,WFSERIAL,WFDEPTNM,WFITNM,WFSPEC,WFPDCD,WFPDNM,
        WFUNIT,WFOHQT,WFPHQT,WFSTSCD,WFEXTD,WFIPADDR,WFMACADDR,
        WFINPTDT,WFUPDTDT)
      select a_year, a_month, bb.comltd, bb.xplant, bb.div,
        '9999', bb.itno,0,' ',' ',' ',substring(bb.pdcd,1,2),' ',
        bb.xunit, decimal( p_sumphqt * p_qty1, 15, 4), 0, 'K',
        ' ', ' ', ' ', ' ', ' '
      from pbinv.inv101 bb
      where bb.comltd = a_cmcd and bb.xplant = a_plant and
        bb.div = a_dvsn and bb.itno = p_pcitn;
    end if;

  end loop;
  close wip_006_setup;
  set at_end = 0;

end loop;
close wip_006_down;

-- End Step : Total Summary Job
update pbwip.wip006
set wfphqt = wfphqt + wfohqt
where wfyear = a_year and wfmonth = a_month and
      wfcmcd = a_cmcd and wfplant = a_plant and
      wfdvsn = a_dvsn and wfdept = '9999';

end
