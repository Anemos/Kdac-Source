SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_pism010u_calcsuppRestTime]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_pism010u_calcsuppRestTime]
GO








/*******************************************/
/*    법정휴식시간 계산 - 시간단위 지원    */
/*******************************************/

CREATE PROCEDURE sp_pism010u_calcsuppRestTime
	@ps_area	Char(1),		-- 지역
	@ps_div		Char(1),		-- 공장
	@ps_wc		Varchar(5),		-- 조
	@ps_wday	Char(10)		-- 작업일자 

AS
BEGIN

Declare @EmpNo			VarChar(6),	-- 사번
	@suppFromTime		DateTime,	-- 지원From
	@suppToTime		DateTime,	-- 지원To 
	@dayFromTime		DateTime,	-- 주간정시From
	@dayToTime		DateTime,	-- 주간정시To
	@nightFromTime		DateTime,	-- 야간정시From 
	@nightToTime		DateTime,	-- 야간정시To 
	@suppdayFrom		DateTime,	-- 주간지원From
	@suppdayTo		DateTime,	-- 주간지원To
	@suppnightFrom		DateTime,	-- 야간지원From
	@suppnightTo		DateTime,	-- 야간지원To
	@etcFromTime		DateTime,	-- 정시외From 
	@etcToTime 		DateTime,	-- 정시외To 
	@DNgbn			Char(1),	-- 주야구분 
	@tomorrow		Char(10),	-- @ps_wday + 1 일 
	@escFromTime		DateTime,	-- 정시외From
	@escToTime		DateTime,	-- 정시외To 
	@restFromTime		DateTime,	-- 휴게From
	@restToTime		DateTime,	-- 휴게To 
	@calcRestTime		Int,		-- 계산된 휴게시간
	@restTime		Int,		-- 해당월 휴게시간
	@supGubun		Char(1)		-- 지원 해줌/받음 구분

	CREATE TABLE #Temp 
	(
		supGubun	Char(1)		not null, 
		EmpNo		Varchar(6)	not null,
		DNgbn		Char(1)		null,
		FromTime	datetime 	null,
		ToTime		datetime 	null,
		escFromTime	datetime	null,
		escToTime	datetime	null,
		restTime	numeric(2)	null 		
	)

	Set @dayFromTime	= Cast ( @ps_wday + ' 08:00' as DateTime )
	Set @dayToTime		= Cast ( @ps_wday + ' 17:00' as DateTime )
	
	Set @tomorrow 		= Convert ( Char(10), DATEADD(day, 1, Convert ( Datetime , @ps_wday, 102 ) ), 102 )
	Set @nightFromTime 	= Cast ( @ps_wday + ' 23:00' as DateTime )
	Set @nightToTime   	= Cast ( @tomorrow + ' 08:00' as DateTime ) 
	
/******** 지원받음내역 *******/

	Select @suppdayFrom = NULL, @suppdayTo = NULL, @etcFromTime = NULL, @etcToTime = NULL, @suppnightFrom = NULL, @suppnightTo = NULL 

	DECLARE suppEmpList1 CURSOR FOR  
	 SELECT EmpNo, FromTime, ToTime 
	   FROM TMHSUPPORT 
	  WHERE ( AreaCode = @ps_area ) and 
		( DivisionCode = @ps_div ) and
		( SupWorkcenter = @ps_wc ) and 
		( WorkDay = @ps_wday ) And 
		( supGubun = '1' or supGubun = '4' ) 
	OPEN suppEmpList1
	FETCH NEXT FROM suppEmpList1 
	INTO @EmpNo, @suppFromTime, @suppToTime 
	WHILE @@FETCH_STATUS = 0
	Begin

		If @suppFromTime >= @dayFromTime and @suppFromTime <= @dayToTime	-- 지원From시각이 08:00 ~ 17:00 
		Begin
			If @suppToTime <= @dayToTime	-- 지원To시각이 17:00 이전 
				Select @suppdayFrom = @suppFromTime, @suppdayTo = @suppToTime, @DNgbn = 'D',
				       @etcFromTime = NULL, @etcToTime = NULL 
			
			If @suppToTime >= @dayToTime and @suppToTime <= @nightFromTime	-- 지원To시각이 17:00 ~ 23:00 
				Select @etcFromTime = @dayToTime, @etcToTime = @suppToTime, @DNgbn = 'D',
				       @suppdayFrom = @suppFromTime, @suppdayTo = @dayToTime 
				
			If @suppToTime >= @nightFromTime and @suppToTime <= @nightToTime	-- 지원To시각이 23:00 ~ 08:00 
				Begin 
					Select @etcFromTime = @dayToTime, @etcToTime = @nightFromTime, @DNgbn = 'D',
					       @suppdayFrom = @suppFromTime, @suppdayTo = @dayToTime
	
					Insert Into #Temp VALUES ( '+', @EmpNo, @DNgbn, @suppdayFrom, @suppdayTo, @etcFromTime, @etcToTime, 0 ) 
					
					Select @suppdayFrom = @nightFromTime, @suppdayTo = @suppToTime, @DNgbn = 'N',
					       @etcFromTime = NULL, @etcToTime = NULL 
				End 
			-- 지원To시각이 주간 08:00 이후 -> 입력불가!! 
		End 
		If @suppFromTime >= @dayToTime and @suppFromTime <= @nightFromTime	-- 지원From시각이 17:00 ~ 23:00 
		Begin
			If @suppToTime >= @dayToTime and @suppToTime <= @nightFromTime	-- 지원To시각이 17:00 ~ 23:00 
				Select @etcFromTime = @suppFromTime, @etcToTime = @suppToTime, @DNgbn = 'X' 

			If @suppToTime >= @nightFromTime and @suppToTime <= @nightToTime	-- 지원To시각이 23:00 ~ 08:00 
				Select @etcFromTime = @suppFromTime, @etcToTime = @nightFromTime, 
				       @suppdayFrom = @nightFromTime, @suppdayTo = @suppToTime, @DNgbn = 'N' 
			-- 지원To시각이 주간 08:00 이후 -> 입력불가!! 
		End 
		If @suppFromTime >= @nightFromTime and @suppFromTime <= @nightToTime	-- 지원From시각이 23:00 ~ 08:00 
		Begin
			If @suppToTime >= @nightFromTime and @suppToTime <= @nightToTime	-- 지원To시각이 23:00 ~ 08:00 
				 Select @suppdayFrom = @suppFromTime, @suppdayTo = @suppToTime, @DNgbn = 'N',
				        @etcFromTime = NULL, @etcToTime = NULL 
			-- 지원To시각이 주간 08:00 이후 -> 입력불가!! 
		End 
		
		Insert Into #Temp VALUES ( '+', @EmpNo, @DNgbn, @suppdayFrom, @suppdayTo, @etcFromTime, @etcToTime, 0 )

		Select @suppdayFrom = NULL, @suppdayTo = NULL, @suppnightFrom = NULL, @suppnightTo = NULL,  
		       @etcFromTime = NULL, @etcToTime = NULL, @DNgbn = NULL 

		FETCH NEXT FROM suppEmpList1 
		INTO @EmpNo, @suppFromTime, @suppToTime 
	End 
	CLOSE suppEmpList1 
	DEALLOCATE suppEmpList1 


/******** 지원해줌내역 *******/ 

	Select @suppdayFrom = NULL, @suppdayTo = NULL, @etcFromTime = NULL, @etcToTime = NULL, @suppnightFrom = NULL, @suppnightTo = NULL 

	DECLARE suppEmpList2 CURSOR FOR  
	 SELECT EmpNo, FromTime, ToTime 
	   FROM TMHSUPPORT 
	  WHERE ( AreaCode = @ps_area ) and 
		( DivisionCode = @ps_div ) and
		( Workcenter = @ps_wc ) and 
		( WorkDay = @ps_wday ) --And 
--		( supGubun = '1' or supGubun = '4' ) 
	OPEN suppEmpList2
	FETCH NEXT FROM suppEmpList2 
	INTO @EmpNo, @suppFromTime, @suppToTime 
	WHILE @@FETCH_STATUS = 0
	Begin

		If @suppFromTime >= @dayFromTime and @suppFromTime <= @dayToTime	-- 지원From시각이 08:00 ~ 17:00 
		Begin
			If @suppToTime <= @dayToTime	-- 지원To시각이 17:00 이전 
				Select @suppdayFrom = @suppFromTime, @suppdayTo = @suppToTime, @DNgbn = 'D',
				       @etcFromTime = NULL, @etcToTime = NULL 
			
			If @suppToTime >= @dayToTime and @suppToTime <= @nightFromTime	-- 지원To시각이 17:00 ~ 23:00 
				Select @etcFromTime = @dayToTime, @etcToTime = @suppToTime, @DNgbn = 'D',
				       @suppdayFrom = @suppFromTime, @suppdayTo = @dayToTime 
				
			If @suppToTime >= @nightFromTime and @suppToTime <= @nightToTime	-- 지원To시각이 23:00 ~ 08:00 
				Begin 
					Select @etcFromTime = @dayToTime, @etcToTime = @nightFromTime, @DNgbn = 'D',
					       @suppdayFrom = @suppFromTime, @suppdayTo = @dayToTime
	
					Insert Into #Temp VALUES ( '-', @EmpNo, @DNgbn, @suppdayFrom, @suppdayTo, @etcFromTime, @etcToTime, 0 ) 
					
					Select @suppdayFrom = @nightFromTime, @suppdayTo = @suppToTime, @DNgbn = 'N',
					       @etcFromTime = NULL, @etcToTime = NULL 
				End 
			-- 지원To시각이 주간 08:00 이후 -> 입력불가!! 
		End 
		If @suppFromTime >= @dayToTime and @suppFromTime <= @nightFromTime	-- 지원From시각이 17:00 ~ 23:00 
		Begin
			If @suppToTime >= @dayToTime and @suppToTime <= @nightFromTime	-- 지원To시각이 17:00 ~ 23:00 
				Select @etcFromTime = @suppFromTime, @etcToTime = @suppToTime, @DNgbn = 'X' 

			If @suppToTime >= @nightFromTime and @suppToTime <= @nightToTime	-- 지원To시각이 23:00 ~ 08:00 
				Select @etcFromTime = @suppFromTime, @etcToTime = @nightFromTime, 
				       @suppdayFrom = @nightFromTime, @suppdayTo = @suppToTime, @DNgbn = 'N' 
			-- 지원To시각이 주간 08:00 이후 -> 입력불가!! 
		End 
		If @suppFromTime >= @nightFromTime and @suppFromTime <= @nightToTime	-- 지원From시각이 23:00 ~ 08:00 
		Begin
			If @suppToTime >= @nightFromTime and @suppToTime <= @nightToTime	-- 지원To시각이 23:00 ~ 08:00 
				 Select @suppdayFrom = @suppFromTime, @suppdayTo = @suppToTime, @DNgbn = 'N',
				        @etcFromTime = NULL, @etcToTime = NULL 
			-- 지원To시각이 주간 08:00 이후 -> 입력불가!! 
		End 
		
		Insert Into #Temp VALUES ( '-', @EmpNo, @DNgbn, @suppdayFrom, @suppdayTo, @etcFromTime, @etcToTime, 0 )

		Select @suppdayFrom = NULL, @suppdayTo = NULL, @suppnightFrom = NULL, @suppnightTo = NULL,  
		       @etcFromTime = NULL, @etcToTime = NULL, @DNgbn = NULL 

		FETCH NEXT FROM suppEmpList2 
		INTO @EmpNo, @suppFromTime, @suppToTime 
	End 
	CLOSE suppEmpList2 
	DEALLOCATE suppEmpList2 


/*******휴게시간 계산********/

	Set @calcRestTime = 0 

	DECLARE suppTimeList CURSOR FOR  
	  SELECT supGubun, EmpNo, DNgbn, FromTime, ToTime,

 		 escFromTime, escToTime 
	    FROM #Temp 
	OPEN suppTimeList 
	FETCH NEXT FROM suppTimeList INTO @supGubun, @EmpNo, @DNgbn, @suppFromTime, @suppToTime, @escFromTime, @escToTime 

	WHILE @@FETCH_STATUS = 0
	Begin 

		DECLARE restTimeList CURSOR FOR 
		  SELECT Cast( @ps_wday + ' ' + dayFrom as DateTime ) as restFrom,   
			 Cast( @ps_wday + ' ' + dayTo as DateTime) as restTo,
			 dayRestTime as restTime 
 		     FROM TMHRESTTIME  
		   WHERE ( AreaCode = @ps_area ) AND  
			 ( DivisionCode = @ps_div ) AND  
			 ( substring(restGubun, 1, 1) = 'R' ) AND 
			 ( ApplyMonth = substring(@ps_wday,6,2) ) 
		Union 
		  SELECT Cast( Case When restGubun = 'R3' Then @ps_wday Else @tomorrow End + ' ' + nightFrom as DateTime ),   
			 Cast( Case When restGubun = 'R3' Then @ps_wday Else @tomorrow End + ' ' + nightTo as DateTime ),
			 nightRestTime 
		     FROM TMHRESTTIME  
		   WHERE ( AreaCode = @ps_area ) AND  
			 ( DivisionCode = @ps_div ) AND  
			 ( substring(restGubun, 1, 1) = 'R' ) AND 
			 ( ApplyMonth = substring(@ps_wday,6,2) )
		OPEN restTimeList 
		FETCH NEXT FROM restTimeList INTO @restFromTime, @restToTime, @restTime 

		WHILE @@FETCH_STATUS = 0
		Begin 
			If @supGubun = '-' Set @restTime = 0 - @restTime 

			-- 정시 
			If @suppFromTime <= @restFromTime and @suppToTime >= @restToTime 
				Set @calcRestTime = @calcRestTime + @restTime 

			-- 정시외
			If @escFromTime <= @restFromTime and @escToTime >= @restToTime 
				Set @calcRestTime = @calcRestTime + @restTime 

			FETCH NEXT FROM restTimeList INTO @restFromTime, @restToTime, @restTime  
		End 
		CLOSE restTimeList
		DEALLOCATE restTimeList		

		Update #Temp Set restTime = @calcRestTime Where EmpNo = @EmpNo And DNgbn = @DNgbn 
		
		Set @calcRestTime = 0 
		FETCH NEXT FROM suppTimeList INTO @supGubun, @EmpNo, @DNgbn, @suppFromTime, @suppToTime, @escFromTime, @escToTime 
	End  
	CLOSE suppTimeList
	DEALLOCATE suppTimeList

	Select A.EmpNo, A.EmpName, B.DNgbn, B.FromTime, B.ToTime, B.escFromTime, B.escToTime, B. restTime 
	  From TMSTEMP A, #Temp B 
	 Where A.EmpNo = B.EmpNo 

 Drop Table #Temp 
END



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

