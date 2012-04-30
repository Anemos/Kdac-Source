/*
	File Name	: sp_pisc_get_lotno.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisc_get_lotno
	Description	: Lot No 구하기
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 10. 01
	Author		: Kim Jin-Su
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisc_get_lotno]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisc_get_lotno]
GO

/*
declare	@ls_lotno	varchar(6)

Execute sp_pisc_get_lotno
	@ps_areacode		= 'D',
	@ps_divisioncode	= 'A',
	@ps_date		= '2002.10.01',
	@ps_shift		= 'A',
	@rs_lotno		= @ls_lotno		output

select @ls_lotno
*/

Create Procedure sp_pisc_get_lotno
	@ps_areacode		char(1),			-- 지역
	@ps_divisioncode	char(1),			-- 공장
	@ps_date		char(10),		-- Lot No 을 구하려는 일시
	@ps_shift		char(1),			-- 주/야 구분
	@rs_lotno		varchar(6)	output	-- 기준일

As
Begin

Select @rs_lotno	= SubString(@ps_date, 4, 1) + SubString(@ps_date, 6, 2) + SubString(@ps_date, 9, 2) + @ps_shift

Return

End		-- Procedure End
Go
