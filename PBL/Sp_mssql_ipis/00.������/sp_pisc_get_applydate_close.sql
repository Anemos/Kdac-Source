/*
	File Name	: sp_pisc_get_applydate_close.SQL
	SYSTEM		: KDAC ���� ���� ���� �ý���
	Procedure Name	: sp_pisc_get_applydate_close
	Description	: ������ ���ϱ� - ������ ���ڸ� ����� ������ ���ϱ�
			  ���� : Host �� �Ŵ� ���� 20:00 �� ����ó���� �ϹǷ�
				IPIS �� �Ŵ� ���Ͽ��� ������ ����� Ʋ������...����
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 09. 17
	Author		: Kim Jin-Su
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisc_get_applydate_close]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisc_get_applydate_close]
GO

/*
declare	@ls_applydate	char(10),
	@ldt_datetime	datetime

--select	@ldt_datetime = Convert(datetime, '2002.09.30 19:00:00')
select	@ldt_datetime = Convert(datetime, '2002.09.26 11:00:00')

Execute sp_pisc_get_applydate_close
	@ps_areacode		= 'D',
	@ps_divisioncode	= 'A',
	@pdt_sourcedate		= @ldt_datetime,
	@rs_applydate		= @ls_applydate		output

select @ls_applydate
*/

Create Procedure sp_pisc_get_applydate_close
	@ps_areacode		char(1),			-- ����
	@ps_divisioncode	char(1),			-- ����
	@pdt_sourcedate		datetime,		-- �������� ���Ϸ��� �Ͻ�
	@rs_applydate		char(10)		output	-- ������

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
	If @ls_sourcetime > '19:59:59'
	Begin
		Select	@rs_applydate	= @ls_nextday
		Return
	End
	Else
	Begin
		Select	@rs_applydate = Convert(Char(10),
						DateAdd(Second,
							DateDiff(Second,
								Convert(DateTime, '08:00:00'),
								Convert(DateTime, '00:00:00')
							)
						,@pdt_sourcedate )
					 ,102)
		Return
	End
End
Else
Begin
	If Right(@ls_sourceday, 2) = '01'
	Begin
		Select	@rs_applydate = @ls_sourceday
		Return
	End
End

-- ���ݺ��ʹ� ���� �� ù�� �� �ƴ� ������ ������ ���ϱ�.
--If @ps_areacode = '%' Or @ps_divisioncode = '%'
If @ps_divisioncode = '%'
Begin
	-- ������ �����Ƿ� 08:00:00 ���� ó��
	Select	@rs_applydate = Convert(Char(10),
					DateAdd(Second,
						DateDiff(Second,
							Convert(DateTime, '08:00:00'),
							Convert(DateTime, '00:00:00')
						)
					,@pdt_sourcedate )
				 ,102)
End
Else
Begin
	-- ����� ���� ���ڸ� �����.
	Select	@rs_applydate = Convert(Char(10),
					DateAdd(Second,
						DateDiff(Second,
							Convert(DateTime, A.FlagGubun),
							Convert(DateTime, '00:00:00')
						)
					,@pdt_sourcedate )
				 ,102)
	  From	tmstflag		A
	 Where	AreaCode	= @ps_areacode		And
		DivisionCode	= @ps_divisioncode	And
		FlagCode	= 'CHANGE_DATE'

	If @@RowCount = 0 Or @rs_applydate Is Null
	Begin
		-- �����Ͱ� �����Ƿ� 08:00:00 ���� ó��
		Select	@rs_applydate = Convert(Char(10),
						DateAdd(Second,
							DateDiff(Second,
								Convert(DateTime, '08:00:00'),
								Convert(DateTime, '00:00:00')
							)
						,@pdt_sourcedate )
					 ,102)
	End
End

Return

End		-- Procedure End
Go
