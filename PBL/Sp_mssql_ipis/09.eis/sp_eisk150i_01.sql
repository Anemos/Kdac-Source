/*
	File Name	: sp_eisk150i_01.SQL
	SYSTEM		: KDAC ���� ���� ���� �ý���
	Procedure Name	: sp_eisk150i_01
	Description	: �ð��뺰 ��������(���庰)
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: 
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 
	Author		: Kim Jin-Su
*/


If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_eisk150i_01]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_eisk150i_01]
GO

/*
Execute sp_eisk150i_01 '2002.12.18', 'D', '%'

select * from vmstline

select sum(prdqty) from tlotno

insert tprdtime
select * from [ipisele_svr\ipis].ipis.dbo.tprdtime


Select	LTrim(RTrim(A.AUTAREA))
From	tmstpassword	A
Where	A.EMP_NO	= 'IPIS'

*/

Create Procedure sp_eisk150i_01
	@ps_prddate		char(10),
	@ps_areacode		char(1),
	@ps_divisioncode	char(1)

As
Begin

-- ���κ� ������ ������
Select	AreaCode	= A.AreaCode,		-- �����ڵ�
	DivisionCode	= A.DivisionCode,		-- ����
	WorkCenter	= A.WorkCenter,		-- Work Center
	LineCode	= A.LineCode,		-- ����
	ApplyFrom	= A.ApplyFrom,
	TimeCode	= A.TimeCode,
	PrdQty		= Sum(IsNull(A.PrdQty, 0))
Into	#tmp_prd
From	tprdtime		A
Where	A.PrdDate	= @ps_prddate		And
	A.AreaCode	= @ps_areacode		And
	A.DivisionCode	Like @ps_divisioncode
Group by A.PrdDate, A.AreaCode, A.DivisionCode, A.WorkCenter, A.LineCode, A.ApplyFrom, A.TimeCode

-- �ð��뺰�� ��������
Select	AreaCode	= A.AreaCode,		-- �����ڵ�
	DivisionCode	= A.DivisionCode,		-- ����
	WorkCenter	= A.WorkCenter,		-- Work Center
	LineCode	= A.LineCode,		-- ����
	PrdQty01	= Sum(Case When A.TimeCode = '08:00'  Then IsNull(A.PrdQty, 0) Else 0 End),
	PrdQty02	= Sum(Case When A.TimeCode = '09:00'  Then IsNull(A.PrdQty, 0) Else 0 End),
	PrdQty03	= Sum(Case When A.TimeCode = '10:00'  Then IsNull(A.PrdQty, 0) Else 0 End),
	PrdQty04	= Sum(Case When A.TimeCode = '11:00'  Then IsNull(A.PrdQty, 0) Else 0 End),
	PrdQty05	= Sum(Case When A.TimeCode = '12:00'  Then IsNull(A.PrdQty, 0) Else 0 End),
	PrdQty06	= Sum(Case When A.TimeCode = '13:00'  Then IsNull(A.PrdQty, 0) Else 0 End),
	PrdQty07	= Sum(Case When A.TimeCode = '14:00'  Then IsNull(A.PrdQty, 0) Else 0 End),
	PrdQty08	= Sum(Case When A.TimeCode = '15:00'  Then IsNull(A.PrdQty, 0) Else 0 End),
	PrdQty09	= Sum(Case When A.TimeCode = '16:00'  Then IsNull(A.PrdQty, 0) Else 0 End),
	PrdQty10	= Sum(Case When A.TimeCode = '17:00'  Then IsNull(A.PrdQty, 0) Else 0 End),
	PrdQty11	= Sum(Case When A.TimeCode = '18:00'  Then IsNull(A.PrdQty, 0) Else 0 End),
	PrdQty12	= Sum(Case When A.TimeCode = '19:00'  Then IsNull(A.PrdQty, 0) Else 0 End),
	PrdQty13	= Sum(Case When A.TimeCode = '20:00'  Then IsNull(A.PrdQty, 0) Else 0 End),
	PrdQty14	= Sum(Case When A.TimeCode = '21:00'  Then IsNull(A.PrdQty, 0) Else 0 End),
	PrdQty15	= Sum(Case When A.TimeCode = '22:00'  Then IsNull(A.PrdQty, 0) Else 0 End),
	PrdQty16	= Sum(Case When A.TimeCode = '23:00'  Then IsNull(A.PrdQty, 0) Else 0 End),
	PrdQty17	= Sum(Case When A.TimeCode = '24:00'  Then IsNull(A.PrdQty, 0) Else 0 End),
	PrdQty18	= Sum(Case When A.TimeCode = '01:00'  Then IsNull(A.PrdQty, 0) Else 0 End),
	PrdQty19	= Sum(Case When A.TimeCode = '02:00'  Then IsNull(A.PrdQty, 0) Else 0 End),
	PrdQty20	= Sum(Case When A.TimeCode = '03:00'  Then IsNull(A.PrdQty, 0) Else 0 End),
	PrdQty21	= Sum(Case When A.TimeCode = '04:00'  Then IsNull(A.PrdQty, 0) Else 0 End),
	PrdQty22	= Sum(Case When A.TimeCode = '05:00'  Then IsNull(A.PrdQty, 0) Else 0 End),
	PrdQty23	= Sum(Case When A.TimeCode = '06:00'  Then IsNull(A.PrdQty, 0) Else 0 End),
	PrdQty24	= Sum(Case When A.TimeCode = '07:00'  Then IsNull(A.PrdQty, 0) Else 0 End)
Into	#tmp_result
From	#tmp_prd	A
Group by A.AreaCode, A.DivisionCode, A.WorkCenter, A.LineCode

-- ��������� ������
Select	AreaCode	= A.AreaCode,		-- �����ڵ�
	AreaName	= B.AreaName,
	DivisionCode	= A.DivisionCode,		-- ����
	DivisionName	= B.DivisionName,
	WorkCenter	= A.WorkCenter,		-- Work Center
	WorkCenterName	= B.WorkCenterName,
	LineCode	= A.LineCode,		-- ����
	LineShortName	= B.LineShortName,
	LineFullName	= B.LineFullName,
	PrdQty01	= Sum(A.PrdQty01),
	PrdQty02	= Sum(A.PrdQty02),
	PrdQty03	= Sum(A.PrdQty03),
	PrdQty04	= Sum(A.PrdQty04),
	PrdQty05	= Sum(A.PrdQty05),
	PrdQty06	= Sum(A.PrdQty06),
	PrdQty07	= Sum(A.PrdQty07),
	PrdQty08	= Sum(A.PrdQty08),
	PrdQty09	= Sum(A.PrdQty09),
	PrdQty10	= Sum(A.PrdQty10),
	PrdQty11	= Sum(A.PrdQty11),
	PrdQty12	= Sum(A.PrdQty12),
	PrdQty13	= Sum(A.PrdQty13),
	PrdQty14	= Sum(A.PrdQty14),
	PrdQty15	= Sum(A.PrdQty15),
	PrdQty16	= Sum(A.PrdQty16),
	PrdQty17	= Sum(A.PrdQty17),
	PrdQty18	= Sum(A.PrdQty18),
	PrdQty19	= Sum(A.PrdQty19),
	PrdQty20	= Sum(A.PrdQty20),
	PrdQty21	= Sum(A.PrdQty21),
	PrdQty22	= Sum(A.PrdQty22),
	PrdQty23	= Sum(A.PrdQty23),
	PrdQty24	= Sum(A.PrdQty24)
From	#tmp_result	A,
	vmstline		B
Where	A.AreaCode	= B.AreaCode		And
	A.DivisionCode	= B.DivisionCode		And
	A.WorkCenter	= B.WorkCenter		And
	A.LineCode	= B.LineCode
Group By A.AreaCode, B.AreaName, B.SortOrder, A.DivisionCode, B.DivisionName, A.WorkCenter, B.WorkCenterName,
	A.LineCode, B.LineShortName, B.LineFullName


Drop Table #tmp_prd
Drop Table #tmp_result

Return

End		-- Procedure End

Go