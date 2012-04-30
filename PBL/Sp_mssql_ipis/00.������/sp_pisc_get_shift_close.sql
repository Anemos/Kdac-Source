/*
	File Name	: sp_pisc_get_shift_close.SQL
	SYSTEM		: KDAC ���� ���� ���� �ý���
	Procedure Name	: sp_pisc_get_shift_close
	Description	: ��/�� ���� ���ϱ� -  �������� �����
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 09. 17
	Author		: Kim Jin-Su
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisc_get_shift_close]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisc_get_shift_close]
GO

/*
declare	@ls_shift		char(1),
	@ldt_datetime	datetime

--select	@ldt_datetime = Convert(datetime, '2002.09.30 23:00:00')
select	@ldt_datetime = Convert(datetime, '2002.10.30 23:59:59')

Execute sp_pisc_get_shift_close
	@ps_areacode		= 'D',
	@ps_divisioncode	= 'B',
	@pdt_sourcedate		= @ldt_datetime,
	@rs_shift		= @ls_shift		output

select @ls_shift
*/

Create Procedure sp_pisc_get_shift_close
	@ps_areacode		char(1),			-- ����
	@ps_divisioncode	char(1),			-- ����
	@pdt_sourcedate		datetime,		-- �������� ���Ϸ��� �Ͻ�
	@rs_shift		char(1)		output	-- ������

As
Begin

Declare	@ls_sourceday	char(10),	-- �������� ���Ϸ��� ����('YYYY.MM.DD')
	@ls_sourcetime	char(8),		-- �������� ���Ϸ��� ������ �ð�('HH:MM:SS')
	@ls_lastday	char(10),	-- �������� ���Ϸ��� ���ڰ� ���� ���� ������ ����('YYYY.MM.DD')
	@ls_nextday	char(10)		-- �������� ���Ϸ��� ���ڰ� ���� ���� �������� ù° ����('YYYY.MM.DD')

Select	@ls_sourceday	= Convert(char(10), @pdt_sourcedate, 102),
	@ls_sourcetime	= Convert(char(8), @pdt_sourcedate, 108)
Select	@ls_lastday	= Convert(char(10), DateAdd(DD, -1, DateAdd(MM, 1, Convert(DateTime, Left(@ls_sourceday, 7) + '.01'))), 102)
Select	@ls_nextday	= Convert(char(10), DateAdd(MM, 1, Convert(DateTime, Left(@ls_sourceday, 7) + '.01')), 102)

-- �� ������ ���� �����ð��� '20:00' �̴�. �ſ� �߿���...
-- ����, ���� ������ �����ϱ� �� ù° ������ ������ ����� ��������...
If @ls_sourceday = @ls_lastday
Begin
	Select @rs_shift = 'A'
	Return
End

-- ���ݺ��ʹ� ���� �� ù�� �� �ƴ� ������ ��/�� ���ϱ�.
--If @ps_areacode = '%' Or @ps_divisioncode = '%'
If @ps_divisioncode = '%'
Begin
	-- ������ �����Ƿ� �ְ��� 08:00 ~ 20:00 �� ó��
	Select @rs_shift = Case When @ls_sourcetime > '07:59:59' And @ls_sourcetime < '20:00:00' Then 'A' Else 'B' End
End
Else
Begin
	-- ����� ��/�� ������ �����.
	Select	@rs_shift = Case When @ls_sourcetime > '07:59:59' And @ls_sourcetime < A.FlagGubun Then 'A' Else 'B' End
	  From	tmstflag		A
	 Where	AreaCode	= @ps_areacode		And
		DivisionCode	= @ps_divisioncode	And
		FlagCode	= 'CHANGE_SHIFT'

	If @@RowCount = 0 Or @rs_shift Is Null
	Begin
		-- �����Ͱ� �����Ƿ� �ְ��� 08:00 ~ 20:00 �� ó��
		Select @rs_shift = Case When @ls_sourcetime > '07:59:59' And @ls_sourcetime < '20:00:00' Then 'A' Else 'B' End
	End
End

Return

End		-- Procedure End
Go
