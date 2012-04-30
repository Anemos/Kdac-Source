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
in a_adjdate  char(8),
in a_itno     char(12),
in a_phqt     numeric(15,4),
in a_cls      char(2),
in a_srce     char(2),
in a_empno    char(6),
in a_inputdate char(8))
language sql
begin
declare sqlcode integer default 0;
declare p_ppitn     char(15);
declare p_pcitn     char(15);
declare p_itcls     char(2);
declare p_itsrce    char(2);
declare p_convqty   numeric(13,4);
declare p_qty1      numeric(8,3);
declare p_chkint    integer;
declare p_rtn       char(1);
declare at_end integer default 0;
declare not_found condition for '02000';

-- SetUp Knock-Down Qty
declare wip_006_setup Cursor for
  select tpitn,tcitn,tqty1,cls,srce,convqty
  from qtemp.bomtemp02, pbinv.inv101
  where tcmcd = a_cmcd and tplnt = a_plant and
        tdvsn = a_dvsn and tcmcd = comltd and
        tplnt = xplant and tdvsn = div and tcitn = itno and
        ( cls = '10' or cls = '40' or cls = '50') and
        topcd <> '2';

declare continue handler for not_found
        set at_end = 1;

--step1 : knock-down
set at_end = 0;
if a_cls = '50' and a_srce = '04' then
  set p_rtn = pbwip.sf_wip_006(a_cmcd,a_plant,a_dvsn,
    a_itno,a_adjdate,'I','Y');
else
  set p_rtn = pbwip.sf_wip_006(a_cmcd,a_plant,a_dvsn,
    a_itno,a_adjdate,'H','Y');
end if;

if p_rtn <> 'Y' then
  update pbwip.wip006
  set wfextd = 'N', wfinptdt = a_empno, wfupdtdt = a_inputdate
  where wfyear = a_year and wfmonth = a_month and
    wfcmcd = a_cmcd and wfplant = a_plant and
    wfdvsn = a_dvsn and wfitno = a_itno and
    wfdept = '9999' and wfserial = 0;
  set at_end = 1;
else
  update pbwip.wip006
  set wfextd = 'Y', wfinptdt = a_empno, wfupdtdt = a_inputdate
  where wfyear = a_year and wfmonth = a_month and
    wfcmcd = a_cmcd and wfplant = a_plant and
    wfdvsn = a_dvsn and wfitno = a_itno and
    wfdept = '9999' and wfserial = 0;
end if;

open wip_006_setup;
inc_loop:
loop
  if at_end = 1 then
    leave inc_loop;
  end if;
  fetch wip_006_setup into p_ppitn, p_pcitn, p_qty1,
    p_itcls, p_itsrce, p_convqty;
  if sqlcode <> 0 or at_end = 1 then
    leave inc_loop;
  end if;

  if a_cls = '50' and a_srce = '04' then
    if p_itcls <> '10' or p_itsrce <> '03' then
      goto inc_loop;
    end if;
  else
    if p_itcls = '10' and p_itsrce = '03' then
      goto inc_loop;
    end if;
  end if;

  -- create knock-down history
  insert into pbwip.wip012( wfyear, wfmonth, wfcmcd, wfplant,
    wfdvsn, wfpitno, wfpcls, wfpsrc, wfcitno, wfccls, wfcsrc,
    wfconvqty, wfqty1, wfpqty, wfcqty, chgdate )
  values ( a_year, a_month, a_cmcd, a_plant,
    a_dvsn, a_itno, a_cls, a_srce, p_pcitn, p_itcls, p_itsrce,
    p_convqty, p_qty1, a_phqt, decimal( a_phqt * p_qty1,15,4),
    char(CURRENT TIMESTAMP) );

  select count(*) into p_chkint
  from pbwip.wip006
  where wfyear = a_year and wfmonth = a_month and
    wfcmcd = a_cmcd and wfplant = a_plant and
    wfdvsn = a_dvsn and wfitno = p_pcitn and
  wfdept = '9999' and wfserial = 0;

  if p_chkint > 0 then
    update pbwip.wip006
    set wfohqt = (wfohqt + decimal( a_phqt * p_qty1, 15, 4))
    where wfyear = a_year and wfmonth = a_month and
      wfcmcd = a_cmcd and wfplant = a_plant and
      wfdvsn = a_dvsn and wfitno = p_pcitn and
      wfdept = '9999' and wfserial = 0;
  else
    INSERT INTO PBWIP.WIP006(WFYEAR,WFMONTH,WFCMCD,WFPLANT,WFDVSN,
    WFDEPT,WFITNO,WFSERIAL,WFDEPTNM,WFITNM,WFSPEC,WFPDCD,WFPDNM,
    WFUNIT,WFOHQT,WFPHQT,WFSTSCD,WFEXTD,WFIPADDR,WFMACADDR,
    WFINPTDT,WFUPDTDT)
    select a_year, a_month, '01', a_plant, a_dvsn,
      '9999', p_pcitn,0,' ',' ',' ',substring(bb.pdcd,1,2),' ',
      bb.xunit, decimal( a_phqt * p_qty1, 15, 4), 0, 'K',
      ' ', ' ', ' ', a_empno, a_inputdate
    from pbinv.inv101 bb
    where bb.comltd = a_cmcd and bb.xplant = a_plant and
      bb.div = a_dvsn and bb.itno = p_pcitn;
  end if;

end loop;
close wip_006_setup;

end
