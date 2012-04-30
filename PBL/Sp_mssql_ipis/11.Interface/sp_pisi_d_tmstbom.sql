-- 수정할것!!!
/*
	File Name	: sp_pisi_d_tmstbom.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisi_d_tmstbom
	Description	: Download BOM - 매일
			  tmstbom
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 11. 12
	Author		: Gary Kim
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisi_d_tmstbom]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisi_d_tmstbom]
GO

/*
Execute sp_pisi_d_tmstbom
*/

Create Procedure sp_pisi_d_tmstbom
	
As
Begin

-- 대구 전장
exec [ipisele_svr\ipis].ipis.dbo.sp_pisi_truncate_table 'tmstbom'

insert into [ipisele_svr\ipis].ipis.dbo.tmstbom
	(AreaCode,	DivisionCode,	BOMPItemNo,	Routing,		BOMCItemNo,
	BOMChangeDate,	
	BOMLUnit,	BOMEUnit,	BOMWorkCenter,	
	ApplyFrom,
	ApplyTo,		
	BOMDivisionCode, CostGubun,	EBOMExistFlag,
	BOMFirstInputDate, 
	Empno,	LastEmp)
select 	plant,		pdvsn,		ppitn,		prout,		pcitn,
	substring(pchdt, 1, 4)+'.'+substring(pchdt, 5, 2)+'.'+substring(pchdt, 7,2),
	pqtym,		pqtye,		pwkct,
	case 
		when pedtm = '' then '1900.01.01'
		else substring(pedtm, 1, 4)+'.'+substring(pedtm, 5, 2)+'.'+substring(pedtm, 7,2)
		end,
	case
		when pedte = '' then '9999.12.31'
		else substring(pedte, 1, 4)+'.'+substring(pedte, 5, 2)+'.'+substring(pedte, 7,2)
		end,
	pexdv,		poscd,		pebst,
	substring(pindt, 1, 4)+'.'+substring(pindt, 5, 2)+'.'+substring(pindt, 7,2),
	pemno,	'SYSTEM'
from	tmisbom
where	plant = 'D'
and	pdvsn in ('A')


-- 대구 기계
exec [ipismac_svr\ipis].ipis.dbo.sp_pisi_truncate_table 'tmstbom'

insert into [ipismac_svr\ipis].ipis.dbo.tmstbom
	(AreaCode,	DivisionCode,	BOMPItemNo,	Routing,		BOMCItemNo,
	BOMChangeDate,	
	BOMLUnit,	BOMEUnit,	BOMWorkCenter,	
	ApplyFrom,
	ApplyTo,		
	BOMDivisionCode, CostGubun,	EBOMExistFlag,
	BOMFirstInputDate, 
	Empno,	LastEmp)
select 	plant,		pdvsn,		ppitn,		prout,		pcitn,
	substring(pchdt, 1, 4)+'.'+substring(pchdt, 5, 2)+'.'+substring(pchdt, 7,2),
	pqtym,		pqtye,		pwkct,
	case 
		when pedtm = '' then '1900.01.01'
		else substring(pedtm, 1, 4)+'.'+substring(pedtm, 5, 2)+'.'+substring(pedtm, 7,2)
		end,
	case
		when pedte = '' then '9999.12.31'
		else substring(pedte, 1, 4)+'.'+substring(pedte, 5, 2)+'.'+substring(pedte, 7,2)
		end,
	pexdv,		poscd,		pebst,
	substring(pindt, 1, 4)+'.'+substring(pindt, 5, 2)+'.'+substring(pindt, 7,2),
	pemno,	'SYSTEM'
from	tmisbom
where	plant = 'D'
and	pdvsn in ('M','S')


-- 대구 공조
exec [ipishvac_svr\ipis].ipis.dbo.sp_pisi_truncate_table 'tmstbom'

insert into [ipishvac_svr\ipis].ipis.dbo.tmstbom
	(AreaCode,	DivisionCode,	BOMPItemNo,	Routing,		BOMCItemNo,
	BOMChangeDate,	
	BOMLUnit,	BOMEUnit,	BOMWorkCenter,	
	ApplyFrom,
	ApplyTo,		
	BOMDivisionCode, CostGubun,	EBOMExistFlag,
	BOMFirstInputDate, 
	Empno,	LastEmp)
select 	plant,		pdvsn,		ppitn,		prout,		pcitn,
	substring(pchdt, 1, 4)+'.'+substring(pchdt, 5, 2)+'.'+substring(pchdt, 7,2),
	pqtym,		pqtye,		pwkct,
	case 
		when pedtm = '' then '1900.01.01'
		else substring(pedtm, 1, 4)+'.'+substring(pedtm, 5, 2)+'.'+substring(pedtm, 7,2)
		end,
	case
		when pedte = '' then '9999.12.31'
		else substring(pedte, 1, 4)+'.'+substring(pedte, 5, 2)+'.'+substring(pedte, 7,2)
		end,
	pexdv,		poscd,		pebst,
	substring(pindt, 1, 4)+'.'+substring(pindt, 5, 2)+'.'+substring(pindt, 7,2),
	pemno,	'SYSTEM'
from	tmisbom
where	(plant = 'D' and pdvsn in ('H','V')) or plant = 'K'


-- 진천
exec [ipisjin_svr].ipis.dbo.sp_pisi_truncate_table 'tmstbom'

insert into [ipisjin_svr].ipis.dbo.tmstbom
	(AreaCode,	DivisionCode,	BOMPItemNo,	Routing,		BOMCItemNo,
	BOMChangeDate,	
	BOMLUnit,	BOMEUnit,	BOMWorkCenter,	
	ApplyFrom,
	ApplyTo,		
	BOMDivisionCode, CostGubun,	EBOMExistFlag,
	BOMFirstInputDate, 
	Empno,	LastEmp)
select 	plant,		pdvsn,		ppitn,		prout,		pcitn,
	substring(pchdt, 1, 4)+'.'+substring(pchdt, 5, 2)+'.'+substring(pchdt, 7,2),
	pqtym,		pqtye,		pwkct,
	case 
		when pedtm = '' then '1900.01.01'
		else substring(pedtm, 1, 4)+'.'+substring(pedtm, 5, 2)+'.'+substring(pedtm, 7,2)
		end,
	case
		when pedte = '' then '9999.12.31'
		else substring(pedte, 1, 4)+'.'+substring(pedte, 5, 2)+'.'+substring(pedte, 7,2)
		end,
	pexdv,		poscd,		pebst,
	substring(pindt, 1, 4)+'.'+substring(pindt, 5, 2)+'.'+substring(pindt, 7,2),
	pemno,	'SYSTEM'
from	tmisbom
where	plant = 'J'
 
End		-- Procedure End
Go
