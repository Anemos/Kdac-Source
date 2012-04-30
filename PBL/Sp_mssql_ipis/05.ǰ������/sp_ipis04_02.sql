SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


ALTER  procedure sp_ipis04_02
@ps_area_code varchar(10),
@ps_division_code varchar(10),
@ps_supplier_code varchar(20),
@ps_item_code varchar(20),
@ps_standard_rev_no varchar(20)
as
-- 검사기준서 설계변경
-- 검사기준서 변경이력에 현재 검사기준서를 저장하고
-- 기준서 RevNo를 하나 증가시킨다.
begin

-- 만약 이력테이블에 동일한 데이터가 있다면
-- 이런경우는 없겠지만
-- 데이터를 지우고 입력한다
delete tQQcStandardChange
 where	AreaCode = @ps_area_code
   and	DivisionCode = @ps_division_code
   and	SupplierCode = @ps_supplier_code
   and	ItemCode = @ps_item_code
   and	StandardRevNo = @ps_standard_rev_no

insert	tQQcStandardChange 
	(AreaCode, DivisionCode, SupplierCode, ItemCode, StandardRevNo, ChargeName,
	EnactmentDate, ItemRank, Quality, HeatTreatment, SurfaceTreatment,
	QCConceptionReference, BadTreatment, ConsertDependenceflag, DrawingName,
	Chargecode, ChargeConsertflag, SanctionCode, SanctionConsertflag, ReturnReason, Changeflag,
	RejectTreatment, ModifyContent, ModifyDate, ConsertDate, ApplyDate)
select 	AreaCode, DivisionCode, SupplierCode, ItemCode, StandardRevNo, IsNull(ChargeName, ''),
	IsNull(EnactmentDate,''), IsNull(ItemRank,''), IsNull(Quality,''), IsNull(HeatTreatment,''), 
	IsNull(SurfaceTreatment,''),
	IsNull(QCConceptionReference,''), BadTreatment, ConsertDependenceflag, DrawingName,
	Chargecode, ChargeConsertflag, SanctionCode, SanctionConsertflag, ReturnReason, Changeflag,
	IsNull(BadTreatment,''), IsNull(ModifyContent,''), 
	Convert(varchar(10), GetDate(), 102),
	IsNull(ConsertDate, ''),
	ApplyDate
  from	tQQcStandard
 where	AreaCode = @ps_area_code
   and	DivisionCode = @ps_division_code
   and	SupplierCode = @ps_supplier_code
   and	ItemCode = @ps_item_code
 
-- 검사기준서 테이블의 기준서 Rev No를 한 증가시켜놓는다
declare @ln_next_standard_rev_no int
declare @ls_next_standard_rev_no varchar(10)

set @ln_next_standard_rev_no = Convert(int, @ps_standard_rev_no) + 1
set @ls_next_standard_rev_no = '000' + Convert(varchar(2), @ln_next_standard_rev_no)
set @ls_next_standard_rev_no = Right(@ls_next_standard_rev_no, 2)

update	tQQcStandard
   set	StandardRevNo = @ls_next_standard_rev_no
 where	AreaCode = @ps_area_code
   and	DivisionCode = @ps_division_code
   and	SupplierCode = @ps_supplier_code
   and	ItemCode = @ps_item_code

-- 검사항목 데이터를 새로운 RevNo로 복사해놓는다
insert	tQQcStandardDetail
	(AREACODE,DIVISIONCODE,SUPPLIERCODE,ITEMCODE,STANDARDREVNO,ORDERNO,QCITEM,DECISIONRANK,
	ITEMSPECQUALITY,SAMPLE,QCSTRUCTURE,QCSTIPULATION)
select	AREACODE,DIVISIONCODE,SUPPLIERCODE,ITEMCODE,@ls_next_standard_rev_no,ORDERNO,QCITEM,DECISIONRANK,
	ITEMSPECQUALITY,SAMPLE,QCSTRUCTURE,QCSTIPULATION
  from	tQQcStandardDetail
 where	AreaCode = @ps_area_code
   and	DivisionCode = @ps_division_code
   and	SupplierCode = @ps_supplier_code
   and	ItemCode = @ps_item_code
   and	StandardRevNo = @ps_standard_rev_no

-- tQQcStandardChangeDetail에도 데이터를 넣는다
-- 혹시 있을지 모를 garbage 데이터를 감안해서
delete	tQQcStandardChangeDetail
 where	AreaCode = @ps_area_code
   and	DivisionCode = @ps_division_code
   and	SupplierCode = @ps_supplier_code
   and	ItemCode = @ps_item_code
   and	StandardRevNo = @ps_standard_rev_no

insert	tQQcStandardChangeDetail
	(AREACODE,DIVISIONCODE,SUPPLIERCODE,ITEMCODE,STANDARDREVNO,ORDERNO,QCITEM,DECISIONRANK,
	ITEMSPECQUALITY,SAMPLE,QCSTRUCTURE,QCSTIPULATION)
select	AREACODE,DIVISIONCODE,SUPPLIERCODE,ITEMCODE,@ps_standard_rev_no,ORDERNO,QCITEM,DECISIONRANK,
	ITEMSPECQUALITY,SAMPLE,QCSTRUCTURE,QCSTIPULATION
  from	tQQcStandardDetail
 where	AreaCode = @ps_area_code
   and	DivisionCode = @ps_division_code
   and	SupplierCode = @ps_supplier_code
   and	ItemCode = @ps_item_code
   and	StandardRevNo = @ps_standard_rev_no

-- tQQcStandardDetail 에 이전 데이터는 지운다
delete	tQQcStandardDetail
 where	AreaCode = @ps_area_code
   and	DivisionCode = @ps_division_code
   and	SupplierCode = @ps_supplier_code
   and	ItemCode = @ps_item_code
   and	StandardRevNo = @ps_standard_rev_no

-- 설계변경 Flag를 설정한다.
-- 설계변경 중일때는 오로지 승인의뢰만 할 수 있도록
update	tQQcStandard
  set	ChangeFlag = 'Y'
 where	AreaCode = @ps_area_code
   and	DivisionCode = @ps_division_code
   and	SupplierCode = @ps_supplier_code
   and	ItemCode = @ps_item_code
   and	StandardRevNo = @ls_next_standard_rev_no
end  -- procedure end


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

