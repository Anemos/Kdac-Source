$PBExportHeader$w_wip05fu.srw
$PBExportComments$������Ȳ����(�渮)
forward
global type w_wip05fu from w_origin_sheet02
end type
type uo_1 from uo_wip_plandiv within w_wip05fu
end type
type uo_to from uo_yymm_boongi within w_wip05fu
end type
type st_1 from statictext within w_wip05fu
end type
type dw_wip05fu_01 from datawindow within w_wip05fu
end type
type cb_confirm from commandbutton within w_wip05fu
end type
type cb_cancel from commandbutton within w_wip05fu
end type
type st_2 from statictext within w_wip05fu
end type
type pb_down from picturebutton within w_wip05fu
end type
type rb_free from radiobutton within w_wip05fu
end type
type rb_cost from radiobutton within w_wip05fu
end type
type gb_1 from groupbox within w_wip05fu
end type
type gb_2 from groupbox within w_wip05fu
end type
end forward

global type w_wip05fu from w_origin_sheet02
uo_1 uo_1
uo_to uo_to
st_1 st_1
dw_wip05fu_01 dw_wip05fu_01
cb_confirm cb_confirm
cb_cancel cb_cancel
st_2 st_2
pb_down pb_down
rb_free rb_free
rb_cost rb_cost
gb_1 gb_1
gb_2 gb_2
end type
global w_wip05fu w_wip05fu

type variables
String is_adjdt
end variables

on w_wip05fu.create
int iCurrent
call super::create
this.uo_1=create uo_1
this.uo_to=create uo_to
this.st_1=create st_1
this.dw_wip05fu_01=create dw_wip05fu_01
this.cb_confirm=create cb_confirm
this.cb_cancel=create cb_cancel
this.st_2=create st_2
this.pb_down=create pb_down
this.rb_free=create rb_free
this.rb_cost=create rb_cost
this.gb_1=create gb_1
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_1
this.Control[iCurrent+2]=this.uo_to
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.dw_wip05fu_01
this.Control[iCurrent+5]=this.cb_confirm
this.Control[iCurrent+6]=this.cb_cancel
this.Control[iCurrent+7]=this.st_2
this.Control[iCurrent+8]=this.pb_down
this.Control[iCurrent+9]=this.rb_free
this.Control[iCurrent+10]=this.rb_cost
this.Control[iCurrent+11]=this.gb_1
this.Control[iCurrent+12]=this.gb_2
end on

on w_wip05fu.destroy
call super::destroy
destroy(this.uo_1)
destroy(this.uo_to)
destroy(this.st_1)
destroy(this.dw_wip05fu_01)
destroy(this.cb_confirm)
destroy(this.cb_cancel)
destroy(this.st_2)
destroy(this.pb_down)
destroy(this.rb_free)
destroy(this.rb_cost)
destroy(this.gb_1)
destroy(this.gb_2)
end on

event ue_retrieve;call super::ue_retrieve;dec{0} ld_yyyymm
string ls_fromdt,ls_todt, ls_plant, ls_dvsn, ls_part, ls_iocd
string ls_year, ls_month
long ll_rowcnt

dw_wip05fu_01.reset()

ld_yyyymm     = uo_to.uf_yyyymm()
is_adjdt        = string(ld_yyyymm)
ls_year = mid(is_adjdt,1,4)
ls_month = mid(is_adjdt,5,2)
ls_fromdt      = uf_wip_addmonth(is_adjdt,-2)
ls_plant = trim(uo_1.dw_1.getitemstring(1,'xplant'))
ls_dvsn  = trim(uo_1.dw_1.getitemstring(1,'div'))

if rb_free.checked then
	ls_iocd = '2'
else
	ls_iocd = '3'
end if

if f_spacechk(ls_plant) = -1 then
	ls_plant = '%'
else
	ls_plant = ls_plant + '%'
end if
if f_spacechk(ls_dvsn) = -1 then
	ls_dvsn = '%'
else
	ls_dvsn = ls_dvsn + '%'
end if

ll_rowcnt = dw_wip05fu_01.retrieve(ls_year, ls_month, '01', ls_plant, ls_dvsn, ls_iocd)
if ll_rowcnt < 1 then
	uo_status.st_message.text = '��ȸ�� �ڷᰡ �����ϴ�.'
else
	if f_wip_check_stdt( g_s_company, is_adjdt ) then
		
		SELECT count(*)  
			INTO :ll_rowcnt  
			FROM "PBWIP"."WIP009"  
			WHERE ( "PBWIP"."WIP009"."WFCMCD" = :g_s_company ) AND
					( "PBWIP"."WIP009"."WFYEAR" = :ls_year ) AND  
					( "PBWIP"."WIP009"."WFMONTH" = :ls_month ) AND  
					( "PBWIP"."WIP009"."WFIOCD" = :ls_iocd ) AND    
					( "PBWIP"."WIP009"."WFSTSCD" < '4' )   
			using sqlca;
			
		if ll_rowcnt > 0 then
			cb_confirm.enabled = false
		else
			cb_confirm.enabled = true
		end if
		cb_cancel.enabled = true
	else
		cb_confirm.enabled = false
		cb_cancel.enabled = false
	end if

	uo_status.st_message.text = '��ȸ�Ǿ����ϴ�.'
end if
end event

event open;call super::open;
dw_wip05fu_01.settransobject(sqlca)

cb_cancel.enabled = false
// ��ȸ, �Է�, ����, ����, �μ�, ó��, ����, ��, ����ȸ, ȭ���μ�, Ư������
wf_icon_onoff(TRUE, FALSE, TRUE, FALSE, FALSE, FALSE, &
			FALSE, FALSE, FALSE, FALSE, FALSE, FALSE)
end event

event ue_save;call super::ue_save;dw_wip05fu_01.accepttext()

if dw_wip05fu_01.update() <> 1 then
	uo_status.st_message.text = '�����ڵ� ������ �����߽��ϴ�.'
	return 0
end if

return 0
end event

type uo_status from w_origin_sheet02`uo_status within w_wip05fu
end type

type uo_1 from uo_wip_plandiv within w_wip05fu
integer x = 64
integer y = 64
integer taborder = 20
boolean bringtotop = true
end type

on uo_1.destroy
call uo_wip_plandiv::destroy
end on

type uo_to from uo_yymm_boongi within w_wip05fu
integer x = 1710
integer y = 68
integer taborder = 30
boolean bringtotop = true
end type

on uo_to.destroy
call uo_yymm_boongi::destroy
end on

type st_1 from statictext within w_wip05fu
integer x = 1339
integer y = 80
integer width = 357
integer height = 64
boolean bringtotop = true
integer textsize = -11
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 33554432
long backcolor = 12632256
string text = "���س��"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_wip05fu_01 from datawindow within w_wip05fu
integer x = 32
integer y = 332
integer width = 4530
integer height = 2136
integer taborder = 40
boolean bringtotop = true
string title = "none"
string dataobject = "d_wip05fu_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;integer li_rowcnt

li_rowcnt = this.rowcount()
if row > 0 and row <= li_rowcnt then
	this.selectrow(0, false)
	this.selectrow(row,true)
end if

return 0
end event

type cb_confirm from commandbutton within w_wip05fu
integer x = 3090
integer y = 56
integer width = 462
integer height = 112
integer taborder = 40
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
string text = "�渮Ȯ��"
end type

event clicked;dec{0} ld_yyyymm
integer li_rtn, li_mm, li_year
string ls_year, ls_mm, ls_yyyymm, ls_currdt,ls_nextdt, ls_iocd

ld_yyyymm     = uo_to.uf_yyyymm()
ls_currdt        = string(ld_yyyymm)
ls_year = mid(ls_currdt,1,4)
ls_mm = mid(ls_currdt,5,2)

li_rtn = MessageBox("�渮Ȯ��", "�渮Ȯ���� �Ϸ�� �ڿ��� �ý��۰����������� ��Ұ� �����մϴ�. ~r" &
		+ ls_currdt + "�� �渮Ȯ���� �����Ͻðڽ��ϱ�?", Exclamation!, OKCancel!, 2)
		
if li_rtn = 2 then
	return 0
end if  

if rb_free.checked then
	ls_iocd = '2'
else
	ls_iocd = '3'
end if

//�ش�б� ����ü �渮Ȯ�� (wip009)
UPDATE "PBWIP"."WIP009"  
   SET "WFSTSCD" = '5'  
   WHERE ( "PBWIP"."WIP009"."WFCMCD" = '01' ) AND  
			( "PBWIP"."WIP009"."WFYEAR" = :ls_year ) AND  
         ( "PBWIP"."WIP009"."WFMONTH" = :ls_mm ) AND
			( "PBWIP"."WIP009"."WFIOCD" = :ls_iocd )  
   using sqlca;

if sqlca.sqlcode = 0 and sqlca.sqlnrows > 0 then
	uo_status.st_message.text = '����Ȯ���� �Ϸ�Ǿ����ϴ�.'
else
	uo_status.st_message.text = '�渮Ȯ���� ������ �߻��Ͽ����ϴ�.'
end if

If g_s_empno <> '000030' Then
	messagebox("�˸�", "�ý��۰����� �������ڿ��� ������ҹݿ� ��û�ٶ��ϴ�.")
	return 0
End If

setpointer(hourglass!)
uo_status.st_message.text = '����Ȯ������Ÿ �ݿ��۾��� �������Դϴ�.'
//�ش�б� ����ü �渮Ȯ�� (wip009)
UPDATE "PBWIP"."WIP009"  
   SET "WFSTSCD" = '5'  
   WHERE ( "PBWIP"."WIP009"."WFYEAR" = :ls_year ) AND  
         ( "PBWIP"."WIP009"."WFMONTH" = :ls_mm )   
   using sqlca;

if sqlca.sqlcode = 0 and sqlca.sqlnrows > 0 then
	//�ش�б� ���Ϸ� (wip090)
	li_year = integer(ls_year)
	li_mm = integer(ls_mm)
	li_mm = li_mm + 3
	if li_mm > 12 then
		li_year ++
		li_mm = 3
	end if
	ls_year = string(li_year)
	ls_mm = right( '0' + trim(string(li_mm)), 2)
	ls_yyyymm = ls_year + ls_mm
	ls_nextdt = uf_wip_addmonth( ls_currdt , 1 )
	
	UPDATE "PBWIP"."WIP090"  
   	SET "WZSTDT" = :ls_yyyymm  
   	WHERE ( "PBWIP"."WIP090"."WZCMCD" = :g_s_company )   
	using sqlca;
	
	if sqlca.sqlcode = 0 and sqlca.sqlnrows > 0 then
		//���� ����Ÿ ������Ʈ ( wip002, wip001 )
		DECLARE up_wip_024 PROCEDURE FOR PBWIP.SP_WIP_024  
         A_CMCD = :g_s_company,   
         A_CURRDT = :ls_currdt,  
			A_IOCD = :ls_iocd,
         A_NEXTDT = :ls_nextdt,   
         A_IPADDR = :g_s_ipaddr,   
         A_MACADDR = :g_s_macaddr,   
         A_INPTDT = :g_s_date,   
         A_UPDTDT = :g_s_date  using sqlca;
		Execute up_wip_024;
		Close up_wip_024;
		
		if ls_iocd = '2' then
			if f_wip050_cost_pcc950(ls_yyyymm) = -1 then
				uo_status.st_message.text = '����ȸ�� ��������۾��� ������ �߻��߽��ϴ�.'
				return 0
			end if
		end if
		
		UPDATE "PBWIP"."WIP090"  
   		SET "WZVSTSCD" = 'C' 
   		WHERE ( "PBWIP"."WIP090"."WZCMCD" = :g_s_company )   
		using sqlca;
		
		uo_status.st_message.text = '����Ȯ���� �Ϸ�Ǿ����ϴ�.'
	else
		uo_status.st_message.text = '����Ϸ�� ������ �߻��Ͽ����ϴ�.'
	end if
else
	uo_status.st_message.text = '�渮Ȯ���� ������ �߻��Ͽ����ϴ�.'
end if

return 0
end event

type cb_cancel from commandbutton within w_wip05fu
integer x = 3625
integer y = 56
integer width = 462
integer height = 112
integer taborder = 40
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
string text = "Ȯ�����"
end type

event clicked;
long	ll_row, ll_LastRow, ll_index = 1, ll_select_row 
long	ll_SaveRow[] 
string ls_plant, ls_dvsn, ls_vendor, ls_rtncd, ls_cttp, ls_year, ls_month, ls_stscd, ls_iocd

setpointer(hourglass!)
// ���õ� ���� �ִ��� üũ�Ѵ�
//
ll_row = dw_wip05fu_01.GetSelectedRow(0)
IF ll_row = 0 THEN
	// ���õ� ���� ������ ����
	//
	RETURN 0
ELSE
	// ���õ� ���� ã�Ƽ� �迭�� ���õ����� ���ȣ�� �����Ѵ�
	//
	do
		ll_SaveRow[ll_index] = ll_row
		ll_index++
		ll_row = dw_wip05fu_01.GetSelectedRow(ll_row)
	loop while ll_row > 0
END IF

// ����ȭ���� ���õ� �ڷḦ ����ȭ������ �̵��Ѵ�
// 
FOR ll_row = 1 TO ll_index - 1
	// ����ȭ�鿡 ���྿�� ����鼭 ����ȭ���� �ڷḦ ����ȭ�鿡 ��Ʈ�Ѵ�
	ls_year   = dw_wip05fu_01.getitemstring(ll_SaveRow[ll_row],'wip009_wfyear')
	ls_month  = dw_wip05fu_01.getitemstring(ll_SaveRow[ll_row],'wip009_wfmonth')
	ls_plant  = dw_wip05fu_01.getitemstring(ll_SaveRow[ll_row],'wip009_wfplant')
	ls_dvsn   = dw_wip05fu_01.getitemstring(ll_SaveRow[ll_row],'wip009_wfdvsn')
	ls_vendor = dw_wip05fu_01.getitemstring(ll_SaveRow[ll_row],'wip009_wfvendor')
	ls_stscd = dw_wip05fu_01.getitemstring(ll_SaveRow[ll_row],'wip009_wfstscd')
	ls_iocd = dw_wip05fu_01.getitemstring(ll_SaveRow[ll_row],'wip009_wfiocd')
	if ls_stscd = '4' or ls_stscd = '5' then
		// �ش�����, ���忡 ���� �ܰ���� �ϷῩ�θ� üũ�Ѵ�.
		UPDATE "PBWIP"."WIP009"  
			SET "WFSTSCD" = '2'  
			WHERE ( "PBWIP"."WIP009"."WFCMCD" = :g_s_company ) AND 
					( "PBWIP"."WIP009"."WFYEAR" = :ls_year ) AND  
					( "PBWIP"."WIP009"."WFMONTH" = :ls_month ) AND  
					( "PBWIP"."WIP009"."WFIOCD" = :ls_iocd ) AND
					( "PBWIP"."WIP009"."WFPLANT" = :ls_plant ) AND  
					( "PBWIP"."WIP009"."WFDVSN" = :ls_dvsn ) AND  
					( "PBWIP"."WIP009"."WFVENDOR" = :ls_vendor )			
			using sqlca;
	end if
NEXT

parent.Triggerevent('ue_retrieve')
uo_status.st_message.text = 'Ȯ����Ұ� �Ϸ�Ǿ����ϴ�.'
return 0
end event

type st_2 from statictext within w_wip05fu
integer x = 37
integer y = 232
integer width = 3785
integer height = 64
boolean bringtotop = true
integer textsize = -11
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 128
long backcolor = 12632256
string text = "�渮Ȯ���� ������, ����ü�� ����Ȯ�����¿��� �մϴ�. Ȯ����Ҵ� ���õ� ��ü�� 1��Ȯ�����·� �ٲ�ϴ�."
boolean focusrectangle = false
end type

type pb_down from picturebutton within w_wip05fu
integer x = 4146
integer y = 48
integer width = 155
integer height = 132
integer taborder = 50
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
string picturename = "C:\kdac\bmp\Excel.bmp"
alignment htextalign = left!
end type

event clicked;if dw_wip05fu_01.rowcount() < 1 then
	uo_status.st_message.text = "�ٿ�ε��� �ڷᰡ �����ϴ�."
	return 0
end if

f_save_to_excel(dw_wip05fu_01)

return 0
end event

type rb_free from radiobutton within w_wip05fu
integer x = 2295
integer y = 76
integer width = 375
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "������"
boolean checked = true
boolean automatic = false
end type

type rb_cost from radiobutton within w_wip05fu
integer x = 2647
integer y = 84
integer width = 357
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "������"
boolean automatic = false
end type

type gb_1 from groupbox within w_wip05fu
integer x = 27
integer width = 2994
integer height = 196
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

type gb_2 from groupbox within w_wip05fu
integer x = 3035
integer y = 4
integer width = 1307
integer height = 192
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 33554432
long backcolor = 12632256
end type

