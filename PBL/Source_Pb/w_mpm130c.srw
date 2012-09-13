$PBExportHeader$w_mpm130c.srw
$PBExportComments$�Ҹ����� ���
forward
global type w_mpm130c from w_ipis_sheet01
end type
type uo_1 from u_mpms_date_scroll_month within w_mpm130c
end type
type dw_mpm130c_01 from u_vi_std_datawindow within w_mpm130c
end type
type dw_mpm130c_02 from datawindow within w_mpm130c
end type
type gb_1 from groupbox within w_mpm130c
end type
end forward

global type w_mpm130c from w_ipis_sheet01
uo_1 uo_1
dw_mpm130c_01 dw_mpm130c_01
dw_mpm130c_02 dw_mpm130c_02
gb_1 gb_1
end type
global w_mpm130c w_mpm130c

type variables
string is_yyyymm
str_mpms_parm istr_1
end variables

on w_mpm130c.create
int iCurrent
call super::create
this.uo_1=create uo_1
this.dw_mpm130c_01=create dw_mpm130c_01
this.dw_mpm130c_02=create dw_mpm130c_02
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_1
this.Control[iCurrent+2]=this.dw_mpm130c_01
this.Control[iCurrent+3]=this.dw_mpm130c_02
this.Control[iCurrent+4]=this.gb_1
end on

on w_mpm130c.destroy
call super::destroy
destroy(this.uo_1)
destroy(this.dw_mpm130c_01)
destroy(this.dw_mpm130c_02)
destroy(this.gb_1)
end on

event ue_insert;call super::ue_insert;long ll_currow

ll_currow = dw_mpm130c_02.insertrow(0)
dw_mpm130c_02.setitem(ll_currow,'yearmm', mid(is_yyyymm,1,6))
dw_mpm130c_02.setitem(ll_currow,'empno', g_s_empno)

dw_mpm130c_02.setcolumn('orderdept')
dw_mpm130c_02.setfocus()
end event

event ue_save;call super::ue_save;string ls_orderdept
long ll_rowcnt, ll_cnt, ll_chkcnt
dec{0} lc_sum, lc_cal_sum
dec{1} lc_portion, lc_portion_sum

dw_mpm130c_01.accepttext()
dw_mpm130c_02.accepttext()

lc_sum = dw_mpm130c_01.object.compute_3[1]
ll_rowcnt = dw_mpm130c_02.rowcount()
if f_mpms_mandantory_chk(dw_mpm130c_02) = -1 then
	uo_status.st_message.text = "������ ������ �ֽ��ϴ�."
	return 0
end if

lc_portion_sum = 0
lc_cal_sum = 0
if dw_mpm130c_02.modifiedcount() > 0 then
	for ll_cnt = 1 to ll_rowcnt
		lc_portion = dw_mpm130c_02.getitemdecimal( ll_cnt, "deptportion" )
		ls_orderdept = dw_mpm130c_02.getitemstring( ll_cnt, "orderdept" )
		
		SELECT COUNT(*) INTO :ll_chkcnt
		FROM TMSTDEPT
		WHERE DeptCode = :ls_orderdept
		using sqlmpms;
		if ll_chkcnt = 0 then
			uo_status.st_message.text = ls_orderdept + " �� �μ��� ��ϵ� �μ��ڵ尡 �ƴմϴ�."
			return 0
		end if
		
		lc_cal_sum = lc_cal_sum + round(lc_sum * lc_portion / 100,0)
		if ll_cnt = ll_rowcnt and lc_cal_sum <> lc_sum then
			if lc_cal_sum > lc_sum then
				dw_mpm130c_02.setitem(ll_cnt, "submatcost", &
						round(lc_sum * lc_portion / 100,0) + (lc_cal_sum - lc_sum))
			else
				dw_mpm130c_02.setitem(ll_cnt, "submatcost", &
						round(lc_sum * lc_portion / 100,0) + (lc_sum - lc_cal_sum))
			end if
		else
			dw_mpm130c_02.setitem(ll_cnt, "submatcost", round(lc_sum * lc_portion / 100,0))
		end if
		lc_portion_sum = lc_portion_sum + lc_portion
	next
	
	if lc_portion_sum <> 100.0 then
		uo_status.st_message.text = "��������� 100�� �ش����� �ʽ��ϴ�."
		return 0
	end if
end if

sqlmpms.AutoCommit = False

if dw_mpm130c_01.modifiedcount() > 0 then
	if dw_mpm130c_01.update() <> 1 then
		goto RollBack_
	end if
end if
if dw_mpm130c_02.modifiedcount() > 0 then
	if dw_mpm130c_02.update() <> 1 then
		goto RollBack_
	end if
end if

Commit using sqlmpms;
sqlmpms.AutoCommit = True
uo_status.st_message.text = "���������� ó���Ǿ����ϴ�."
return 0

RollBack_:
RollBack using sqlmpms;
sqlmpms.Autocommit = True
uo_status.st_message.text = "ó���߿� ������ �߻��Ͽ����ϴ�."
return 0
end event

event ue_delete;call super::ue_delete;long ll_selrow, ll_rtn
string ls_orderdept

ll_selrow = dw_mpm130c_02.getselectedrow(0)

if ll_selrow < 1 then
	messagebox("�˸�","���õ� ����Ÿ�� �����ϴ�.")
	return 0
end if

ls_orderdept = dw_mpm130c_02.getitemstring(ll_selrow,'orderdept')

ll_rtn = MessageBox("�˸�", " �μ� : " + ls_orderdept + " ����Ÿ�� �����Ͻðڽ��ϱ�?", &
				Exclamation!, OKCancel!, 2)
if ll_rtn  = 2 then
	return 0
end if

dw_mpm130c_02.deleterow(ll_selrow)

sqlmpms.AutoCommit = False
if dw_mpm130c_02.update() = 1 then
	Commit using sqlmpms;
	messagebox("�˸�","���������� ó���Ǿ����ϴ�.")
else
	RollBack using sqlmpms;
	messagebox("�˸�","ó���߿� ������ �߻��Ͽ����ϴ�.")
end if
sqlmpms.Autocommit = True
return 0

end event

event resize;call super::resize;Integer ls_split = 20 	// splitbar �� Height �Ǵ� Width �� 20 
Integer ls_gap = 10 		// window �� dw_control �� Gap�� 5
Integer ls_status = 100 // statusbar �� ���̴� 120 ( Gap ���� )

dw_mpm130c_01.Width = newwidth 	- ( ls_gap * 3 )
dw_mpm130c_01.Height= ( newheight * 3 / 5 ) - dw_mpm130c_01.y

dw_mpm130c_02.x = dw_mpm130c_01.x
dw_mpm130c_02.y = dw_mpm130c_01.y + dw_mpm130c_01.Height + ls_split
dw_mpm130c_02.Width = dw_mpm130c_01.Width
dw_mpm130c_02.Height = newheight - ( dw_mpm130c_01.Height + dw_mpm130c_01.y + ls_status)
end event

event ue_postopen;call super::ue_postopen;datawindowchild ldwc

dw_mpm130c_01.settransobject(sqlmpms)
dw_mpm130c_02.settransobject(sqlmpms)

istr_1 = message.PowerObjectParm

dw_mpm130c_01.GetChild('matcls', ldwc)
ldwc.settransobject(sqlmpms)
ldwc.retrieve('MPM009')
if ldwc.RowCount() < 1 then
	ldwc.InsertRow(0)
end if

f_pisc_set_dddw_width(dw_mpm130c_01,'matcls',ldwc,'codename',5)

if Isvalid(istr_1) then
	i_s_level = istr_1.s_parm[1]
	This.title = istr_1.s_parm[2]
	is_yyyymm = mid(istr_1.s_parm[3],1,6)
	
	string ls_result, ls_date

	ls_result = f_mpms_get_monthjob(is_yyyymm)

	if ls_result = 'C' then
		// ��ȸ, �Է�, ����, ����, �μ�, ó��, ����, ��, ����ȸ, ȭ���μ�, Ư������
		i_b_retrieve 	= True
		i_b_insert 	 	= False
		i_b_save 		= False
		i_b_delete 		= False
		i_b_print 		= False
		i_b_dretrieve 	= False
		i_b_dprint 		= False
		i_b_dchar 		= False
	else
		// ��ȸ, �Է�, ����, ����, �μ�, ó��, ����, ��, ����ȸ, ȭ���μ�, Ư������
		i_b_retrieve 	= True
		i_b_insert 	 	= True
		i_b_save 		= True
		i_b_delete 		= True
		i_b_print 		= False
		i_b_dretrieve 	= False
		i_b_dprint 		= False
		i_b_dchar 		= False
	end if
	wf_icon_onoff(i_b_retrieve,  i_b_insert,  i_b_save,  i_b_delete,  i_b_print,      & 
				  i_b_dretrieve,  i_b_dprint,    i_b_dchar)

	ls_date = string(is_yyyymm + '01','@@@@-@@-@@')
	uo_1.uf_setdata( date( ls_date ) )
	This.Triggerevent('ue_retrieve')
end if
end event

event ue_retrieve;call super::ue_retrieve;				  
dw_mpm130c_01.reset()
dw_mpm130c_02.reset()

dw_mpm130c_01.retrieve( '%', '%', istr_1.s_parm[3], istr_1.s_parm[4])
dw_mpm130c_02.retrieve( is_yyyymm )
end event

type uo_status from w_ipis_sheet01`uo_status within w_mpm130c
end type

type uo_1 from u_mpms_date_scroll_month within w_mpm130c
integer x = 82
integer y = 56
integer taborder = 11
boolean bringtotop = true
boolean enabled = false
end type

on uo_1.destroy
call u_mpms_date_scroll_month::destroy
end on

type dw_mpm130c_01 from u_vi_std_datawindow within w_mpm130c
integer x = 27
integer y = 172
integer width = 3237
integer height = 868
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_mpm130c_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
end type

type dw_mpm130c_02 from datawindow within w_mpm130c
integer x = 27
integer y = 1068
integer width = 3232
integer height = 816
integer taborder = 21
boolean bringtotop = true
string title = "none"
string dataobject = "d_mpm130c_02"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;//
//This.Accepttext()
//
//choose case dwo.name
//	case 'DeptPortion'
//		if dec(data) = 0 then
//			This.setitem( row, "deptportion", 1)
//		end if
//End Choose
//
//return 1
end event

event buttonclicked;string ls_rtn

if dwo.name = 'b_find' then
	openwithparm(w_mpms_find_dept,'1')
	ls_rtn = message.stringparm
	
	This.setitem( row, 'orderdept', ls_rtn)
end if

return 1
end event

event clicked;IF row <= 0 THEN RETURN

THIS.SetRow(row)

//�ѹ��� 1���� ROW�� ����
THIS.SelectRow(0,FALSE)
THIS.SelectRow(row,TRUE)

end event

type gb_1 from groupbox within w_mpm130c
integer x = 27
integer y = 8
integer width = 686
integer height = 148
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 33554432
long backcolor = 12632256
end type

