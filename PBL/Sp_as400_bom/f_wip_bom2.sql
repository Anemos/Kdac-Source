-- file name : f_wip_bom2                                                       
-- procedure name : pbwip.f_wip_bom2                                            
-- desc : bom explosion data -> line add                                                         
                                                                                
create function pbwip.f_wip_bom2 (                                              
a_comltd char(2),
a_prsrty char(8),                                                            
a_prsrno char(2),                                                             
a_prsrno1 char(2),                                                              
a_prsrno2 char(2),
a_iocd   char(1),                                                           
a_plant  char(1),                                                             
a_dvsn   char(1),
a_pitno  char(15),
a_citno  char(15),
a_slno   char(8),
a_xuse   char(2),
a_rtngub char(2),
a_prdpt  char(5),
a_chdpt  char(5),
a_prqt   numeric(11,1),
a_qty1   numeric(8,3),
a_date   char(8))                                                            
returns char(1)                                                                 
language sql                                                                    
modifies sql data                                                               
begin
declare sqlcode integer default 0;                                                                           
declare p_usqt1 numeric(15,4);
declare p_usqt2 numeric(15,4);
declare p_usqt3 numeric(15,4);
declare p_usqt7 numeric(15,4);
declare p_ohqt numeric(15,4);
declare p_chkrow char(1);
declare p_usge char(2);
declare p_chqt numeric(15,4);
declare p_serial numeric(10,0);

--Get waohqt
select wausqt1,wausqt2,wausqt7,waohqt
 into p_usqt1,p_usqt2,p_usqt3,p_usqt7,p_ohqt
 from pbwip.wip001
 where wacmcd = a_comltd and waplant = a_plant and
       wadvsn = a_dvsn and waiocd = a_iocd and
       waorct = a_chdpt and waitno = a_citno;
 if sqlcode <> 0 then
    set p_ohqt = 0;
    set p_usqt1 = 0;
    set p_usqt2 = 0;
    set p_usqt7 = 0;
    set p_chkrow = 'N';
 else
    set p_chkrow = 'Y';
 end if;
    
--Check Wip_Usage
 case a_prsrty
 when 'RS' then 
	if a_xuse <> '04' then
	 if a_rtngub = '02' then
			set p_usge = '07';
			set p_chqt = a_prqt * a_qty1;
	 else
	    set p_usge = '00';
	 end if;
	else
	 if a_rtngub <> '02' then
	    set p_usge = '02';
	    set p_chqt = -1 * a_prqt * a_qty1;
	 else
	    set p_usge = '00';
	 end if;
	end if;
 when 'IS' then
	if a_xuse = '04' then
	   set p_usge = '02';
	   set p_chqt = a_prqt * a_qty1;
	else
	   set p_usge = '00';
	end if;
 when 'RM' then
  set p_usge = '01';
  set p_chqt = a_prqt * a_qty1;
 when 'SM' then
	set p_usge = '01';
	set p_chqt = -1 * a_prqt + a_qty1;
 else
	p_usge = '00'
 end case;
 
 if p_usge = '00' then
    leave inc_loop;
 end if;
 	
 -- Update wip001
  case p_usge
   when '01' then
     set p_usqt1 = p_usqt1 + p_chqt;
     set p_ohqt = p_ohqt - p_chqt;
   when '02' then
     set p_usqt2 = p_usqt2 + p_chqt;
     set p_ohqt = p_ohqt - p_chqt;
   when '07' then
     set p_usqt7 = p_usqt7 + p_chqt;
     set p_ohqt = p_ohqt - p_chqt;
  end case;
  if p_chkrow = 'Y' then
     update pbwip.wip001
     set wausqt1 = p_usqt1,
         wausqt2 = p_usqt2,
         wausqt7 = p_usqt7,
         waohqt = p_ohqt
     where wacmcd = a_comltd and
           waplant = p_plant and
           wadvsn = p_dvsn and
           waorct = '9999' and
           waitno = p_citno;
  else
     insert into pbwip.wip001 values(
        a_comltd, a_plant, a_dvsn, a_chdpt, a_citno, a_iocd,
        0,0,0,0,0,0,0,0,0,0,p_usqt1,0,p_usqt2,0,0,0,0,0,0,0,
        0,0,p_usqt7,0,0,0,0,p_ohqt,0,0,0,0,' ',' ',' ',' ',' ');
  end if;
 -- get wip serial no
 select max(wzserno) into p_serial  
 from pbwip.wip090 
 where wzcmcd = a_comltd and wzcttp = 'SERIAL';
 if sqlcode <> 0 then
	return 'N'
 end if
 update pbwip.wip090 
	set wzserno = wzserno + 1  
	where wzcmcd = a_comltd and wzcttp = 'SERIAL';  
 if sqlcode <> 0 then
	return 'N'
 end if   
 -- Insert wip004
  insert into pbwip.wip004(wdcmcd,wdslty,wdsrno,wdplant,wddvsn,
  wdiocd,wditno,wdrvno,wddesc,wdspec,wdunit,wditcl,wdsrce,wdusge,
  wdpdcd,wdslno,wdprsrty,wdprsrno,wdprsrno1,wdprsrno2,wdprno,
  wdprdpt,wdchdpt,wddate,wdprqt,wdchqt,wdipaddr,wdmacaddr,
  wdinptid,wdupdtid,wdinptdt,wdinpttm,wdupdtdt)
  select a_comltd,'WC', p_srno, p_plant, p_dvsn, '1', p_citno,
  aa.rvno, aa.itnm, aa.spec, aa.xunit, bb.cls,bb.srce,p_usge, 
  substr(pdcd,1,2),p_slno,a_prsrty,a_prsrno,a_prsrno1,a_prsrno2,
  p_pitno, ' ','9999', p_tdte4, p_tqty4, p_chqt, ' ', ' ',
  ' ',' ', ' ', ' ', ' '
  from pbinv.inv002 aa, pbinv.inv101 bb
  where aa.comltd = bb.comltd and aa.itno = bb.itno and
        bb.comltd = a_comltd and bb.xplant = p_plant and
        bb.div = p_dvsn and bb.itno = p_citno;


                                                  
return 'Y';                                                                     
end
