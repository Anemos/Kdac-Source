SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_eisr140i_01]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_eisr140i_01]
GO


------------------------------------------------------------------
--      ���ְ����ؼ��� Worst10 - �����ؼ���(����) 
------------------------------------------------------------------
CREATE PROCEDURE sp_eisr140i_01
--	@ps_year		Char(4),	-- �⵵
--	@ps_area		Char(1),	-- ����
	@ps_from		Char(10),	-- ��������
	@ps_to			Char(10)--,	-- ��������
--	@ps_obeyvalue		Char(1)		-- ���� 'D'�����ؼ�, 'T'�ð��ؼ�
AS

BEGIN

Set NoCount On

Declare	@ldt_applytime		DateTime
Select  @ldt_applytime 		= GetDate()

-- ���庰 ��ü���� �����ؼ����� ����Ѵ�.
Create	Table	#PARTKBOBEY_tmp
	( 	AreaCode	Char(1),
		DivisionCode	Char(1),
		SupplierCode	VarChar(5),
		AllKBQty	Int, 
		KBObeyQty	Int, 
		ObeyRate	Decimal,
		Seq		Smallint  )

   INSERT INTO 	#PARTKBOBEY_tmp( AreaCode, DivisionCode, SupplierCode, AllKBQty, KBObeyQty, ObeyRate, Seq )
	SELECT 	A.AreaCode, 
		A.DivisionCode, 
		A.SupplierCode,
		Sum( isNull( A.AllKBQty	, 0) ),
		Sum( isNull( A.KBObeyQty, 0) ),
		0.0,
		0
	  FROM (-- TPARTKBHIS ���� ��ü�����Ǹż��� �ؼ��ż��� Count�Ѵ�.
		Select	AreaCode, 
			DivisionCode, 
			SupplierCode,
			Count(*) As AllKBQty,
			Case When PartObeyDateFlag  = 1 Then Count(*) Else 0 End As KBObeyQty
		  From	TPARTKBHIS 
		Where	PartKBGubun	= 'N'	And
			PartKBStatus	= 'C'	And
			(Case OrderChangeFlag When 'Y' Then ChangeForecastDate Else PartForecastDate End) >= @ps_from 		And
			(Case OrderChangeFlag When 'Y' Then ChangeForecastDate Else PartForecastDate End) <= @ps_to 
		Group By AreaCode, DivisionCode, SupplierCode, PartObeyDateFlag
	
		Union All
		-- TPARTKBSTATUS ���� ��ü�����Ǹż��� �ؼ��ż��� Count�Ѵ�.
		Select	AreaCode, 
			DivisionCode, 
			SupplierCode,
			Count(*) As AllKBQty,
			Case When PartObeyDateFlag = 1 Then Count(*) Else 0 End As KBObeyQty
		  From	TPARTKBSTATUS 	 
		 Where	PartKBGubun	= 'N'		And
			PartKBStatus	= 'B'		And
			(Case OrderChangeFlag When 'Y' Then ChangeForecastDate Else PartForecastDate End) >= @ps_from  	  	And
			(Case OrderChangeFlag When 'Y' Then ChangeForecastDate Else PartForecastDate End) <= @ps_to 
--			PartKBStatus	IN ( 'A', 'B' )	And
--			(Case OrderChangeFlag When 'Y' Then ChangeForecastTime Else PartForecastTime End) <  @ldt_applytime	And
--			(Case OrderChangeFlag When 'Y' Then ChangeForecastDate Else PartForecastDate End) >= @ps_from  	  	And
--			(Case OrderChangeFlag When 'Y' Then ChangeForecastDate Else PartForecastDate End) <= @ps_to 
		Group By AreaCode, DivisionCode, SupplierCode, PartObeyDateFlag	)  As A
	Group By AreaCode, DivisionCode, SupplierCode
	
-- ��ü�� �����ؼ����� ����Ѵ�.
	UPDATE	#PARTKBOBEY_tmp
	   SET	ObeyRate 	= Round(( KBObeyQty * 1.0 / AllKBQty ) * 100.0, 2 )
	 WHERE	AllKBQty	> 0

-- �Ⱓ�� ���ǻ���� �ִ� ����List�� ���Ѵ�.
	SELECT	DISTINCT 
		AreaCode, 
		DivisionCode 
	  INTO  #PARTDIVISION_tmp
	  FROM	#PARTKBOBEY_tmp

	DECLARE @ls_AreaCode		Char(1),
		@ls_DivisionCode	Char(1),
		@ls_SupplierCode	VarChar(5),
		@li_i			Smallint
	
	Create	Table	#WORST10_tmp
		( 	AreaCode	Char(1),
			DivisionCode	Char(1),
			SupplierCode	VarChar(5),
			SupplierKorName	VarChar(30),
			AllKBQty	Int, 
			KBObeyQty	Int, 
			ObeyRate	Decimal,
			Seq		Smallint  )

-- Worst10 ��ü�� Select�Ѵ�.
	DECLARE partdivision_cursor CURSOR
	FOR
		SELECT	AreaCode, 
			DivisionCode 
		  FROM	#PARTDIVISION_tmp

	-- Ŀ������
	--
	OPEN partdivision_cursor

	-- FETCH
	--
	FETCH NEXT FROM partdivision_cursor INTO @ls_AreaCode, @ls_DivisionCode
	
	WHILE (@@FETCH_STATUS <> -1)
	BEGIN
		IF (@@FETCH_STATUS <> -2)
		BEGIN   
			-- ����, ���庰 WORST 10�� ���� ���̺� �μ�Ʈ�Ѵ�
			--
			INSERT INTO #WORST10_tmp
			( 	AreaCode,
				DivisionCode,
				SupplierCode,
				SupplierKorName,
				AllKBQty, 
				KBObeyQty, 
				ObeyRate,
				Seq		)
			SELECT	TOP 10
				A.AreaCode,
				A.DivisionCode,
				A.SupplierCode,
				B.SupplierKorName,
				A.AllKBQty, 
				A.KBObeyQty, 
				A.ObeyRate,
				A.Seq
			  FROM 	#PARTKBOBEY_tmp A, 
				TMSTSUPPLIER	B	
			 WHERE 	A.AreaCode	= @ls_AreaCode		AND
			      	A.DivisionCode	= @ls_DivisionCode	AND
				A.SupplierCode	= B.SupplierCode
		      ORDER BY  A.AreaCode 	ASC,
				A.DivisionCode	ASC,
		      		A.ObeyRate 	ASC,
				A.AllKBQty	DESC,
				A.KBObeyQty	ASC

		END
		FETCH NEXT FROM partdivision_cursor INTO @ls_AreaCode, @ls_DivisionCode
	END
	-- Ŀ��ũ�ν�
	--
	CLOSE partdivision_cursor
	DEALLOCATE partdivision_cursor

	SET @li_i = 0

	-- ������ �ο��ϱ� ���Ͽ� ���� ���̺��� ó������ �����鼭  1 ~ 10 ���� ��ȣ�� �ο�
	--
	DECLARE worstseq_cursor CURSOR
	FOR
		SELECT 	AreaCode	,
			DivisionCode	,
			SupplierCode 
		  FROM	#WORST10_tmp 
	OPEN worstseq_cursor
	FETCH NEXT FROM worstseq_cursor INTO @ls_AreaCode, @ls_DivisionCode, @ls_SupplierCode
	
	WHILE (@@FETCH_STATUS <> -1)
	BEGIN
	   IF (@@FETCH_STATUS <> -2)
	   BEGIN   
		SET @li_i = @li_i + 1
		UPDATE #WORST10_tmp
		   SET Seq = @li_i 
		 WHERE AreaCode		= @ls_AreaCode		And
		       DivisionCode	= @ls_DivisionCode	And
		       SupplierCode 	= @ls_SupplierCode
		IF @li_i = 10 SET @li_i = 0
	   END
		FETCH NEXT FROM worstseq_cursor INTO @ls_AreaCode, @ls_DivisionCode, @ls_SupplierCode
	END
	CLOSE 		worstseq_cursor
	DEALLOCATE 	worstseq_cursor

-- ���� �ڷḦ �д´�.

  SELECT 	A.AreaCode,   
		B.AreaName,   
		A.DivisionCode,   
		C.DivisionName,
		( 	Select 	X.SupplierCode 
			  From 	#WORST10_tmp 	X
			 Where 	A.AreaCode 	= X.AreaCode 	And
				A.DivisionCode 	= X.DivisionCode And
				X.Seq		= 1 ) As SupplierCode1,
		( 	Select 	X.SupplierKorName 
			  From 	#WORST10_tmp 	X
			 Where 	A.AreaCode 	= X.AreaCode 	And
				A.DivisionCode 	= X.DivisionCode And
				X.Seq		= 1 ) As SupplierKorName1,
		( 	Select 	X.AllKBQty 
			  From 	#WORST10_tmp 	X
			 Where 	A.AreaCode 	= X.AreaCode 	And
				A.DivisionCode 	= X.DivisionCode And
				X.Seq		= 1 ) As AllKBQty1,
		( 	Select 	X.KBObeyQty 
			  From 	#WORST10_tmp 	X
			 Where 	A.AreaCode 	= X.AreaCode 	And
				A.DivisionCode 	= X.DivisionCode And
				X.Seq		= 1 ) As KBObeyQty1,
		( 	Select 	X.ObeyRate 
			  From 	#WORST10_tmp 	X
			 Where 	A.AreaCode 	= X.AreaCode 	And
				A.DivisionCode 	= X.DivisionCode And
				X.Seq		= 1 ) As ObeyRate1,
		( 	Select 	X.SupplierCode 
			  From 	#WORST10_tmp 	X
			 Where 	A.AreaCode 	= X.AreaCode 	And
				A.DivisionCode 	= X.DivisionCode And
				X.Seq		= 2 ) As SupplierCode2,
		( 	Select 	X.SupplierKorName 
			  From 	#WORST10_tmp 	X
			 Where 	A.AreaCode 	= X.AreaCode 	And
				A.DivisionCode 	= X.DivisionCode And
				X.Seq		= 2 ) As SupplierKorName2,
		( 	Select 	X.AllKBQty 
			  From 	#WORST10_tmp 	X
			 Where 	A.AreaCode 	= X.AreaCode 	And
				A.DivisionCode 	= X.DivisionCode And
				X.Seq		= 2 ) As AllKBQty2,
		( 	Select 	X.KBObeyQty 
			  From 	#WORST10_tmp 	X
			 Where 	A.AreaCode 	= X.AreaCode 	And
				A.DivisionCode 	= X.DivisionCode And
				X.Seq		= 2 ) As KBObeyQty2,
		( 	Select 	X.ObeyRate 
			  From 	#WORST10_tmp 	X
			 Where 	A.AreaCode 	= X.AreaCode 	And
				A.DivisionCode 	= X.DivisionCode And
				X.Seq		= 2 ) As ObeyRate2,
		( 	Select 	X.SupplierCode 
			  From 	#WORST10_tmp 	X
			 Where 	A.AreaCode 	= X.AreaCode 	And
				A.DivisionCode 	= X.DivisionCode And
				X.Seq		= 3 ) As SupplierCode3,
		( 	Select 	X.SupplierKorName 
			  From 	#WORST10_tmp 	X
			 Where 	A.AreaCode 	= X.AreaCode 	And
				A.DivisionCode 	= X.DivisionCode And
				X.Seq		= 3 ) As SupplierKorName3,
		( 	Select 	X.AllKBQty 
			  From 	#WORST10_tmp 	X
			 Where 	A.AreaCode 	= X.AreaCode 	And
				A.DivisionCode 	= X.DivisionCode And
				X.Seq		= 3 ) As AllKBQty3,
		( 	Select 	X.KBObeyQty 
			  From 	#WORST10_tmp 	X
			 Where 	A.AreaCode 	= X.AreaCode 	And
				A.DivisionCode 	= X.DivisionCode And
				X.Seq		= 3 ) As KBObeyQty3,
		( 	Select 	X.ObeyRate 
			  From 	#WORST10_tmp 	X
			 Where 	A.AreaCode 	= X.AreaCode 	And
				A.DivisionCode 	= X.DivisionCode And
				X.Seq		= 3 ) As ObeyRate3,
		( 	Select 	X.SupplierCode 
			  From 	#WORST10_tmp 	X
			 Where 	A.AreaCode 	= X.AreaCode 	And
				A.DivisionCode 	= X.DivisionCode And
				X.Seq		= 4 ) As SupplierCode4,
		( 	Select 	X.SupplierKorName 
			  From 	#WORST10_tmp 	X
			 Where 	A.AreaCode 	= X.AreaCode 	And
				A.DivisionCode 	= X.DivisionCode And
				X.Seq		= 4 ) As SupplierKorName4,
		( 	Select 	X.AllKBQty 
			  From 	#WORST10_tmp 	X
			 Where 	A.AreaCode 	= X.AreaCode 	And
				A.DivisionCode 	= X.DivisionCode And
				X.Seq		= 4 ) As AllKBQty4,
		( 	Select 	X.KBObeyQty 
			  From 	#WORST10_tmp 	X
			 Where 	A.AreaCode 	= X.AreaCode 	And
				A.DivisionCode 	= X.DivisionCode And
				X.Seq		= 4 ) As KBObeyQty4,
		( 	Select 	X.ObeyRate 
			  From 	#WORST10_tmp 	X
			 Where 	A.AreaCode 	= X.AreaCode 	And
				A.DivisionCode 	= X.DivisionCode And
				X.Seq		= 4 ) As ObeyRate4,
		( 	Select 	X.SupplierCode 
			  From 	#WORST10_tmp 	X
			 Where 	A.AreaCode 	= X.AreaCode 	And
				A.DivisionCode 	= X.DivisionCode And
				X.Seq		= 5 ) As SupplierCode5,
		( 	Select 	X.SupplierKorName 
			  From 	#WORST10_tmp 	X
			 Where 	A.AreaCode 	= X.AreaCode 	And
				A.DivisionCode 	= X.DivisionCode And
				X.Seq		= 5 ) As SupplierKorName5,
		( 	Select 	X.AllKBQty 
			  From 	#WORST10_tmp 	X
			 Where 	A.AreaCode 	= X.AreaCode 	And
				A.DivisionCode 	= X.DivisionCode And
				X.Seq		= 5 ) As AllKBQty5,
		( 	Select 	X.KBObeyQty 
			  From 	#WORST10_tmp 	X
			 Where 	A.AreaCode 	= X.AreaCode 	And
				A.DivisionCode 	= X.DivisionCode And
				X.Seq		= 5 ) As KBObeyQty5,
		( 	Select 	X.ObeyRate 
			  From 	#WORST10_tmp 	X
			 Where 	A.AreaCode 	= X.AreaCode 	And
				A.DivisionCode 	= X.DivisionCode And
				X.Seq		= 5 ) As ObeyRate5,
		( 	Select 	X.SupplierCode 
			  From 	#WORST10_tmp 	X
			 Where 	A.AreaCode 	= X.AreaCode 	And
				A.DivisionCode 	= X.DivisionCode And
				X.Seq		= 6 ) As SupplierCode6,
		( 	Select 	X.SupplierKorName 
			  From 	#WORST10_tmp 	X
			 Where 	A.AreaCode 	= X.AreaCode 	And
				A.DivisionCode 	= X.DivisionCode And
				X.Seq		= 6 ) As SupplierKorName6,
		( 	Select 	X.AllKBQty 
			  From 	#WORST10_tmp 	X
			 Where 	A.AreaCode 	= X.AreaCode 	And
				A.DivisionCode 	= X.DivisionCode And
				X.Seq		= 6 ) As AllKBQty6,
		( 	Select 	X.KBObeyQty 
			  From 	#WORST10_tmp 	X
			 Where 	A.AreaCode 	= X.AreaCode 	And
				A.DivisionCode 	= X.DivisionCode And
				X.Seq		= 6 ) As KBObeyQty6,
		( 	Select 	X.ObeyRate 
			  From 	#WORST10_tmp 	X
			 Where 	A.AreaCode 	= X.AreaCode 	And
				A.DivisionCode 	= X.DivisionCode And
				X.Seq		= 6 ) As ObeyRate6,
		( 	Select 	X.SupplierCode 
			  From 	#WORST10_tmp 	X
			 Where 	A.AreaCode 	= X.AreaCode 	And
				A.DivisionCode 	= X.DivisionCode And
				X.Seq		= 7 ) As SupplierCode7,
		( 	Select 	X.SupplierKorName 
			  From 	#WORST10_tmp 	X
			 Where 	A.AreaCode 	= X.AreaCode 	And
				A.DivisionCode 	= X.DivisionCode And
				X.Seq		= 7 ) As SupplierKorName7,
		( 	Select 	X.AllKBQty 
			  From 	#WORST10_tmp 	X
			 Where 	A.AreaCode 	= X.AreaCode 	And
				A.DivisionCode 	= X.DivisionCode And
				X.Seq		= 7 ) As AllKBQty7,
		( 	Select 	X.KBObeyQty 
			  From 	#WORST10_tmp 	X
			 Where 	A.AreaCode 	= X.AreaCode 	And
				A.DivisionCode 	= X.DivisionCode And
				X.Seq		= 7 ) As KBObeyQty7,
		( 	Select 	X.ObeyRate 
			  From 	#WORST10_tmp 	X
			 Where 	A.AreaCode 	= X.AreaCode 	And
				A.DivisionCode 	= X.DivisionCode And
				X.Seq		= 7 ) As ObeyRate7,
		( 	Select 	X.SupplierCode 
			  From 	#WORST10_tmp 	X
			 Where 	A.AreaCode 	= X.AreaCode 	And
				A.DivisionCode 	= X.DivisionCode And
				X.Seq		= 8 ) As SupplierCode8,
		( 	Select 	X.SupplierKorName 
			  From 	#WORST10_tmp 	X
			 Where 	A.AreaCode 	= X.AreaCode 	And
				A.DivisionCode 	= X.DivisionCode And
				X.Seq		= 8 ) As SupplierKorName8,
		( 	Select 	X.AllKBQty 
			  From 	#WORST10_tmp 	X
			 Where 	A.AreaCode 	= X.AreaCode 	And
				A.DivisionCode 	= X.DivisionCode And
				X.Seq		= 8 ) As AllKBQty8,
		( 	Select 	X.KBObeyQty 
			  From 	#WORST10_tmp 	X
			 Where 	A.AreaCode 	= X.AreaCode 	And
				A.DivisionCode 	= X.DivisionCode And
				X.Seq		= 8 ) As KBObeyQty8,
		( 	Select 	X.ObeyRate 
			  From 	#WORST10_tmp 	X
			 Where 	A.AreaCode 	= X.AreaCode 	And
				A.DivisionCode 	= X.DivisionCode And
				X.Seq		= 8 ) As ObeyRate8,
		( 	Select 	X.SupplierCode 
			  From 	#WORST10_tmp 	X
			 Where 	A.AreaCode 	= X.AreaCode 	And
				A.DivisionCode 	= X.DivisionCode And
				X.Seq		= 9 ) As SupplierCode9,
		( 	Select 	X.SupplierKorName 
			  From 	#WORST10_tmp 	X
			 Where 	A.AreaCode 	= X.AreaCode 	And
				A.DivisionCode 	= X.DivisionCode And
				X.Seq		= 9 ) As SupplierKorName9,
		( 	Select 	X.AllKBQty 
			  From 	#WORST10_tmp 	X
			 Where 	A.AreaCode 	= X.AreaCode 	And
				A.DivisionCode 	= X.DivisionCode And
				X.Seq		= 9 ) As AllKBQty9,
		( 	Select 	X.KBObeyQty 
			  From 	#WORST10_tmp 	X
			 Where 	A.AreaCode 	= X.AreaCode 	And
				A.DivisionCode 	= X.DivisionCode And
				X.Seq		= 9 ) As KBObeyQty9,
		( 	Select 	X.ObeyRate 
			  From 	#WORST10_tmp 	X
			 Where 	A.AreaCode 	= X.AreaCode 	And
				A.DivisionCode 	= X.DivisionCode And
				X.Seq		= 9 ) As ObeyRate9,
		( 	Select 	X.SupplierCode 
			  From 	#WORST10_tmp 	X
			 Where 	A.AreaCode 	= X.AreaCode 	And
				A.DivisionCode 	= X.DivisionCode And
				X.Seq		= 10 ) As SupplierCode10,
		( 	Select 	X.SupplierKorName 
			  From 	#WORST10_tmp 	X
			 Where 	A.AreaCode 	= X.AreaCode 	And
				A.DivisionCode 	= X.DivisionCode And
				X.Seq		= 10 ) As SupplierKorName10,
		( 	Select 	X.AllKBQty 
			  From 	#WORST10_tmp 	X
			 Where 	A.AreaCode 	= X.AreaCode 	And
				A.DivisionCode 	= X.DivisionCode And
				X.Seq		= 10 ) As AllKBQty10,
		( 	Select 	X.KBObeyQty 
			  From 	#WORST10_tmp 	X
			 Where 	A.AreaCode 	= X.AreaCode 	And
				A.DivisionCode 	= X.DivisionCode And
				X.Seq		= 10 ) As KBObeyQty10,
		( 	Select 	X.ObeyRate 
			  From 	#WORST10_tmp 	X
			 Where 	A.AreaCode 	= X.AreaCode 	And
				A.DivisionCode 	= X.DivisionCode And
				X.Seq		= 10 ) As ObeyRate10
    FROM	#PARTDIVISION_tmp 	A,
		TMSTAREA		B,	
    		TMSTDIVISION		C
   WHERE	A.AreaCode 	= B.AreaCode	And
		A.AreaCode 	= C.AreaCode	And
		A.DivisionCode 	= C.DivisionCode	
ORDER BY 	A.AreaCode, C.SortOrder

Drop Table	#PARTKBOBEY_tmp
Drop Table	#PARTDIVISION_tmp
Drop Table	#WORST10_tmp

Set NoCount Off

End	-- End PROCEDURE
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

