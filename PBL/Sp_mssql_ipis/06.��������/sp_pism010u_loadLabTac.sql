SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_pism010u_loadLabTac]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_pism010u_loadLabTac]
GO


/*********************************************/
/*     일일근태공수 집계 -> 작업일보 작성    */
/*********************************************/ 

CREATE PROCEDURE [dbo].[sp_pism010u_loadLabTac]
	@ps_area	Char(1),		-- 지역
	@ps_div		Char(1),		-- 공장
	@ps_wc		Varchar(5),		-- 조
	@ps_wday	Char(10) 		-- 작업일자

AS 
BEGIN 

Declare @empGbn			Char(1),	-- 사원구분 
	@labtac_empGbn		Char(1),	-- 일일근태 사원구분 ( '' : 정규, '4' : 기타 ) 
	@jungsiMH		Numeric(4,1),	-- 정시공수
	@etcMH			Numeric(4,1),	-- 정시외공수 
	@totMH			Numeric(4,1), 	-- 총보유공수 
	@excunpaidMH		Numeric(4,1),	-- 평가제외무급공수
	@excpaidMH		Numeric(4,1),	-- 평가제외유급공수
	@gunteMH		Numeric(4,1),	-- 유급근태사고공수 
	@A0MH			Numeric(4,1),	-- 법정휴식 
	@A1MH			Numeric(4,1),	-- 정규분 법정휴식 
	@A2MH			Numeric(4,1),	-- 지원분 법정휴식 
	@K0MH			Numeric(4,1),	-- 결근 
	@L0MH			Numeric(4,1),	-- 무급
	@E1MH			Numeric(4,1), 	-- 사용외출
	@E2MH			Numeric(4,1), 	-- 지각,조퇴
	@R0MH			Numeric(4,1),	-- 경조년월차휴가
	@R0MH_half			Numeric(4,1),	-- 경조 반년월차휴가
	@sL0MH			Numeric(4,1), 	-- 유급휴직기타
	@C2MH			Numeric(4,1),	-- 사외교육
	@B0MH			Numeric(4,1),	-- 업무출장
	@D0MH			Numeric(4,1), 	-- 공용미출외출,
	@D1MH			Numeric(4,1),	-- 공용미출,
	@D2MH			Numeric(4,1),	-- 공용외출, 
	@retGbn			int,		-- 근태공수 재집계 여부
	@workStep		VarChar(50),	-- 작업절차 
	@hunuetcMH		Numeric(4,1),	-- 특근, 
	@workChk		int,		
	@workGbn		Char(1), 
	@ri_Error		int 

Select @retGbn = Count(*) From TMHDAILYSTATUS Where ( AreaCode = @ps_area ) And ( DivisionCode = @ps_div ) And 
					            ( WorkCenter = @ps_wc ) And ( WorkDay = @ps_wday ) 
Select @empGbn = '1', @labtac_empGbn = '' 

If @retGbn = 0 
	Begin
	   Set @workStep = '최초 등록(TMHDAILYSTATUS INSERT)'
	   INSERT INTO TMHDAILYSTATUS 
	          ( AreaCode, DivisionCode, WorkCenter, WorkDay, DailyStatus, InputTime  )  
	   VALUES ( @ps_area, @ps_div, @ps_wc, @ps_wday, '0', GetDate() ) 
	   If @@Error <> 0 Goto Exit_pr 
	End

Set @workStep = '평가제외 사원 Flag저장'
Update TMHLABTAC 
   Set excFlag = Case IsNull(A.excFlag,'') When '0' Then '' Else IsNull(A.excFlag,'') End  
    FROM TMHDAILYEXCEMP A, 
         TMHLABTAC B  
   WHERE ( B.DGEMPNO *= A.excEmpNo ) and  
         ( B.DGDEPTE *= A.WorkCenter ) and  
         ( ( A.AreaCode = @ps_area ) AND  
           ( A.DivisionCode = @ps_div ) And 
           ( B.DGDEPTE = @ps_wc ) And 
	   ( B.DGDAY = @ps_wday ) ) 
If @@Error <> 0 Goto Exit_pr 

-- 주휴특근 + 휴무특근 자가 있는경우 정시외 공수로 등록하기 위해 
-- 작업일 여부를 Setting 
SELECT @workChk = Count(dgempno) FROM TMHLABTAC  
 WHERE ( DGDAY = @ps_wday ) AND ( DGDEPTE = @ps_wc ) AND --( IsNull(excFlag,'') = '' ) And 
       ( ( IsNull(dgjuhur, 0) + IsNull(dghumur, 0) ) > 0 )  
If @workChk > 0 
	Set @workGbn = 'H' 
Else 
	Set @workGbn = 'W' 

While (@retGbn >= 0)

Begin ----------------------- While 

	/* ①정규직 : empGbn = '1' */
	/* ②기   타 : empGbn = '2' */

	/********************* 총보유공수 *******************/ 
	
	-- 정시 공수 (인원 * 8)
	    Select @jungsiMH = count(dgempno) * 8 From TMHLABTAC Where ( dgday = @ps_wday ) And ( dgdepte = @ps_wc ) And 
								       ( IsNull(dgempgb, '') = @labtac_empGbn ) And ( IsNull(excFlag,'') = '' ) 
	    Set @jungsiMH = IsNull(@jungsiMH,0) 

	-- 정시외 공수 (연장, 조출, 상주)
	    Select @etcMH = Sum( IsNull(dgotr, 0) + IsNull(dgjor, 0) + IsNull(dgsangr, 0) ) From TMHLABTAC 
	     Where ( dgday = @ps_wday ) And ( dgdepte = @ps_wc ) And  ( IsNull(dgempgb, '') = @labtac_empGbn ) And ( IsNull(excFlag,'') = '' )
	    Set @etcMH = IsNull(@etcMH,0) 

	-- 정시외 공수 (특근=휴무특근+주휴특근)
	    Select @hunuetcMH = Sum( ( IsNull(dgjuhur, 0) + IsNull(dghumur, 0) ) ) From TMHLABTAC 
	     Where ( dgday = @ps_wday ) And ( dgdepte = @ps_wc ) And  ( IsNull(dgempgb, '') = @labtac_empGbn ) And ( IsNull(excFlag,'') = '' )
	    Set @hunuetcMH = IsNull(@hunuetcMH,0) 
	
	-- 총보유공수 

	If @workGbn = 'W' Set @hunuetcMH = 0
	If @workGbn = 'H' Set @jungsiMH = 0 

	Set @etcMH = @etcMH + @hunuetcMH 
	Set @totMH = @jungsiMH + @etcMH  
	
	/********************* 평가제외 무급공수 *******************/
	-- 결근 : K0 ( K1 : 유결, K2 : 무결, K3 : 병결 ) 
	
	  SELECT @K0MH = count(DGEMPNO) * 8 FROM TMHLABTAC  
	    WHERE ( DGDAY = @ps_wday ) AND ( DGDEPTE = @ps_wc ) AND ( IsNull(excFlag,'') = '' ) And ( IsNull(dgempgb, '') = @labtac_empGbn ) And 
		  ( DGCD2R + DGCD3R in ( 'K1', 'K2', 'K3' ) ) 
	  Set @K0MH = IsNull(@K0MH,0) 
	
	-- 무급 : L0 ( L2 : 무급휴무, M2 : 무급휴직, P2 : 무급산재, R7 : 무급휴가 ) 
	
	  SELECT @L0MH = count(DGEMPNO) * 8 FROM TMHLABTAC  
	   WHERE ( DGDAY = @ps_wday ) AND ( DGDEPTE = @ps_wc ) AND ( IsNull(excFlag,'') = '' ) And ( IsNull(dgempgb, '') = @labtac_empGbn ) And 
	         ( DGCD2R + DGCD3R in ( 'L2', 'M2', 'R7','P2' ) ) 
	  Set @L0MH = IsNull(@L0MH,0) 
	 
	-- 사용외출 : E1, 지각조퇴 : E2 
	
	  SELECT @E1MH = Sum(IsNull(dgpor, 0)), @E2MH = Sum(IsNull(dgjir, 0)) + Sum(IsNull(dgjtr, 0)) FROM TMHLABTAC  
	   WHERE ( DGDAY = @ps_wday ) AND ( DGDEPTE = @ps_wc ) AND ( IsNull(excFlag,'') = '' ) And ( IsNull(dgempgb, '') = @labtac_empGbn ) 
	  Set @E1MH = IsNull(@E1MH,0) 
	  Set @E2MH = IsNull(@E2MH,0) 

	Set @excunpaidMH = @K0MH + @L0MH + @E1MH + @E2MH 

	/********************* 평가제외 유급공수 *******************/
	-- 경조년월차휴가 : R0 ( R1 : 월차, R2 : 년차, R3 : 생휴, R4 : 정기휴가, R5 : 경조, R6 : 출산 ) 
	
	  SELECT @R0MH = count(DGEMPNO) * 8 FROM TMHLABTAC  
	   WHERE ( DGDAY = @ps_wday ) AND ( DGDEPTE = @ps_wc ) AND ( IsNull(excFlag,'') = '' ) And ( IsNull(dgempgb, '') = @labtac_empGbn ) And 
		 ( DGCD2R + DGCD3R in ( 'R1', 'R2', 'RA', 'RB', 'R3', 'R4', 'R5', 'R6' ) ) 
	  Set @R0MH = IsNull(@R0MH,0) 
	
	-- 반차휴가추가(2012.05.04) : R0 ( RA : 반월차, RB : 반년차 )
	SELECT @R0MH_half = count(DGEMPNO) * 4 FROM TMHLABTAC  
	   WHERE ( DGDAY = @ps_wday ) AND ( DGDEPTE = @ps_wc ) AND ( IsNull(excFlag,'') = '' ) And ( IsNull(dgempgb, '') = @labtac_empGbn ) And 
		 ( DGCD2R + DGCD3R in ( 'RA', 'RB' ) ) 
	  Set @R0MH_half = IsNull(@R0MH_half,0) 
	  
	Set @R0MH = @R0MH + @R0MH_half
	-- 유급휴직기타 : L0 ( L1 : 유급휴무, M1 : 유급휴직, N1 : 공상, P1 : 유급산재, Q1 : 정직, R9 : 기타휴가 ) 
	
	  SELECT @sL0MH = count(DGEMPNO) * 8 FROM TMHLABTAC  
	   WHERE ( DGDAY = @ps_wday ) AND ( DGDEPTE = @ps_wc ) AND ( IsNull(excFlag,'') = '' ) And ( IsNull(dgempgb, '') = @labtac_empGbn ) And 
	         ( DGCD2R + DGCD3R in ( 'L1', 'M1', 'N1', 'P1', 'Q1', 'R9' ) ) 
	  Set @sL0MH = IsNull(@sL0MH,0) 

	-- 법정휴식 : A0 = A1 + A2 
	-- 정규분 법정휴식 계산 -> A1 
	Execute sp_pism010u_calcRestTime 
		@ps_area	= @ps_area,
		@ps_div		= @ps_div,
		@ps_wc		= @ps_wc, 
		@ps_wday	= @ps_wday, 
		@ri_restTime	= @A1MH		OutPut	
	Set @A1MH = IsNull(@A1MH,0)
	Set @A1MH = round( @A1MH / 60 , 1 ) 

	-- 지원분 법정휴식  
	SELECT @A2MH = subMH FROM TMHDAILYDETAIL  
	 WHERE ( AreaCode = @ps_area ) AND  
	       ( DivisionCode = @ps_div ) AND  
	       ( WorkCenter = @ps_wc ) AND  
	       ( WorkDay = @ps_wday ) AND  
	       ( EmpGubun = @empGbn ) And 
	       ( mhGubun = 'S' ) AND  
	       ( mhCode = 'A2' ) 
	Set @A2MH = IsNull(@A2MH,0) 
	 
	Set @A0MH = @A1MH + @A2MH 

	Set @excpaidMH = @R0MH + @sL0MH + @A0MH 

	/********************* 유급근태사고공수 *******************/
	-- 사외교육 : C2 
	
	  SELECT @C2MH = count(DGEMPNO) * 8 FROM TMHLABTAC  
	   WHERE ( DGDAY = @ps_wday ) AND ( DGDEPTE = @ps_wc ) AND ( IsNull(excFlag,'') = '' ) And ( IsNull(dgempgb, '') = @labtac_empGbn ) And 
		 ( DGCD2R + DGCD3R in ( 'C2' ) ) 
	  Set @C2MH = IsNull(@C2MH,0) 
	
	-- 업무출장 : B0 ( B1 : 국내출장, B2 : 해외출장, E1 : 파견, J9 : 기타 ) 
	
	  SELECT @B0MH = count(DGEMPNO) * 8 FROM TMHLABTAC  
	   WHERE ( DGDAY = @ps_wday ) AND ( DGDEPTE = @ps_wc ) AND ( IsNull(excFlag,'') = '' ) And ( IsNull(dgempgb, '') = @labtac_empGbn ) And 
	         ( DGCD2R + DGCD3R in ( 'B1', 'B2', 'J9', 'E1' ) ) 
	  Set @B0MH = IsNull(@B0MH,0) 
	
	-- 공용미출외출 : D0 ( D1 : 공용미출, D2 : 공용외출 ) 
	
	  SELECT @D1MH = count(DGEMPNO) * 8 FROM TMHLABTAC  
	   WHERE ( DGDAY = @ps_wday ) AND ( DGDEPTE = @ps_wc ) AND ( IsNull(excFlag,'') = '' ) And ( IsNull(dgempgb, '') = @labtac_empGbn ) And 
		 ( DGCD2R + DGCD3R in ( 'D1' ) ) 
	  Set @D1MH = IsNull(@D1MH,0) 
	
	  SELECT @D2MH = Sum(IsNull(dgoor, 0)) FROM TMHLABTAC  
	   WHERE ( DGDAY = @ps_wday ) AND ( DGDEPTE = @ps_wc ) AND ( IsNull(excFlag,'') = '' ) And ( IsNull(dgempgb, '') = @labtac_empGbn ) 
	  Set @D2MH = IsNull(@D2MH,0) 

	Set @D0MH = @D1MH + @D2MH

	Set @gunteMH = @C2MH + @B0MH + @D0MH 

	Begin 
		Set @workStep = '총보유,정시,정시외 공수 UPDATE' 
		   If @retGbn = 0 
			  INSERT INTO TMHDAILY  
			         ( AreaCode, DivisionCode, WorkCenter, WorkDay, EmpGubun, totMH, jungsiMH, etcMH  )  
			  VALUES ( @ps_area, @ps_div, @ps_wc, @ps_wday, @empGbn, @totMH, @jungsiMH, @etcMH ) 
		   Else
			Update TMHDAILY 
			   Set totMH = @totMH, jungsiMH = @jungsiMH, etcMH = @etcMH
			 Where ( AreaCode = @ps_area ) And ( DivisionCode = @ps_div ) And ( WorkCenter = @ps_wc ) And ( WorkDay = @ps_wday ) And ( EmpGubun = @empGbn ) 
		   If @@Error <> 0 Goto Exit_pr 
	End  
	
	Begin 
		Set @workStep = '이전까지 작업된 상세공수 DELETE' 
		  DELETE FROM TMHDAILYDETAIL  
	                WHERE ( AreaCode = @ps_area ) AND ( DivisionCode = @ps_div ) AND ( WorkCenter = @ps_wc ) AND 
			      ( WorkDay = @ps_wday ) AND ( EmpGubun = @empGbn ) 
-- 			AND  
-- 			      ( ( ( mhGubun = 'K' ) And ( mhCode in ( 'K0', 'L0', 'E1', 'E2' ) ) ) Or 
-- 			        ( ( mhGubun = 'S' ) And ( mhCode in ( 'R0', 'L0', 'A0', 'A1' ) ) ) Or 
-- 	  			( ( mhGubun = 'B' ) And ( mhCode in ( 'B0', 'D0', 'D2' ) ) ) ) 
		   If @@Error <> 0 Goto Exit_pr 
	End 

	Begin 
		Set @workStep = '근태내역에서 재호출된 상세공수 INSERT' 
		   INSERT INTO TMHDAILYDETAIL  
			 ( AreaCode, DivisionCode, WorkCenter, WorkDay, EmpGubun, mhGubun, mhCode, subMH )  
			Select  @ps_area, @ps_div, A.DGDEPTE, @ps_wday, @empGbn, 
				Case When ( IsNull(DGCD2R, '') + IsNull(DGCD3R, '') ) in ( 'K1','K2','K3','L2','M2','R7','P2' ) Then 'K'
			             When ( IsNull(DGCD2R, '') + IsNull(DGCD3R, '') ) in ( 'R1','R2','RA','RB','R3','R4','R5','R6','L1','M1','N1','P1','Q1','R9') Then 'S'
				     When ( IsNull(DGCD2R, '') + IsNull(DGCD3R, '') ) in ( 'C2','B1','B2','J9','E1','D1') Then 'B' Else 'X' End lab_mhGubun, 
				( IsNull(DGCD2R, '') + IsNull(DGCD3R, '') ) lab_mhCode, 
				sum(Case When ( IsNull(DGCD2R, '') + IsNull(DGCD3R, '') ) in ( 'RA','RB' ) Then 4 Else 8 End) subMH
				--count(DGEMPNO) * 8 --sum(IsNull(DGTIMER, 0)) 
			  FROM TMHLABTAC A  
		         WHERE ( DGDAY = @ps_wday ) AND ( DGDEPTE = @ps_wc ) And 
			       ( IsNull(DGCD2R, '') + IsNull(DGCD3R, '') Not In ( 'A1', 'C1', '' ) ) And 
			       ( IsNull(excFlag,'') = '' ) And ( IsNull(dgempgb, '') = @labtac_empGbn ) And 
		    Not Exists ( Select EmpGubun, mhGubun, mhCode From TMHDAILYDETAIL 
			     	  Where ( AreaCode = @ps_area ) And ( DivisionCode = @ps_div ) And 
				        ( WorkCenter = A.DGDEPTE ) And ( WorkDay = A.DGDAY ) And 
					( EmpGubun = @empGbn ) And ( mhCode = IsNull(DGCD2R, '') + IsNull(DGCD3R, '') ) ) 
		      Group By DGDAY, DGDEPTE, IsNull(DGCD2R, '') + IsNull(DGCD3R, '') 
		    If @@Error <> 0 Goto Exit_pr 
	End 

	Begin 
		Set @workStep = '근태내역에서 재호출된 상세공수 UPDATE' 
		   Update TMHDAILYDETAIL
		      Set subMH = A.subMH 
		     From ( Select DGDEPTE, 
		     		   Case When ( IsNull(DGCD2R, '') + IsNull(DGCD3R, '') ) in ( 'K1','K2','K3','L2','M2','R7','P2' ) Then 'K'
		  		        When ( IsNull(DGCD2R, '') + IsNull(DGCD3R, '') ) in ( 'R1','R2','RA','RB','R3','R4','R5','R6','L1','M1','N1','P1','Q1','R9') Then 'S'
				        When ( IsNull(DGCD2R, '') + IsNull(DGCD3R, '') ) in ( 'C2','B1','B2','J9','E1','D1') Then 'B' 
				        Else 'X' End mhGubun, 
				   ( IsNull(DGCD2R, '') + IsNull(DGCD3R, '') ) mhCode,
				   sum(Case When ( IsNull(DGCD2R, '') + IsNull(DGCD3R, '') ) in ( 'RA','RB' ) Then 4 Else 8 End) subMH
				   --count(DGEMPNO) * 8 subMH 
				   From TMHLABTAC 
			     Where ( DGDAY = @ps_wday ) AND  
				   ( DGDEPTE = @ps_wc ) And
	                  	   ( IsNull(excFlag,'') = '' ) And ( IsNull(dgempgb, '') = @labtac_empGbn ) And 
				   ( IsNull(DGCD2R, '') + IsNull(DGCD3R, '') Not In ( 'A1', 'C1', '' ) ) 
		           Group By DGDAY, DGDEPTE, IsNull(DGCD2R, '') + IsNull(DGCD3R, '') ) A,
			   TMHDAILYDETAIL B 
		    Where ( B.WorkCenter = A.DGDEPTE ) And 
			  ( B.mhGubun = A.mhGubun ) And 
			  ( B.mhCode = A.mhCode ) And 
			  ( ( B.AreaCode = @ps_area ) And 
			    ( B.DivisionCode = @ps_div ) And 
			    ( B.WorkCenter = @ps_wc ) And 
			    ( B.WorkDay = @ps_wday ) And 
			    ( B.EmpGubun = @empGbn ) And 
	           Exists ( Select EmpGubun, mhGubun, mhCode From TMHDAILYDETAIL 
			     Where ( AreaCode = @ps_area ) And ( DivisionCode = @ps_div ) And 
				   ( WorkCenter = A.DGDEPTE ) And ( WorkDay = @ps_wday ) And
				   ( EmpGubun = @empGbn ) And ( mhCode = A.mhCode ) ) ) 
		    If @@Error <> 0 Goto Exit_pr 
	End 
--	@K0MH, @L0MH, , @E1MH, @E2MH, @R0MH, @sL0MH, @B0MH, @D0MH, @D2MH  

/****** 일일근태내에 존재하지 않는 코드 이므로 별도로 Insert (조회시 사용) *******/ 
	Begin 
	If @K0MH > 0 
	-- 결근
	 INSERT INTO TMHDAILYDETAIL  
		 ( AreaCode, DivisionCode, WorkCenter, WorkDay, EmpGubun, mhGubun, mhCode, subMH )  
	  Values ( @ps_area, @ps_div, @ps_wc, @ps_wday, @empGbn, 'K', 'K0', @K0MH )

	If @L0MH > 0 
	-- 무급
	 INSERT INTO TMHDAILYDETAIL  
		 ( AreaCode, DivisionCode, WorkCenter, WorkDay, EmpGubun, mhGubun, mhCode, subMH )  
	  Values ( @ps_area, @ps_div, @ps_wc, @ps_wday, @empGbn, 'K', 'L0', @L0MH )

	If @E1MH > 0 
	-- 사용외출 
	 INSERT INTO TMHDAILYDETAIL  
		 ( AreaCode, DivisionCode, WorkCenter, WorkDay, EmpGubun, mhGubun, mhCode, subMH )  
	  Values ( @ps_area, @ps_div, @ps_wc, @ps_wday, @empGbn, 'K', 'E1', @E1MH )

	If @E2MH > 0 
	-- 지각,조퇴
	 INSERT INTO TMHDAILYDETAIL  
		 ( AreaCode, DivisionCode, WorkCenter, WorkDay, EmpGubun, mhGubun, mhCode, subMH )  
	  Values ( @ps_area, @ps_div, @ps_wc, @ps_wday, @empGbn, 'K', 'E2', @E2MH )

	If @A0MH > 0 
	-- 법정휴게
	 INSERT INTO TMHDAILYDETAIL  
		 ( AreaCode, DivisionCode, WorkCenter, WorkDay, EmpGubun, mhGubun, mhCode, subMH )  
	  Values ( @ps_area, @ps_div, @ps_wc, @ps_wday, @empGbn, 'S', 'A0', @A0MH ) 

	If @A1MH > 0 
	-- 정규분 법정휴게
	 INSERT INTO TMHDAILYDETAIL  
		 ( AreaCode, DivisionCode, WorkCenter, WorkDay, EmpGubun, mhGubun, mhCode, subMH )  
	  Values ( @ps_area, @ps_div, @ps_wc, @ps_wday, @empGbn, 'S', 'A1', @A1MH ) 

	If @R0MH > 0
	-- 경조년월차휴가
	 INSERT INTO TMHDAILYDETAIL  
		 ( AreaCode, DivisionCode, WorkCenter, WorkDay, EmpGubun, mhGubun, mhCode, subMH )  
	  Values ( @ps_area, @ps_div, @ps_wc, @ps_wday, @empGbn, 'S', 'R0', @R0MH )

	If @sL0MH > 0 
	-- 유급휴직기타
	 INSERT INTO TMHDAILYDETAIL  
		 ( AreaCode, DivisionCode, WorkCenter, WorkDay, EmpGubun, mhGubun, mhCode, subMH )  
	  Values ( @ps_area, @ps_div, @ps_wc, @ps_wday, @empGbn, 'S', 'L0', @sL0MH )

	If @B0MH > 0 
	-- 업무출장
	 INSERT INTO TMHDAILYDETAIL  
		 ( AreaCode, DivisionCode, WorkCenter, WorkDay, EmpGubun, mhGubun, mhCode, subMH )  
	  Values ( @ps_area, @ps_div, @ps_wc, @ps_wday, @empGbn, 'B', 'B0', @B0MH )

	If @D0MH > 0 
	-- 공용미출외출
	 INSERT INTO TMHDAILYDETAIL  
		 ( AreaCode, DivisionCode, WorkCenter, WorkDay, EmpGubun, mhGubun, mhCode, subMH )  
	  Values ( @ps_area, @ps_div, @ps_wc, @ps_wday, @empGbn, 'B', 'D0', @D0MH )

	If @D2MH > 0 
	-- 공용외출 
	 INSERT INTO TMHDAILYDETAIL  
		 ( AreaCode, DivisionCode, WorkCenter, WorkDay, EmpGubun, mhGubun, mhCode, subMH )  
	  Values ( @ps_area, @ps_div, @ps_wc, @ps_wday, @empGbn, 'B', 'D2', @D2MH )
	End 	

	If @empGbn = '2' Break 
	Select @empGbn = '2', @labtac_empGbn = '4'

	Select @jungsiMH = 0, @etcMH = 0, @hunuetcMH = 0, @totMH = 0, @K0MH = 0, @L0MH = 0, @E1MH = 0, 
	       @E2MH = 0, @R0MH = 0, @sL0MH = 0, @excpaidMH = 0, @C2MH = 0, @B0MH = 0, @D1MH = 0, 
	       @K0MH = 0, @L0MH = 0, @E1MH = 0, @E2MH = 0, @R0MH = 0, @sL0MH = 0, @B0MH = 0, @D0MH = 0, @D2MH = 0, 
	       @A0MH = 0, @A1MH = 0, @A2MH = 0, @D2MH = 0, @D0MH = 0, @gunteMH = 0 

End ----------------- While 

Set @workStep = '작업일보 각종상세공수 집계' 
Execute sp_pism010u_calcDaily @ps_area = @ps_area, @ps_div = @ps_div, @ps_wc = @ps_wc, @ps_wday = @ps_wday, @ri_Error = @ri_Error Output 
If @ri_Error <> 0 Goto Exit_pr 

Set @workStep = '근태내역 갱신 성공' 

Exit_pr:

Begin
	Select	ErrorCode	= @@Error,
		WorkMsg		= @workStep 
	  Into	#Tmp_Error
	
	Select ErrorCode, WorkMsg From #Tmp_Error
End

Drop Table #Tmp_Error

END



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

