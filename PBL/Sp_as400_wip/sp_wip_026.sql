-- file name : sp_wip_026
-- procedure name : pbwip.sp_wip_026
-- desc : WIP009 Calculate Claim

drop procedure pbwip.sp_wip_026;
create procedure pbwip.sp_wip_026 (
in a_cmcd   varchar(2),
in a_year   varchar(4),
in a_month  varchar(2),
in a_plant  varchar(1),
in a_dvsn   varchar(1),
in a_vendor varchar(5),
in a_ipaddr varchar(30),
in a_macaddr varchar(30),
in a_inptdt varchar(8),
in a_updtdt varchar(8))
language sql
begin
declare sqlcode integer default 0;
declare sqlstate char(5) default '00000';
declare p_itno     char(15);
declare p_scrp     numeric(5,2);
declare p_retn     numeric(5,2);
declare p_avrg     numeric(15,5);
declare p_ohqt     numeric(15,4);
declare p_ohat     numeric(11,0);
declare p_phqt     numeric(15,4);
declare p_phat     numeric(11,0);
declare p_usqt     numeric(15,4);
declare p_diffqt   numeric(15,4);
declare p_diffat   numeric(11,0);
declare p_usqt7    numeric(15,4);
declare p_usat7    numeric(11,0);
declare p_lautqt   numeric(15,4);
declare p_lautat   numeric(11,0);
declare p_rautqt   numeric(15,4);
declare p_rautat   numeric(11,0);
declare p_clqt     numeric(15,4);
declare p_clat     numeric(11,0);
declare p_unit     char(2);
declare retcode    integer default 0;

--Get input, use, on hand data
declare cal_claim cursor for
  select wfitno,wfscrp,wfretn,wfavrg,wfusqt1,
    wfusqt3,wfohqt,wfohat,wfphqt,wfunit
  from pbwip.wip009
  where wfyear = a_year and wfmonth = a_month and
        wfcmcd = a_cmcd and wfplant = a_plant and
        wfdvsn = a_dvsn and wfvendor = a_vendor and
        wfiocd = '2';

declare continue handler for sqlexception
  set retcode=sqlcode;
declare continue handler for sqlwarning
  set retcode=sqlcode;
declare continue handler for not found
  set retcode = 1;

--initialize data
update pbwip.wip009
  set wfphat = 0, wfdefqt = 0,
      wfdefat = 0, wflautqt = 0,
      wflautat = 0, wfrautqt = 0,
      wfrautat = 0, wfclqt = 0,
      wfclat = 0
  where wfyear = a_year and wfmonth = a_month and
        wfcmcd = a_cmcd and wfplant = a_plant and
        wfdvsn = a_dvsn and wfvendor = a_vendor and
        wfiocd = '2';

-- First Step
open cal_claim;
inc_loop:
loop
  fetch cal_claim into p_itno,p_scrp,p_retn,p_avrg,
    p_usqt, p_usqt7, p_ohqt, p_ohat, p_phqt, p_unit;
  if retcode = 1 then
    leave inc_loop;
  end if;
  -- initialize data
  set p_phat = 0;
  set p_diffqt = 0;
  set p_diffat = 0;
  set p_lautqt = 0;
  set p_lautat = 0;
  set p_rautqt = 0;
  set p_rautat = 0;
  set p_clqt = 0;
  set p_clat = 0;
  -- calculate phat
  set p_phat = decimal((p_phqt * p_avrg),11,0);
  -- calculate diffqty
  set p_diffqt = (p_ohqt - p_phqt);
  set p_diffat = (p_ohat - p_phat);
  -- calculate lautqty
  if p_usqt > 0 then
    set p_lautqt = p_usqt * decimal((p_scrp / 100),15,4);
  else
    set p_lautqt = 0;
  end if;
  set p_lautat = decimal((p_lautqt * p_avrg),11,0);
  -- calculate rautqty
  if p_lautqt < ( p_usqt7 + p_diffqt ) then
    set p_rautqt = p_lautqt *
        decimal((p_retn / 100),15,4);
  else
    set p_rautqt = ( p_usqt7 + p_diffqt )
            * decimal((p_retn / 100),15,4);
  end if;
  set p_rautat = decimal((p_rautqt * p_avrg),11,0);
  -- calculate claim
  if (p_usqt7 + p_diffqt) > 0 then
    if ((p_usqt7 + p_diffqt) - p_lautqt) > 0 then
      if p_usqt7 < p_rautqt then
        set p_clqt = (p_usqt7 + p_diffqt) - p_lautqt
              + (p_rautqt - p_usqt7);
      else
        set p_clqt = (p_usqt7 + p_diffqt) - p_lautqt;
      end if;
    else
      if p_usqt7 < p_rautqt then
        set p_clqt = p_rautqt - p_usqt7;
      else
        set p_clqt = 0;
      end if;
    end if;
  else
    set p_clqt = p_usqt7 + p_diffqt - p_lautqt;
  end if;
  if p_unit = 'EA' then
    set p_clqt = CEILING(p_clqt);
  end if;
  set p_clat = decimal((p_clqt * p_avrg),11,0);
  -- Result Data Update
  update pbwip.wip009
  set wfphat = p_phat, wfdefqt = p_diffqt,
      wfdefat = p_diffat, wflautqt = p_lautqt,
      wflautat = p_lautat, wfrautqt = p_rautqt,
      wfrautat = p_rautat, wfclqt = p_clqt,
      wfclat = p_clat, wfstscd = '3',
      wfipaddr = a_ipaddr,
      wfmacaddr = a_macaddr, wfupdtdt = a_updtdt
  where wfyear = a_year and wfmonth = a_month and
        wfcmcd = a_cmcd and wfplant = a_plant and
        wfdvsn = a_dvsn and wfvendor = a_vendor and
        wfitno = p_itno and wfiocd = '2';
  if sqlcode <> 0 then
    leave inc_loop;
  end if;
end loop;
close cal_claim;

end
