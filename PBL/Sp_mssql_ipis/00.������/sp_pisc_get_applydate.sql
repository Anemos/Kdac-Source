/*
	File Name	: sp_pisc_get_applydate.SQL
	SYSTEM		: KDAC ���� ���� ���� �ý���
	Procedure Name	: sp_pisc_get_applydate
	Description	: ������ ���ϱ�.
			  ������ ���ڸ� ������� �ʰ�, �׳� ������ ������
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 09. 17
	Author		: Kim Jin-Su
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisc_get_applydate]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisc_get_applydate]
GO

/*
declare	@ls_applydate	char(10),
	@ldt_datetime	datetime

--select	@ldt_datetime = Convert(datetime, '2002.09.30 19:00:00')
select	@ldt_datetime = Convert(datetime, '2002.10.31 21:00:00')

Execute sp_pisc_get_applydate
	@ps_areacode		= 'D',
	@ps_divisioncode	= 'B',
	@pdt_sourcedate		= @ldt_datetime,
	@rs_applydate		= @ls_applydate		output

select @ls_applydate
*/

Create Procedure sp_pisc_get_applydate
	@ps_areacode		char(1),			-- ����
	@ps_divisioncode	char(1),			-- ����
	@pdt_sourcedate		datetime,		-- �������� ���Ϸ��� �Ͻ�
	@rs_applydate		char(10)		output	-- ������

As
Begin

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
