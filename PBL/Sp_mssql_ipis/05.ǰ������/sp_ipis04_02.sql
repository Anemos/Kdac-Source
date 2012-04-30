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
-- �˻���ؼ� ���躯��
-- �˻���ؼ� �����̷¿� ���� �˻���ؼ��� �����ϰ�
-- ���ؼ� RevNo�� �ϳ� ������Ų��.
begin

-- ���� �̷����̺� ������ �����Ͱ� �ִٸ�
-- �̷����� ��������
-- �����͸� ����� �Է��Ѵ�
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
 
-- �˻���ؼ� ���̺��� ���ؼ� Rev No�� �� �������ѳ��´�
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

-- �˻��׸� �����͸� ���ο� RevNo�� �����س��´�
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

-- tQQcStandardChangeDetail���� �����͸� �ִ´�
-- Ȥ�� ������ �� garbage �����͸� �����ؼ�
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

-- tQQcStandardDetail �� ���� �����ʹ� �����
delete	tQQcStandardDetail
 where	AreaCode = @ps_area_code
   and	DivisionCode = @ps_division_code
   and	SupplierCode = @ps_supplier_code
   and	ItemCode = @ps_item_code
   and	StandardRevNo = @ps_standard_rev_no

-- ���躯�� Flag�� �����Ѵ�.
-- ���躯�� ���϶��� ������ �����Ƿڸ� �� �� �ֵ���
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

