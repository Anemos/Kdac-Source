/************************************************************************************************/
/*	File Name	: sp_pisq041u_02.SQL                                                            */
/*	SYSTEM		: ǰ������(��ǰǰ��)                                                            */
/*	Description	: �̵��� �˻���ؼ� ����                                                       */
/*	Supply		: DAEWOO Information Systems Co., LTD IAS Dept                                  */
/*	Use DataBase: IPIS2000                                                                      */
/*	Use Table	: TQQCSTANDARD                                                                  */
/*	              TMSTITEM                                                                      */
/*	              TMSTSUPPLIER                                                                  */
/*	              TMSTEMP                                                                       */
/*  Parameter   : @ps_areacode          char(01)    => ��������                                 */
/*                @ps_divisioncode      char(01)    => �����ڵ�                                 */
/*                @ps_suppliercode      char(05)	  => ��ü�ڵ�                                 */
/*                @ps_itemcode          char(05)	  => ǰ���ڵ�                                 */
/*                @ps_standardrevno     char(02)    => Rev No                                 */
/*                @ps_modifycode        char(05)	  => �����ü�ڵ�                            */
/*                @ps_empcode           char(06)	  => �Է��ڻ��                            */
/*	Notes		: ����Ⱦ�ü�� �˻���ؼ��� �����Ѵ�.                                           */
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
        @ps_areacode          char(01)      ,   -- ��������
        @ps_divisioncode      char(01)      ,   -- �����ڵ�
        @ps_suppliercode      varchar(05)   ,  	-- ��ü�ڵ�
        @ps_itemcode          varchar(15)   ,   -- ǰ��
        @ps_standardrevno     char(02)      ,   -- Rev No
        @ps_modifycode        varchar(15)   ,   -- �����ü�ڵ�
        @ps_empcode           char(06)

AS

BEGIN

-- TQQCSTANDARD ����
insert into tqqcstandard( AreaCode, DivisionCode, Suppliercode, Itemcode, StandardRevno, ChargeName,
  EnactmentDate, ItemRank, Quality, HeatTreatment, SurfaceTreatment,
  QcConceptionReference,BadTreatment, ConsertDependenceflag, DrawingName, ChargeCode, ChargeConsertFlag, SanctionCode,
  SanctionConsertFlag, ConsertDate, ReturnReason, ModifyContent, ChangeFlag,
  ApplyDate, LastEmp, LastDate )
select 	AreaCode, DivisionCode, @ps_modifycode, ItemCode, '00', IsNull(ChargeName, ''),
	IsNull(EnactmentDate,''), IsNull(ItemRank,''), IsNull(Quality,''), IsNull(HeatTreatment,''), IsNull(SurfaceTreatment,''),
	IsNull(QCConceptionReference,''), BadTreatment, 'N', DrawingName, '', '', '', 
	'', '', ReturnReason, 'KDAC : ��ü�������� ���� ���ο�û���', 'Y',
	Convert(varchar(10), GetDate(), 102), @ps_empcode, getdate()
from	tQQcStandard
where	AreaCode = @ps_areacode
  and	DivisionCode = @ps_divisioncode
  and	SupplierCode = @ps_suppliercode
  and	ItemCode = @ps_itemcode
  and StandardRevno = @ps_standardrevno
  
-- TQQCSTANDARDDETAIL ����
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
