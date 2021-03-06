SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_pism010u_calcRestTime]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_pism010u_calcRestTime]
GO







/*****************************/
/*     법정휴식시간 계산     */
/*****************************/

CREATE PROCEDURE sp_pism010u_calcRestTime
	@ps_area	Char(1),		-- 지역
	@ps_div		Char(1),		-- 공장
	@ps_wc		Varchar(5),		-- 조
	@ps_wday	Char(10),		-- 작업일자 
	@ps_empGbn	Char(1),		-- 사원구분 
	@ri_restTime	int	OutPut		-- 법정휴게시간 

AS
BEGIN

Declare @start_cnt		int, 
	@end_cnt 		int, 	
	@labtacEmpGbn		Char(1), 	-- 사원구분
	@EmpNo			VarChar(6),	-- 사번
	@EmpName		VarChar(20),	-- 명칭 
	@workMH			Numeric(5,1),	-- 근무시간
	@mhCode 		Char(2),	-- 근태코드
	@DNgbn			Char(1),	-- 주야구분
	@jtMH			Numeric(5,1),	-- 조퇴
	@ocMH			Numeric(5,1),	-- 외출 
	@mugMH			Numeric(5,1),	-- 무급
	@yjMH			Numeric(5,1),	-- 연장
	@tgMH			Numeric(5,1),	-- 특근
	@jcMH			Numeric(5,1),	-- 조출
	@sjMH			Numeric(5,1),	-- 상주
	@restTime		int,		-- 휴게시간
	@daymthRestTime		int,		-- 주간 해당월 휴게시간 
	@nightmthRestTime	int,		-- 야간 해당월 휴게시간 
	@remark			VarChar(30),
	@workChk		int,
	@workGbn		Char(1) 

	CREATE TABLE #Temp 
	(
		EmpNo		Varchar(6)	not null,
		DNgbn		Char(1)		not null,
		remark		VarChar(50)	null,
		restTime	int		null,
	)

Select @start_cnt = Case @ps_empGbn When '1' Then 1 When '2' Then 2 Else 1 End,  
       @end_cnt	  = Case @ps_empGbn When '1' Then 1 When '2' Then 2 Else 2 End,
       @labtacEmpGbn = Case @ps_empGbn When '1' Then '' When '2' Then '4' Else '' End 

Set @restTime = 0 
Set @ri_restTime = 0 

  SELECT @daymthRestTime = sum(dayRestTime), 
	 @nightmthRestTime = sum(nightRestTime) 
    FROM TMHRESTTIME  
   WHERE ( AreaCode = @ps_area ) AND  
	 ( DivisionCode = @ps_div ) AND  
	 ( ( restGubun = 'R1' ) or ( restGubun = 'R2' ) ) And 
	 ( ApplyMonth = substring(@ps_wday, 6, 2) ) 

  SELECT @workGbn = WorkGubun FROM TCALENDARSHOP  
   WHERE ( AreaCode = @ps_area ) AND  
         ( DivisionCode = @ps_div ) AND  
         ( ApplyDate = @ps_wday ) 
Select @workGbn = IsNull(@workGbn, '') 

If @workGbn = 'W'  
	Begin
		-- 주휴특근 + 휴무특근 자가 있는경우 정시외 공수로 등록하기 위해 
		  SELECT @workChk = Count(dgempno) FROM TMHLABTAC  
		   WHERE ( DGDAY = @ps_wday ) AND ( DGDEPTE = @ps_wc ) AND ( IsNull(excFlag,'') = '' ) And 
		 	 ( ( IsNull(dgjuhur, 0) + IsNull(dghumur, 0) ) > 0 ) 
		   If @workChk > 0 
			Set @workGbn = 'H' 
		   Else
			Set @workGbn = 'W' 
	End 

While @start_cnt <= @end_cnt  
Begin 
	
	 DECLARE EmpList CURSOR FOR  
	  SELECT A.dgempno,	   				-- 사번 
		   A.dgtimer,  	 				-- 근무시간
		   IsNull(A.dgcd2r,'') + IsNull(A.dgcd3r,''),   -- 근태코드
		   IsNull(A.dgdngbr,''),   			-- 주야구분
		   IsNull(A.dgjtr,0),   			-- 조퇴
		   IsNull(A.dgpor,0) + IsNull(A.dgoor,0),  	-- 외출(사용+공용)
		   IsNull(A.dgmur,0),				-- 무급
		   IsNull(A.dgotr,0),   			-- 연장
		   IsNull(A.dgjuhur,0) + IsNull(A.dghumur,0),	-- 특근
		   IsNull(A.dgjor,0),				-- 조출
		   IsNull(A.dgsangr,0)				-- 상주
	     FROM TMHLABTAC A 
	    WHERE ( ( A.dgday = @ps_wday ) AND  
	            ( A.dgdepte = @ps_wc ) AND  
	            ( IsNull(A.excFlag,'') = '' ) And ( IsNull(A.dgempgb,'') = @labtacEmpGbn ) And 
		    ( IsNull(DGCD2R,'') + IsNull(DGCD3R,'') in ( '', '21' ) ) )  -- 근태코드 발생된 인원은 제외 
	OPEN EmpList
	FETCH NEXT FROM EmpList 
	INTO @EmpNo, @workMH, @mhCode, @DNgbn, @jtMH, @ocMH, @mugMH, @yjMH, @tgMH, @jcMH, @sjMH 
	WHILE @@FETCH_STATUS = 0
	Begin
	   If @mhCode = '21' -- 철야 
		Begin 
		  SELECT @restTime = IsNull(dayRestTime,0) + IsNull(nightRestTime,0) 
		    FROM TMHRESTTIME  
		   WHERE ( AreaCode = @ps_area ) AND  
			 ( DivisionCode = @ps_div ) AND  
			 ( restGubun = 'R3' ) 
		   Select @restTime = IsNull(@restTime,0) 
		   Select @restTime = @restTime + @daymthRestTime + @nightmthRestTime 
		   Set @remark = @remark + ' 철야 ' 
		End 
	   Else
	Begin 
	   If @DNgbn = ''		--주간 
		-- 특근, 조퇴, 외출, 무급 의 경우 휴게시간 별도계산 
		Begin
			If @workGbn = 'W' And @tgMH = 0 and @jtMH = 0 and @ocMH = 0 and @mugMH = 0 Set @restTime = @daymthRestTime

			If @jtMH > 0 		 	-- 조퇴 
				Begin 
					Select @restTime = 
					Case When @jtMH >= 0.1 and @jtMH < 2.0 Then 
						  @restTime + @daymthRestTime  
					     When @jtMH >= 2.0 And @jtMH < 6.0 Then
						  @restTime + 10 
					End  
				End 
			If ( @ocMH  + @mugMH ) > 0  	-- 외출	
				Begin 
					Select @restTime = 
					Case When ( @ocMH  + @mugMH ) >= 0.1 and ( @ocMH  + @mugMH ) < 2.0 Then
						  @restTime + @daymthRestTime   
					     When ( @ocMH  + @mugMH ) >= 2.0 and ( @ocMH  + @mugMH ) < 6.0 Then 
						  @restTime + 10 
					End 
				End 
			If @yjMH > 0  			-- 연장	
				Begin 
					Select @restTime = 
					Case When @yjMH >= 0.1 and @yjMH <= 5.0 Then 
					          @restTime + 10 
					     When @yjMH > 5.0 Then 
						  @restTime + 20 
					End 
				End 
			If @tgMH > 0  			-- 특근 
				Begin 
					Select @restTime = 
					Case When @tgMH > 2.0 and @tgMH <= 6.0 Then 
						  @restTime + 10 
					     When @tgMH > 6.0 Then
						  @restTime + @daymthRestTime   
					End 
				End 
			If @jcMH > 0  			-- 조출 
				Begin 
					Select @restTime = 
					Case When @jcMH >= 0.1 and @jcMH <= 5.0 Then 
						  @restTime + 10 
					     When @jcMH > 5.0 Then 
						  @restTime + 20 
					End
				End 
			If @sjMH > 0 Select @restTime = @restTime + 0 
		End

	   If @DNgbn = 'N' 	-- 야간 
		Begin
			If @workGbn = 'W' And @tgMH = 0 and @jtMH = 0 and @ocMH = 0 and @mugMH = 0 Set @restTime = @nightmthRestTime

			If @jtMH > 0  				-- 조퇴
				Begin 
					Select @restTime = 
					Case When @jtMH >= 0.1 and @jtMH < 2.0 Then 
					          @restTime + 30   
					     When @jtMH >= 2.0 And @jtMH < 6.0 Then
						  @restTime + 15 
					End  
				End 
			If ( @ocMH  + @mugMH ) > 0  		-- 외출	
				Begin 
					Select @restTime = 
					Case When ( @ocMH  + @mugMH ) >= 0.1 and ( @ocMH  + @mugMH ) < 2.0 Then
						  @restTime + 30   
					     When ( @ocMH  + @mugMH ) >= 2.0 and ( @ocMH  + @mugMH ) < 6.0 Then 
						  @restTime + 15 
					End 
				End 
			If @yjMH > 0  				-- 연장 
				Begin 
					Select @restTime = 
					Case When @yjMH >= 0.1 and @yjMH <= 5.0 Then 
						  @restTime + 10 
					     When @yjMH > 5.0 Then 
						  @restTime + 20   
					End 
				End 
			If @tgMH > 0  				-- 특근 
				Begin
					Select @restTime = 
					Case When @tgMH > 4.0 and @tgMH <= 6.0 Then 
					          @restTime + 15
					     When @tgMH > 6.0 Then
						  @restTime + 30   
					End 
				End 
			If @jcMH > 0  				-- 조출 
				Begin
					Select @restTime = 
					Case When @jcMH >= 0.1 and @jcMH <= 5.0 Then 
						  @restTime + 10  
					     When @jcMH > 5.0 Then 
						  @restTime + 20  
					End
				End 
			If @sjMH > 0 Select @restTime = @restTime + 0 		-- 상주(휴게시간 기준이없음) 
		End 

	  If @jtMH > 0 
	    Set @remark = ' 조퇴 : ' + cast ( @jtMH as varchar(10) ) 
	  If @ocMH > 0 
	    Set @remark = @remark + ' 공용 및 사용외출 : ' + cast ( @ocMH as varchar(10) ) 
	  If @mugMH > 0 
	    Set @remark = @remark + ' 무급 : ' + cast ( @mugMH as varchar(10) ) 
	  If @yjMH > 0 
	    Set @remark = @remark + ' 연장 : ' + cast ( @yjMH as varchar(10) ) 
	  If @tgMH > 0 
	    Set @remark = @remark + ' 특근 : ' + cast ( @tgMH as varchar(10) ) 
	  If @jcMH > 0 
	    Set @remark = @remark + ' 조출 : ' + cast ( @jcMH as varchar(10) ) 
	  If @sjMH > 0 
	    Set @remark = @remark + ' 상주 : ' + cast ( @sjMH as varchar(10) ) 
	   
	End 

	   Insert Into #Temp VALUES ( @EmpNo, @DNgbn, @remark, @restTime ) 

	   If @@Error <> 0 Goto Exit_pr 
	   
	   Set @restTime = 0 
	   Set @remark = '' 
	
	   Set @ri_restTime = @ri_restTime + IsNull(@restTime,0) 
	   FETCH NEXT FROM EmpList 
	   INTO @EmpNo, @workMH, @mhCode, @DNgbn, @jtMH, @ocMH, @mugMH, @yjMH, @tgMH, @jcMH, @sjMH 
	END
	
	CLOSE EmpList
	DEALLOCATE EmpList

	Set @start_cnt = @start_cnt + 1 
        Set @labtacEmpGbn = '4' 

End 

Exit_pr:
	Select A.EmpNo, A.EmpName, B.DNgbn, B.remark, B.restTime 
	  From TMSTEMP A, #Temp B 
	 Where A.EmpNo = B.EmpNo 

	Drop Table #Temp 
	
	return @ri_restTime

END



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

