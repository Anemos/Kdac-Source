/************************************************************************************************/
/*	File Name	: sp_pisq041u_02.SQL                                                            */
/*	SYSTEM		: 품질관리(부품품질)                                                            */
/*	Description	: 이동된 검사기준서 저장                                                       */
/*	Supply		: DAEWOO Information Systems Co., LTD IAS Dept                                  */
/*	Use DataBase: IPIS2000                                                                      */
/*	Use Table	: TQQCSTANDARD                                                                  */
/*	              TMSTITEM                                                                      */
/*	              TMSTSUPPLIER                                                                  */
/*	              TMSTEMP                                                                       */
/*  Parameter   : @ps_areacode          char(01)    => 지역구분                                 */
/*                @ps_divisioncode      char(01)    => 공장코드                                 */
/*                @ps_suppliercode      char(05)	  => 업체코드                                 */
/*                @ps_itemcode          char(05)	  => 품번코드                                 */
/*                @ps_standardrevno     char(02)    => Rev No                                 */
/*                @ps_modifycode        char(05)	  => 변경업체코드                            */
/*                @ps_empcode           char(06)	  => 입력자사번                            */
/*	Notes		: 변경된업체로 검사기준서를 저장한다.                                           */
/*	Made Date	: 2004.11.26                                                                 */
/*	Author		: Kiss Kim                                                               */
/************************************************************************************************/
if exists (select * from sysobjects where id = object_id('dbo.sp_pisq041u_02') and sysstat & 0xf = 4)
	drop procedure dbo.sp_pisq041u_02
GO
/*
Exec sp_pisq041u_02
		@ps_areacode        = 'D'            ,
		@ps_divisioncode    = 'A'            ,
    @ps_suppliercode    = 'D0524'        ,
    @ps_itemcode        = 'aaa'          ,
    @ps_standardrevno   = '00'           ,
    @ps_modifycode      = 'aaa'          ,
    @ps_empcode         = '000030'
*/


/****** Object:  Stored Procedure dbo.sp_pisq041u_02    Script Date: 2004-11-26  ******/
CREATE PROCEDURE sp_pisq041u_02
        @ps_areacode          char(01)      ,   -- 지역구분
        @ps_divisioncode      char(01)      ,   -- 공장코드
        @ps_suppliercode      varchar(05)   ,  	-- 업체코드
        @ps_itemcode          varchar(15)   ,   -- 품번
        @ps_standardrevno     char(02)      ,   -- Rev No
        @ps_modifycode        varchar(15)   ,   -- 변경업체코드
        @ps_empcode           char(06)

AS

BEGIN

-- TQQCSTANDARD 정보
insert into tqqcstandard( AreaCode, DivisionCode, Suppliercode, Itemcode, StandardRevno, ChargeName,
  EnactmentDate, ItemRank, Quality, HeatTreatment, SurfaceTreatment,
  QcConceptionReference,BadTreatment, ConsertDependenceflag, DrawingName, ChargeCode, ChargeConsertFlag, SanctionCode,
  SanctionConsertFlag, ConsertDate, ReturnReason, ModifyContent, ChangeFlag,
  ApplyDate, LastEmp, LastDate )
select 	AreaCode, DivisionCode, @ps_modifycode, ItemCode, '00', IsNull(ChargeName, ''),
	IsNull(EnactmentDate,''), IsNull(ItemRank,''), IsNull(Quality,''), IsNull(HeatTreatment,''), IsNull(SurfaceTreatment,''),
	IsNull(QCConceptionReference,''), BadTreatment, 'N', DrawingName, '', '', '', 
	'', '', ReturnReason, 'KDAC : 업체변경으로 인한 승인요청요망', 'Y',
	Convert(varchar(10), GetDate(), 102), @ps_empcode, getdate()
from	tQQcStandard
where	AreaCode = @ps_areacode
  and	DivisionCode = @ps_divisioncode
  and	SupplierCode = @ps_suppliercode
  and	ItemCode = @ps_itemcode
  and StandardRevno = @ps_standardrevno
  
-- TQQCSTANDARDDETAIL 정보
insert into tqqcstandarddetail( AreaCode, DivisionCode, SupplierCode, ItemCode, StandardRevno, Orderno,
  Qcitem, DecisionRank, ItemSpecQuality, Sample, QcStructure, QcStipulation, LastEmp, LastDate )
select AreaCode, DivisionCode, @ps_modifycode, ItemCode, '00', Orderno,
  Qcitem, DecisionRank, ItemSpecQuality, Sample, QcStructure, QcStipulation, @ps_empcode, getdate()
from tqqcstandarddetail
where	AreaCode = @ps_areacode
  and	DivisionCode = @ps_divisioncode
  and	SupplierCode = @ps_suppliercode
  and	ItemCode = @ps_itemcode
  and StandardRevno = @ps_standardrevno
  
END 

go
