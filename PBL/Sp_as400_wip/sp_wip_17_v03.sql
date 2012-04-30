-- file name : sp_wip_17
-- procedure name : pbwip.sp_wip_17
-- desc : Data Creation For Anual Qty Check

drop procedure pbwip.sp_wip_17;
create procedure pbwip.sp_wip_17 (
in a_cmcd   varchar(2),
in a_plant  varchar(1),
in a_dvsn   varchar(1),
in a_year   varchar(4),
in a_month  varchar(2))
language sql
begin
declare sqlcode integer default 0;
declare p_plant     char(1);
declare p_dvsn      char(1);
declare p_itno      char(12);
declare p_dept      char(4);
declare p_deptnm    char(30);
declare p_cls       char(2);
declare p_srce      char(2);
declare p_unit      char(2);
declare p_pdcd      char(2);
declare p_chkpdcd   char(2);
declare p_chkdept   char(4);
declare p_pdnm      char(60);
declare p_chkpdnm   char(60);
declare p_itnm      char(50);
declare p_spec      char(50);
declare p_date      char(8);
declare p_serialno  integer;
declare p_chkint    integer;
declare at_end integer default 0;
declare not_found condition for '02000';

--Get Main Item at QtyCheck Item
declare wip_001 Cursor for
  select aa.wjplant,aa.wjdvsn,aa.wjdept,aa.wjitno,
        bb.cls,bb.srce,bb.xunit,cc.prprcd,cc.prname
  from pbwip.wip011 aa, pbinv.inv101 bb, pbcommon.dac007 cc
  where aa.wjcmcd = bb.comltd and aa.wjplant = bb.xplant and
        aa.wjdvsn = bb.div and aa.wjitno = bb.itno and
        bb.comltd = cc.comltd and
        substring(bb.pdcd,1,2) = cc.prprcd and
        aa.wjyear = a_year and aa.wjmonth = a_month and
        aa.wjcmcd = a_cmcd and aa.wjplant = a_plant and
        aa.wjdvsn = a_dvsn
  order by aa.wjdept,cc.prprcd,aa.wjitno;

set p_serialno = 0;
set p_chkpdcd = ' ';
set p_chkdept = ' ';

-- Delete wip006
DELETE FROM PBWIP.WIP006
WHERE WFYEAR = a_year AND WFMONTH = a_month AND
      WFCMCD = a_cmcd AND WFPLANT = a_plant AND
      WFDVSN = a_dvsn;

-- Step : create serial no
open wip_001;
inc_loop:
loop
  fetch wip_001 into p_plant,p_dvsn,p_dept,p_itno,p_cls,p_srce,
      p_unit,p_pdcd,p_pdnm;
  if sqlcode <> 0 then
    set p_chkint = p_serialno + 20;
    while at_end = 0 do
      set p_serialno = p_serialno + 1;
      -- insert into pbwip.wip006
      INSERT INTO PBWIP.WIP006(WFYEAR,WFMONTH,WFCMCD,WFPLANT,WFDVSN,
          WFDEPT,WFITNO,WFSERIAL,WFDEPTNM,WFITNM,WFSPEC,WFPDCD,WFPDNM,
          WFUNIT,WFOHQT,WFPHQT,WFSTSCD,WFEXTD,WFIPADDR,WFMACADDR,
          WFINPTDT,WFUPDTDT)
      VALUES (a_year,a_month,a_cmcd,p_plant,p_dvsn,
          p_dept,' ',p_serialno,p_dept,' ',' ', ' ', ' ',
          ' ',0,0,'A',' ',' ',' ',' ',' ');
      if p_chkint = p_serialno then
        set at_end = 1;
      end if;
    end while;
    leave inc_loop;
  end if;
  if p_chkdept <> p_dept then
    if p_serialno = 0 then
      set p_chkdept = p_dept;
      set p_chkpdcd = p_pdcd;
      set p_chkpdnm = p_pdnm;
    else
      set p_chkint = p_serialno + 20;
      while at_end = 0 do
        set p_serialno = p_serialno + 1;
        -- insert into pbwip.wip006
        INSERT INTO PBWIP.WIP006(WFYEAR,WFMONTH,WFCMCD,WFPLANT,WFDVSN,
          WFDEPT,WFITNO,WFSERIAL,WFDEPTNM,WFITNM,WFSPEC,WFPDCD,WFPDNM,
          WFUNIT,WFOHQT,WFPHQT,WFSTSCD,WFEXTD,WFIPADDR,WFMACADDR,
          WFINPTDT,WFUPDTDT)
        VALUES (a_year,a_month,a_cmcd,p_plant,p_dvsn,
          p_chkdept,' ',p_serialno,p_dept,' ',' ',' ',' ',
          ' ',0,0,'A',' ',' ',' ',' ',' ');
        if p_chkint = p_serialno then
          set at_end = 1;
        end if;
      end while;
      set p_chkdept = p_dept;
      set p_chkpdcd = p_pdcd;
      set p_chkpdnm = p_pdnm;
      set at_end = 0;
    end if;
  end if;
  if p_plant = 'D' and p_dvsn = 'A' then
    if substring(p_itno,2,1) = 'S' then
      goto inc_loop;
    end if;
  end if;
  set p_serialno = p_serialno + 1;

  SELECT ITNM, SPEC INTO p_itnm, p_spec
  FROM PBINV.INV002 AA, PBINV.INV101 BB
  WHERE AA.COMLTD = BB.COMLTD AND AA.ITNO = BB.ITNO AND
        BB.COMLTD = a_cmcd AND BB.XPLANT = p_plant AND
        BB.DIV = p_dvsn AND BB.ITNO = p_itno;

  -- insert into pbwip.wip006
  INSERT INTO PBWIP.WIP006(WFYEAR,WFMONTH,WFCMCD,WFPLANT,WFDVSN,
    WFDEPT,WFITNO,WFSERIAL,WFDEPTNM,WFITNM,WFSPEC,WFPDCD,WFPDNM,
    WFUNIT,WFOHQT,WFPHQT,WFSTSCD,WFEXTD,WFIPADDR,WFMACADDR,
    WFINPTDT,WFUPDTDT)
  VALUES (a_year,a_month,a_cmcd,p_plant,p_dvsn,
    p_dept,p_itno,p_serialno,p_dept,p_itnm,p_spec,p_pdcd,p_pdnm,
    p_unit,0,0,'C',' ',' ',' ',' ',' ');
end loop;
--create a record having '9999' wfdept and 0 serial
INSERT INTO PBWIP.WIP006(WFYEAR,WFMONTH,WFCMCD,WFPLANT,WFDVSN,
    WFDEPT,WFITNO,WFSERIAL,WFDEPTNM,WFITNM,WFSPEC,WFPDCD,WFPDNM,
    WFUNIT,WFOHQT,WFPHQT,WFSTSCD,WFEXTD,WFIPADDR,WFMACADDR,
    WFINPTDT,WFUPDTDT)
select aa.wjyear, aa.wjmonth, aa.wjcmcd, aa.wjplant,aa.wjdvsn,
  '9999',aa.wjitno,0,' ',' ',' ',substring(bb.pdcd,1,2),' ',
   bb.xunit, 0, 0, 'A', ' ', ' ', ' ', ' ', ' '
  from ( select distinct wjyear,wjmonth,wjcmcd,
    wjplant,wjdvsn,wjitno
    from pbwip.wip011
    where wjyear = a_year and wjmonth = a_month and
      wjcmcd = a_cmcd and wjplant = a_plant and
      wjdvsn = a_dvsn ) aa, pbinv.inv101 bb
  where aa.wjcmcd = bb.comltd and aa.wjplant = bb.xplant and
        aa.wjdvsn = bb.div and aa.wjitno = bb.itno;

close wip_001;

end
