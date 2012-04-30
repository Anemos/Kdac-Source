/*
	File Name	: sp_pisi_d_tmstrouting.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisi_d_tmstrouting
	Description	: Download Monthly Plan(월간생산계획) - 월 1회
			  tplanmonth	
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 11. 12
	Author		: Gary Kim
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisi_d_tmstrouting]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisi_d_tmstrouting]
GO

/*
Execute sp_pisi_d_tmstrouting
*/

Create Procedure sp_pisi_d_tmstrouting

	
As
Begin

-- 대구전장
insert into [ipisele_svr\ipis].ipis.dbo.tmstrouting
	(AreaCode,		DivisionCode, 		ItemCode,	SubLineCode,	SubLineNo,              
	ProcessNo,		ApplyDate,                                                                      
	ProcessName,		ProcessSeq,		WorkCenter,	GradeGubun,	MCGubun,                
	BaseMCWorkTime,	BaseManualWorkTime,	BaseWorkTime,	SideGubun,	                                
	SideMCWorkTime,	SideManualWorkTime,	EmpCount,	LastEmp)                                        
select	rcplant,			rcdvsn,			rcitno,		rcline1,		rcline2,
	rcopno,			substring(rcedfm, 1, 4)+'.'+substring(rcedfm, 5, 2)+'.'+substring(rcedfm, 7,2), 
	ltrim(rtrim(rcopnm)),			rcopsq,			rcline3,		rcgrde,		rcmcyn,         
	rcbmtm,			rcbltm,			rcbstm,		rcnvcd,                                 
	rcnvmc,			rcnvlb,			rclbcnt,		'SYSTEM'                        
from	tmisrouting
where	rcplant = 'D'
and	rcdvsn in ('A')
and	rcitno not in (select distinct itemcode from [ipisele_svr\ipis].ipis.dbo.tmstrouting
			where areacode = 'D' and divisioncode in ('A') )

insert into [ipisele_svr\ipis].ipis.dbo.tmstrouting
	(AreaCode,		DivisionCode, 		ItemCode,	SubLineCode,	SubLineNo,              
	ProcessNo,		ApplyDate,                                                                      
	ProcessName,		ProcessSeq,		WorkCenter,	GradeGubun,	MCGubun,                
	BaseMCWorkTime,	BaseManualWorkTime,	BaseWorkTime,	SideGubun,	                                
	SideMCWorkTime,	SideManualWorkTime,	EmpCount,	LastEmp)                                        
select	distinct rcplant,			rcdvsn,			raitno1,		rcline1,		rcline2,
	rcopno,			substring(rcedfm, 1, 4)+'.'+substring(rcedfm, 5, 2)+'.'+substring(rcedfm, 7,2), 
	ltrim(rtrim(rcopnm)),			rcopsq,			rcline3,		rcgrde,		rcmcyn,         
	rcbmtm,			rcbltm,			rcbstm,		rcnvcd,                                 
	rcnvmc,			rcnvlb,			rclbcnt,		'SYSTEM'  
from	tmisrouting a, tmisrouting_subitem b
where	rcplant = raplant
and	rcdvsn = radvsn
and	rcitno = raitno
and	rcplant = 'D'
and	rcdvsn in ('A')
and	raitno1 not in (select distinct itemcode from [ipisele_svr\ipis].ipis.dbo.tmstrouting
			where areacode = 'D' and divisioncode in ('A') )

-- 대구기계
insert into [ipismac_svr\ipis].ipis.dbo.tmstrouting
	(AreaCode,		DivisionCode, 		ItemCode,	SubLineCode,	SubLineNo,              
	ProcessNo,		ApplyDate,                                                                      
	ProcessName,		ProcessSeq,		WorkCenter,	GradeGubun,	MCGubun,                
	BaseMCWorkTime,	BaseManualWorkTime,	BaseWorkTime,	SideGubun,	                                
	SideMCWorkTime,	SideManualWorkTime,	EmpCount,	LastEmp)                                        
select	rcplant,			rcdvsn,			rcitno,		rcline1,		rcline2,
	rcopno,			substring(rcedfm, 1, 4)+'.'+substring(rcedfm, 5, 2)+'.'+substring(rcedfm, 7,2), 
	ltrim(rtrim(rcopnm)),			rcopsq,			rcline3,		rcgrde,		rcmcyn,         
	rcbmtm,			rcbltm,			rcbstm,		rcnvcd,                                 
	rcnvmc,			rcnvlb,			rclbcnt,		'SYSTEM'                        
from	tmisrouting
where	rcplant = 'D'
and	rcdvsn in ('M','S')
and	rcitno not in (select distinct itemcode from [ipismac_svr\ipis].ipis.dbo.tmstrouting
			where areacode = 'D' and divisioncode in ('M','S') )

insert into [ipismac_svr\ipis].ipis.dbo.tmstrouting
	(AreaCode,		DivisionCode, 		ItemCode,	SubLineCode,	SubLineNo,              
	ProcessNo,		ApplyDate,                                                                      
	ProcessName,		ProcessSeq,		WorkCenter,	GradeGubun,	MCGubun,                
	BaseMCWorkTime,	BaseManualWorkTime,	BaseWorkTime,	SideGubun,	                                
	SideMCWorkTime,	SideManualWorkTime,	EmpCount,	LastEmp)                                        
select	distinct rcplant,			rcdvsn,			raitno1,		rcline1,		rcline2,
	rcopno,			substring(rcedfm, 1, 4)+'.'+substring(rcedfm, 5, 2)+'.'+substring(rcedfm, 7,2), 
	ltrim(rtrim(rcopnm)),			rcopsq,			rcline3,		rcgrde,		rcmcyn,         
	rcbmtm,			rcbltm,			rcbstm,		rcnvcd,                                 
	rcnvmc,			rcnvlb,			rclbcnt,		'SYSTEM'  
from	tmisrouting a, tmisrouting_subitem b
where	rcplant = raplant
and	rcdvsn = radvsn
and	rcitno = raitno
and	rcplant = 'D'
and	rcdvsn in ('M','S')
and	raitno1 not in (select distinct itemcode from [ipismac_svr\ipis].ipis.dbo.tmstrouting
			where areacode = 'D' and divisioncode in ('M','S') )

-- 진천
insert into [ipisjin_svr].ipis.dbo.tmstrouting
	(AreaCode,		DivisionCode, 		ItemCode,	SubLineCode,	SubLineNo,              
	ProcessNo,		ApplyDate,                                                                      
	ProcessName,		ProcessSeq,		WorkCenter,	GradeGubun,	MCGubun,                
	BaseMCWorkTime,	BaseManualWorkTime,	BaseWorkTime,	SideGubun,	                                
	SideMCWorkTime,	SideManualWorkTime,	EmpCount,	LastEmp)                                        
select	rcplant,			rcdvsn,			rcitno,		rcline1,		rcline2,
	rcopno,			substring(rcedfm, 1, 4)+'.'+substring(rcedfm, 5, 2)+'.'+substring(rcedfm, 7,2), 
	ltrim(rtrim(rcopnm)),			rcopsq,			rcline3,		rcgrde,		rcmcyn,         
	rcbmtm,			rcbltm,			rcbstm,		rcnvcd,                                 
	rcnvmc,			rcnvlb,			rclbcnt,		'SYSTEM'                        
from	tmisrouting
where	rcplant = 'J'
and	rcitno not in (select distinct itemcode from [ipisjin_svr].ipis.dbo.tmstrouting
			where areacode = 'J')

insert into [ipisjin_svr].ipis.dbo.tmstrouting
	(AreaCode,		DivisionCode, 		ItemCode,	SubLineCode,	SubLineNo,              
	ProcessNo,		ApplyDate,                                                                      
	ProcessName,		ProcessSeq,		WorkCenter,	GradeGubun,	MCGubun,                
	BaseMCWorkTime,	BaseManualWorkTime,	BaseWorkTime,	SideGubun,	                                
	SideMCWorkTime,	SideManualWorkTime,	EmpCount,	LastEmp)                                        
select	distinct rcplant,			rcdvsn,			raitno1,		rcline1,		rcline2,
	rcopno,			substring(rcedfm, 1, 4)+'.'+substring(rcedfm, 5, 2)+'.'+substring(rcedfm, 7,2), 
	ltrim(rtrim(rcopnm)),			rcopsq,			rcline3,		rcgrde,		rcmcyn,         
	rcbmtm,			rcbltm,			rcbstm,		rcnvcd,                                 
	rcnvmc,			rcnvlb,			rclbcnt,		'SYSTEM'  
from	tmisrouting a, tmisrouting_subitem b
where	rcplant = raplant
and	rcdvsn = radvsn
and	rcitno = raitno
and	rcplant = 'J'
and	raitno1 not in (select distinct itemcode from [ipisjin_svr].ipis.dbo.tmstrouting
			where areacode = 'J')

-- 대구공조
insert into [ipishvac_svr\ipis].ipis.dbo.tmstrouting
	(AreaCode,		DivisionCode, 		ItemCode,	SubLineCode,	SubLineNo,              
	ProcessNo,		ApplyDate,                                                                      
	ProcessName,		ProcessSeq,		WorkCenter,	GradeGubun,	MCGubun,                
	BaseMCWorkTime,	BaseManualWorkTime,	BaseWorkTime,	SideGubun,	                                
	SideMCWorkTime,	SideManualWorkTime,	EmpCount,	LastEmp)                                        
select	rcplant,			rcdvsn,			rcitno,		rcline1,		rcline2,
	rcopno,			substring(rcedfm, 1, 4)+'.'+substring(rcedfm, 5, 2)+'.'+substring(rcedfm, 7,2), 
	ltrim(rtrim(rcopnm)),			rcopsq,			rcline3,		rcgrde,		rcmcyn,         
	rcbmtm,			rcbltm,			rcbstm,		rcnvcd,                                 
	rcnvmc,			rcnvlb,			rclbcnt,		'SYSTEM'                        
from	tmisrouting
where	rcplant = 'D'
and	rcdvsn in ('H','V')
and	rcitno not in (select distinct itemcode from [ipishvac_svr\ipis].ipis.dbo.tmstrouting
			where areacode = 'D' and divisioncode in ('H','V') )

insert into [ipishvac_svr\ipis].ipis.dbo.tmstrouting
	(AreaCode,		DivisionCode, 		ItemCode,	SubLineCode,	SubLineNo,              
	ProcessNo,		ApplyDate,                                                                      
	ProcessName,		ProcessSeq,		WorkCenter,	GradeGubun,	MCGubun,                
	BaseMCWorkTime,	BaseManualWorkTime,	BaseWorkTime,	SideGubun,	                                
	SideMCWorkTime,	SideManualWorkTime,	EmpCount,	LastEmp)                                        
select	distinct rcplant,			rcdvsn,			raitno1,		rcline1,		rcline2,
	rcopno,			substring(rcedfm, 1, 4)+'.'+substring(rcedfm, 5, 2)+'.'+substring(rcedfm, 7,2), 
	ltrim(rtrim(rcopnm)),			rcopsq,			rcline3,		rcgrde,		rcmcyn,         
	rcbmtm,			rcbltm,			rcbstm,		rcnvcd,                                 
	rcnvmc,			rcnvlb,			rclbcnt,		'SYSTEM'  
from	tmisrouting a, tmisrouting_subitem b
where	rcplant = raplant
and	rcdvsn = radvsn
and	rcitno = raitno
and	rcplant = 'D'
and	rcdvsn in ('H','V')
and	raitno1 not in (select distinct itemcode from [ipishvac_svr\ipis].ipis.dbo.tmstrouting
			where areacode = 'D' and divisioncode in ('H','V') )
 
End		-- Procedure End
Go
