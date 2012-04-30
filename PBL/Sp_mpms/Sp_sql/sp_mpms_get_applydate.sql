/*
  File Name : sp_mpms_get_applydate.SQL
  SYSTEM    : MPMS System
  Procedure Name  : sp_mpms_get_applydate
  Description : return applydate
  Use DataBase  : MPMS
  Use Program :
  Parameter :
  Use Table :
  Initial   : 2004.03
  Author    : Kiss Kim
*/

If Exists (Select * From sysobjects
      Where id = object_id(N'[dbo].[sp_mpms_get_applydate]')
        And OBJECTPROPERTY(id, N'IsProcedure') = 1)
  Drop Procedure [dbo].[sp_mpms_get_applydate]
GO

/*
Execute sp_mpms_get_applydate
	@pdt_sourcedate		= @ldt_datetime,
	@rs_applydate		= @ls_applydate		output

select @ls_applydate
*/

CREATE  Procedure sp_mpms_get_applydate
	@pdt_sourcedate		datetime,		-- 기준일을 구하려는 일시
	@rs_applydate		char(10)		output	-- 기준일

As
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

End		-- Procedure End

GO
