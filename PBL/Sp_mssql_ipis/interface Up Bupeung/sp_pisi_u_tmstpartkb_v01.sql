/*
	File Name	: sp_pisi_u_tmstpartkb.SQL
	SYSTEM		: KDAC ���� ���� ���� �ý���
	Procedure Name	: sp_pisi_u_tmstpartkb
	Description	: Upload tmstpartkb(���簣�� update) 
			  tmstpartkb
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 02. 12  2007.12.4
	Author		: Gary Kim      Kiss Kim
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisi_u_tmstpartkb]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisi_u_tmstpartkb]
GO

/*
Execute sp_pisi_u_tmstpartkb
*/

Create Procedure sp_pisi_u_tmstpartkb

	
As
Begin

truncate table tmstpartkb
-- �뱸����

insert into tmstpartkb
select AreaCode, DivisionCode, SupplierCode, ItemCode, ApplyFrom, PartType, 
ChangeFlag, PartModelID, PartID, UseCenterGubun, UseCenter, CostGubun, RackQty, RackCode, 
StockGubun, ReceiptLocation, MailBoxNo, SafetyStock, UseFlag, AutoReorderFlag, KBUseFlag, 
ChangeDate, NormalKBSN, TempKBSN, PartKBPrintCount, PartKBActiveCount, PartKBPlanCount, 
BuyBackFlag, LastEmp, LastDate
from [ipisele_svr\ipis].ipis.dbo.tmstpartkbhis
where applyfrom <= convert(char(10),dateadd(dd,1,getdate()),102) and applyto >= convert(char(10),dateadd(dd,1,getdate()),102)


-- �뱸���

insert into tmstpartkb
select AreaCode, DivisionCode, SupplierCode, ItemCode, ApplyFrom, PartType, 
ChangeFlag, PartModelID, PartID, UseCenterGubun, UseCenter, CostGubun, RackQty, RackCode, 
StockGubun, ReceiptLocation, MailBoxNo, SafetyStock, UseFlag, AutoReorderFlag, KBUseFlag, 
ChangeDate, NormalKBSN, TempKBSN, PartKBPrintCount, PartKBActiveCount, PartKBPlanCount, 
BuyBackFlag, LastEmp, LastDate
from [ipismac_svr\ipis].ipis.dbo.tmstpartkbhis
where applyfrom <= convert(char(10),dateadd(dd,1,getdate()),102) and applyto >= convert(char(10),dateadd(dd,1,getdate()),102)

-- �뱸����

insert into tmstpartkb
select AreaCode, DivisionCode, SupplierCode, ItemCode, ApplyFrom, PartType, 
ChangeFlag, PartModelID, PartID, UseCenterGubun, UseCenter, CostGubun, RackQty, RackCode, 
StockGubun, ReceiptLocation, MailBoxNo, SafetyStock, UseFlag, AutoReorderFlag, KBUseFlag, 
ChangeDate, NormalKBSN, TempKBSN, PartKBPrintCount, PartKBActiveCount, PartKBPlanCount, 
BuyBackFlag, LastEmp, LastDate
from [ipishvac_svr\ipis].ipis.dbo.tmstpartkbhis
where applyfrom <= convert(char(10),dateadd(dd,1,getdate()),102) and applyto >= convert(char(10),dateadd(dd,1,getdate()),102)

-- ��õ

insert into tmstpartkb
select AreaCode, DivisionCode, SupplierCode, ItemCode, ApplyFrom, PartType, 
ChangeFlag, PartModelID, PartID, UseCenterGubun, UseCenter, CostGubun, RackQty, RackCode, 
StockGubun, ReceiptLocation, MailBoxNo, SafetyStock, UseFlag, AutoReorderFlag, KBUseFlag, 
ChangeDate, NormalKBSN, TempKBSN, PartKBPrintCount, PartKBActiveCount, PartKBPlanCount, 
BuyBackFlag, LastEmp, LastDate
from [ipisjin_svr].ipis.dbo.tmstpartkbhis
where applyfrom <= convert(char(10),dateadd(dd,1,getdate()),102) and applyto >= convert(char(10),dateadd(dd,1,getdate()),102)

End		-- Procedure End
Go
