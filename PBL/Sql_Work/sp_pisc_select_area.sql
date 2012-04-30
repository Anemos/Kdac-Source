SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


/*
Execute sp_pisc_select_area '896106', '%'

select * from tmstarea


Select	LTrim(RTrim(A.AUTAREA))
From	tmstpassword	A
Where	A.EMP_NO	= 'IPIS'
*/

ALTER  Procedure sp_pisc_select_area
	@ps_empno		varchar(6),	-- 사번
	@ps_areacode		char(1)		-- 지역

As
Begin

Declare	@ls_areacode	char(1)

Select	@ls_areacode	= LTrim(RTrim(A.AUTAREA))
From	tmstpassword	A
Where	A.EMP_NO	= @ps_empno

If @ls_areacode = '' Or @ls_areacode = ' ' Or Len(@ls_areacode) = 0 Or @ls_areacode is null
Begin
	Select	@ls_areacode = '%'
End


Select	AreaCode	= A.AreaCode,
	AreaName	= A.AreaName,
	DisplayName	= A.AreaName + '(' + A.AreaCode + ')'
From	tmstarea		A
Where	A.AreaCode	Like @ls_areacode
Group By A.AreaCode, A.AreaName, A.SortOrder
Order By A.SortOrder

Return

End		-- Procedure End


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

