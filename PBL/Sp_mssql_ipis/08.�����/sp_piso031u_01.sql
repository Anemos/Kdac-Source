/*
	File Name	: sp_piso031u_01.SQL
	SYSTEM		: KDAC ���� ���� ���� �ý���
	Procedure Name	: sp_piso031u_01
	Description	: �������� ����� ���� �系���� ��ü ��ȸ
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 11. 04
	Author		: Kim Jin-Su
*/


If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_piso031u_01]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_piso031u_01]
GO

/*
Execute sp_piso031u_01
	@ps_areacode		= 'D',
	@ps_divisioncode	= 'M'
select * from tmstworkcenter

*/

Create Procedure sp_piso031u_01
	@ps_areacode		char(1),		-- ����
	@ps_divisioncode	char(1)

As
Begin

Select	SupplierCode		= A.SupplierCode,
	SupplierNo		= A.SupplierNo,
	SupplierKorName		= A.SupplierKorName,
	SupplierKorShortName	= A.SupplierKorShortName,
	SupplierEngName	= SupplierEngName,
	SupplierEngShortName	= SupplierEngShortName
From	tmstsupplier	A
Where	A.SupplierInKDAC		= 'Y'

Return

End		-- Procedure End

Go