$PBExportHeader$w_wip023u.srw
$PBExportComments$��Ÿ�μ�����
forward
global type w_wip023u from w_origin_sheet01
end type
type tab_1 from tab within w_wip023u
end type
type tabpage_1 from userobject within tab_1
end type
type gb_1 from groupbox within tabpage_1
end type
type dw_1 from datawindow within tabpage_1
end type
type dw_4 from datawindow within tabpage_1
end type
type tabpage_1 from userobject within tab_1
gb_1 gb_1
dw_1 dw_1
dw_4 dw_4
end type
type tabpage_2 from userobject within tab_1
end type
type dw_2 from datawindow within tabpage_2
end type
type cb_insert from commandbutton within tabpage_2
end type
type cb_delete from commandbutton within tabpage_2
end type
type gb_3 from groupbox within tabpage_2
end type
type dw_6 from datawindow within tabpage_2
end type
type tabpage_2 from userobject within tab_1
dw_2 dw_2
cb_insert cb_insert
cb_delete cb_delete
gb_3 gb_3
dw_6 dw_6
end type
type tabpage_3 from userobject within tab_1
end type
type gb_2 from groupbox within tabpage_3
end type
type dw_3 from datawindow within tabpage_3
end type
type dw_5 from datawindow within tabpage_3
end type
type pb_down from picturebutton within tabpage_3
end type
type tabpage_3 from userobject within tab_1
gb_2 gb_2
dw_3 dw_3
dw_5 dw_5
pb_down pb_down
end type
type tab_1 from tab within w_wip023u
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
end type
type st_1 from statictext within w_wip023u
end type
end forward

global type w_wip023u from w_origin_sheet01
integer height = 2724
string title = "��Ÿ�μ�����"
tab_1 tab_1
st_1 st_1
end type
global w_wip023u w_wip023u

type variables
//�������� Index
integer i_n_index
//BULK�Է½� ���ǵ���Ÿ
dec{3}  i_n_qty
string i_s_slno, i_s_dept, i_s_pitno, i_s_date, i_s_purno, i_s_projectno &
			, i_s_plant, i_s_dvsn
//�̺�Ʈ �帧
string i_s_gubun
datastore ids_data
long     i_i_LastRow
end variables

forward prototypes
public function integer wf_shift_highlight (integer al_aclickedrow, datawindow dw)
public subroutine wf_protect (string a_gubun)
public function string wf_inputdata_03 (string a_gubun, datawindow arg_dw)
public subroutine wf_rgbset (string ag_s_column, integer ag_n_number, integer ag_n_color, datawindow ag_dw_1)
public function string wf_inputdata_01 (string a_gubun, datawindow arg_dw)
end prototypes

public function integer wf_shift_highlight (integer al_aclickedrow, datawindow dw);integer	l_i_Idx, l_i_last_row

l_i_last_row = i_i_LastRow

dw.setredraw(false)
dw.selectrow(0,false)

If l_i_last_row = 0 then
	dw.setredraw(true)
	Return 1
end if

if l_i_last_row > al_aclickedrow then
	For l_i_Idx = l_i_last_row to al_aclickedrow STEP -1
		dw.selectrow(l_i_Idx,TRUE)	
	end for	
else
	For l_i_Idx = l_i_last_row to al_aclickedrow 
		dw.selectrow(l_i_Idx,TRUE)	
	next	
end if

dw.setredraw(true)
Return 1

end function

public subroutine wf_protect (string a_gubun);if a_gubun = 'P' then
	tab_1.tabpage_2.dw_2.object.wdplant.protect = true
	tab_1.tabpage_2.dw_2.object.wddvsn.protect = true
	tab_1.tabpage_2.dw_2.object.wdslno.protect  = true
	tab_1.tabpage_2.dw_2.object.wdprdpt.protect = true
	tab_1.tabpage_2.dw_2.object.wditno.protect  = true
	tab_1.tabpage_2.dw_2.object.chqt.protect           = false
	tab_1.tabpage_2.dw_2.object.wddate.protect           = false
	tab_1.tabpage_2.dw_2.object.chqt.background.color  = 15780518
	tab_1.tabpage_2.dw_2.object.wddate.background.color  = 15780518
	tab_1.tabpage_2.dw_2.object.wdslno.background.color  = rgb(192,192,192)
	tab_1.tabpage_2.dw_2.object.wdprdpt.background.color = rgb(192,192,192)
	tab_1.tabpage_2.dw_2.object.wditno.background.color  = rgb(192,192,192)
elseif a_gubun = 'N' then
	tab_1.tabpage_2.dw_2.object.wdplant.protect = false
	tab_1.tabpage_2.dw_2.object.wddvsn.protect = false
	tab_1.tabpage_2.dw_2.object.wdslno.protect  = false
	tab_1.tabpage_2.dw_2.object.wdprdpt.protect = false
	tab_1.tabpage_2.dw_2.object.wditno.protect  = false
	tab_1.tabpage_2.dw_2.object.chqt.protect           = false
	tab_1.tabpage_2.dw_2.object.wddate.protect           = false
	tab_1.tabpage_2.dw_2.object.chqt.background.color  = 15780518
	tab_1.tabpage_2.dw_2.object.wddate.background.color  = 15780518
	tab_1.tabpage_2.dw_2.object.wdslno.background.color  = 15780518
	tab_1.tabpage_2.dw_2.object.wdprdpt.background.color = 15780518
	tab_1.tabpage_2.dw_2.object.wditno.background.color  = 15780518
elseif a_gubun = 'Z' then
	tab_1.tabpage_2.dw_2.object.wdplant.protect = true
	tab_1.tabpage_2.dw_2.object.wddvsn.protect = true
	tab_1.tabpage_2.dw_2.object.wdslno.protect  = true
	tab_1.tabpage_2.dw_2.object.wdprdpt.protect = true
	tab_1.tabpage_2.dw_2.object.wditno.protect  = true
	tab_1.tabpage_2.dw_2.object.chqt.protect  = true
	tab_1.tabpage_2.dw_2.object.wddate.protect  = true
	tab_1.tabpage_2.dw_2.object.wdslno.background.color  = rgb(192,192,192)
	tab_1.tabpage_2.dw_2.object.wdprdpt.background.color = rgb(192,192,192)
	tab_1.tabpage_2.dw_2.object.wditno.background.color  = rgb(192,192,192)
	tab_1.tabpage_2.dw_2.object.chqt.background.color  = rgb(192,192,192)
	tab_1.tabpage_2.dw_2.object.wddate.background.color  = rgb(192,192,192)
end if


end subroutine

public function string wf_inputdata_03 (string a_gubun, datawindow arg_dw);string l_s_return,l_s_focus, ls_plant, ls_dvsn, ls_pitno, ls_fromdt, ls_todt
string ls_rtn
integer l_n_slchk,l_n_count

l_s_return = ' '
ls_plant = arg_dw.getitemstring(1,"wip001_waplant")
ls_dvsn = arg_dw.getitemstring(1,"wip001_wadvsn")
ls_pitno = arg_dw.getitemstring(1,"wip001_waitno")
ls_fromdt = arg_dw.getitemstring(1,"wip001_wainptdt")
ls_todt = arg_dw.getitemstring(1,"wip001_waupdtdt")

if f_dateedit(ls_fromdt) = space(8) then
	ls_rtn = arg_dw.modify("wip001_wainptdt.background.color = 65535")
	l_s_return = 'E'
else
	ls_rtn = arg_dw.modify("wip001_wainptdt.background.color = 15780518")
end if

if f_dateedit(ls_todt) = space(8) then
	ls_rtn = arg_dw.modify("wip001_waupdtdt.background.color = 65535")
	l_s_return = 'E'
else
	ls_rtn = arg_dw.modify("wip001_waupdtdt.background.color = 15780518")
end if

return trim(l_s_return)
end function

public subroutine wf_rgbset (string ag_s_column, integer ag_n_number, integer ag_n_color, datawindow ag_dw_1);string l_s_command
string ls_rtn
long 	 l_l_white = 1090519039						//	white
long 	 l_l_sky = 15780518						   //	sky
long 	 l_l_yellow = 65535						   //	yellow
long   l_l_gray  = 536870912						// gray

//--	Argument	=> ag_s_column = column ��, 
//---             ag_n_number = column ����,
//--  				ag_n_color  = column ����( 1 = Sky, 2 = White[255,255,255] )  
ag_dw_1.setredraw(False)
if ag_n_color 	= 	1	then
//	l_s_command	=	ag_s_column + ".Background.Color = '" + String(l_l_white) &            
//					+	"~tIf(mid(cp_chk," + string(ag_n_number) + ", 1) =" + "~~'1~~' ," & 
//					+ 	" rgb(255,255,0), " + "~tIf(mid(cp_chk," + string(ag_n_number) + ", 1) =" + "~~'2~~' ," &
//					+  " rgb(192,192,192),rgb(255,250,239)))'"
	l_s_command	=	ag_s_column + ".Background.Color = '" + String(l_l_white) &            
					+	"~tIf(mid(cp_chk," + string(ag_n_number) + ", 1) =" + "~~'1~~' ," & 
					+ 	string(l_l_yellow) + ",~tIf(mid(cp_chk," + string(ag_n_number) + ", 1) =" + "~~'2~~' ," &
					+  string(l_l_gray) + "," + string(l_l_sky) + "))'"
else
//	l_s_command	=	ag_s_column + ".Background.Color = '" + String(l_l_white) &            
//					+	"~tIf(mid(cp_chk," + string(ag_n_number) + ", 1) =" + "~~'1~~' ," & 
//					+ 	" rgb(255,255,0), " + "~tIf(mid(cp_chk," + string(ag_n_number) + ", 1) =" + "~~'2~~' ," &
//					+  " rgb(192,192,192),rgb(255,255,255)))'"
	l_s_command	=	ag_s_column + ".Background.Color = '" + String(l_l_white) &            
					+	"~tIf(mid(cp_chk," + string(ag_n_number) + ", 1) =" + "~~'1~~' ," & 
					+ 	string(l_l_yellow) + ", " + "~tIf(mid(cp_chk," + string(ag_n_number) + ", 1) =" + "~~'2~~' ," &
					+  string(l_l_gray) + "," + string(l_l_white) + "))'"
end if
ls_rtn = ag_dw_1.Modify(l_s_command)
ag_dw_1.setredraw(True)
end subroutine

public function string wf_inputdata_01 (string a_gubun, datawindow arg_dw);string l_s_return,l_s_focus,l_s_itnm, ls_cls, ls_srce, ls_errcolumn, ls_rtn
integer l_n_slchk,l_n_count
string ls_plant, ls_dvsn, ls_slno, ls_dept, ls_pitno, ls_adjdate, ls_purno
dec{3} lc_qty

l_s_focus  = ' '
l_s_return = ' '

//����Ÿ ��������
ls_plant = arg_dw.getitemstring(1,"wip001_waplant")
ls_dvsn = arg_dw.getitemstring(1,"wip001_wadvsn")
ls_slno = arg_dw.getitemstring(1,"slno")
ls_dept = arg_dw.getitemstring(1,"dept")
ls_pitno = arg_dw.getitemstring(1,"wip001_waitno")
ls_adjdate = arg_dw.getitemstring(1,"wip001_wainptdt")
ls_purno = arg_dw.getitemstring(1,"purno")
lc_qty = arg_dw.getitemdecimal(1,"wip001_quanty")
//�ν��Ͻ������� ����Ÿ ����
i_s_plant = ls_plant
i_s_dvsn = ls_dvsn
i_s_slno = ls_slno
i_s_dept = ls_dept
i_s_pitno = ls_pitno
i_s_date = ls_adjdate
i_s_purno = ls_purno
i_n_qty = lc_qty
//������ ��ȣ üũ
if f_spacechk(f_get_deptnm(mid(ls_slno,1,4),'5')) <> -1 then //�μ��ڵ�
	l_n_slchk = 1
end if
if mid(ls_slno,5,1) >= '0' and mid(ls_slno,5,1) <= '9' then //��
	l_n_slchk += 1
end if
if (mid(ls_slno,6,1) >= '1' and mid(ls_slno,6,1) <= '9') or &   
	 mid(ls_slno,6,1) = 'X' or mid(ls_slno,6,1) = 'Y' or mid(ls_slno,6,1) = 'Z' then //��
	l_n_slchk += 1
end if
if isnumber(mid(ls_slno,7,4)) = true then
	l_n_slchk += 1
end if
if l_n_slchk = 4 then
	ls_rtn = arg_dw.modify("slno.background.color = 15780518")
else
	ls_rtn = arg_dw.modify("slno.background.color = 65535")
	ls_errcolumn = "slno"
end if
//����ǰ���� ����뷱�� ��������
select cls, srce into:ls_cls,:ls_srce from pbinv.inv101
		where comltd = :g_s_company and xplant = :ls_plant and div = :ls_dvsn
				and itno = :ls_pitno
	using sqlca;
if sqlca.sqlcode <> 0 then
	ls_rtn = arg_dw.modify("wip001_waitno.background.color = 65535")
	if f_spacechk(ls_errcolumn) = -1 then
		ls_errcolumn = "slno"
	end if
else
	// ǰ�� üũ ( 10/03 )
	if (ls_cls = '10' and ls_srce = '03') or ls_cls = '30' then
		ls_rtn = arg_dw.modify("wip001_waitno.background.color = 15780518")
	else
		ls_rtn = arg_dw.modify("wip001_waitno.background.color = 65535")
		if f_spacechk(ls_errcolumn) = -1 then
			ls_errcolumn = "slno"
		end if
	end if
end if

//����μ� üũ
if f_spacechk(f_get_deptnm(ls_dept,'5')) <> -1 then
	ls_rtn = arg_dw.modify("dept.background.color = 15780518")
else
	ls_rtn = arg_dw.modify("dept.background.color = 65535")
	if f_spacechk(ls_errcolumn) = -1 then
		ls_errcolumn = "dept"
	end if
end if
//������� üũ
if isNull(lc_qty) = true or lc_qty = 0 then
	ls_rtn = arg_dw.modify("wip001_quanty.background.color = 65535")
	if f_spacechk(ls_errcolumn) = -1 then
		ls_errcolumn = "wip001_quanty"
	end if
else
	ls_rtn = arg_dw.modify("wip001_quanty.background.color = 15780518")
end if
//������ üũ
if f_dateedit(ls_adjdate) = space(8) then
	ls_rtn = arg_dw.modify("wip001_wainptdt.background.color = 65535")
	if f_spacechk(ls_errcolumn) = -1 then
		ls_errcolumn = "wip001_wainptdt"
	end if
else
	ls_rtn = arg_dw.modify("wip001_wainptdt.background.color = 15780518")
end if

if f_spacechk(ls_errcolumn) <> -1  then
	arg_dw.setcolumn(ls_errcolumn)
	arg_dw.setfocus()
	return 'N'
else
	return 'Y'
end if
end function

on w_wip023u.create
int iCurrent
call super::create
this.tab_1=create tab_1
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
this.Control[iCurrent+2]=this.st_1
end on

on w_wip023u.destroy
call super::destroy
destroy(this.tab_1)
destroy(this.st_1)
end on

event open;call super::open;datawindow ldw_01, ldw_02, ldw_03, ldw_04, ldw_05
datawindowchild dwc_01, dwc_02, dwc_03, dwc_04, dwc_05, dwc_06, dwc_07
i_n_index = 1
//uo_status.st_winid.text = this.classname()
//uo_status.st_kornm.text = g_s_kornm
//uo_status.st_date.text  = string(g_s_date, "@@@@-@@-@@")
ldw_01 = tab_1.tabpage_1.dw_1
ldw_02 = tab_1.tabpage_2.dw_6
ldw_03 = tab_1.tabpage_3.dw_3
ldw_04 = tab_1.tabpage_1.dw_4
ldw_05 = tab_1.tabpage_3.dw_5

ldw_01.settransobject(sqlca)
ldw_02.settransobject(sqlca)
ldw_03.settransobject(sqlca)
ldw_04.settransobject(sqlca)
ldw_05.settransobject(sqlca)
tab_1.tabpage_2.dw_2.settransobject(sqlca)

//TABPAGE_2
ldw_02.getchild("wip001_waplant",dwc_01)
dwc_01.settransobject(sqlca)
dwc_01.retrieve('SLE220')

ldw_02.getchild("wip001_wadvsn",dwc_02)
dwc_02.settransobject(sqlca)
dwc_02.retrieve('D')

ldw_02.insertrow(0)
//TABPAGE_1
ldw_04.getchild("wip001_waplant",dwc_03)
dwc_03.settransobject(sqlca)
dwc_03.retrieve('SLE220')

ldw_04.getchild("wip001_wadvsn",dwc_04)
dwc_04.settransobject(sqlca)
dwc_04.retrieve('D')
ldw_04.insertrow(0)
ldw_04.setitem(1,"wip001_wainptdt", g_s_date)
//TABPAGE_3
ldw_05.getchild("wip001_waplant",dwc_05)
dwc_05.settransobject(sqlca)
dwc_05.retrieve('SLE220')
ldw_05.getchild("wip001_wadvsn",dwc_06)
dwc_06.settransobject(sqlca)
dwc_06.retrieve('D')
ldw_05.getchild("inv101_pdcd",dwc_07)
dwc_07.settransobject(sqlca)
dwc_07.retrieve('A')

ldw_05.insertrow(0)
ldw_05.setitem(1,"wip001_wainptdt",g_s_date)
ldw_05.setitem(1,"wip001_waupdtdt",g_s_date)

ids_data                       = create datastore
ids_data.dataobject            = "d_wip023u_datastore"
ids_data.settransobject(sqlca)

i_s_gubun    = ' '
// ��ȸ, �Է�, ����, ����, ����ȸ, ȭ���μ�, Ư������
wf_icon_onoff(false, true, true, false, false, false, false)


end event

event ue_retrieve;call super::ue_retrieve;datawindow ldw_01,ldw_02,ldw_03,ldw_04,ldw_05
string ls_plant, ls_dvsn, ls_pitno, ls_slno, ls_adjdate, ls_fromdt, ls_todt, ls_pdcd
int i,l_n_rowcount
dec{3} l_n_qty
string l_s_wditno

ldw_01 = tab_1.tabpage_1.dw_1
ldw_02 = tab_1.tabpage_2.dw_2
ldw_03 = tab_1.tabpage_3.dw_3
ldw_04 = tab_1.tabpage_1.dw_4
ldw_05 = tab_1.tabpage_3.dw_5

uo_status.st_message.text = ' '
ldw_01.reset()
ldw_03.reset()

SetPointer(HourGlass!)

if i_n_index = 3 then
	ldw_05.accepttext()
	
	//ǰ�� üũ
	ls_plant = ldw_05.getitemstring(1,"wip001_waplant")
	ls_dvsn = ldw_05.getitemstring(1,"wip001_wadvsn")
	ls_pitno = ldw_05.getitemstring(1,"wip001_waitno")
	ls_pdcd = ldw_05.getitemstring(1,"inv101_pdcd")
	if f_spacechk(ls_pitno) <> -1 then
		if f_spacechk(ldw_05.getitemstring(1,"inv101_cls")) = -1 then
			if f_get_itemproperty(g_s_company, ls_plant, ls_dvsn, ls_pitno, ldw_05) = -1 then
				uo_status.st_message.text = "���ǵ��� ���� ǰ���Դϴ�."
				return 0
			end if
		end if
		ls_pitno = ls_pitno + '%'
	else
		ls_pitno = '%'
	end if
	if f_spacechk(ls_pdcd) = -1 then
		ls_pdcd = '%'
	else
		ls_pdcd = ls_pdcd + '%'
	end if
	
	//��ȸ�μ� ��������
	ls_fromdt = ldw_05.getitemstring(1,"wip001_wainptdt")
	ls_todt = ldw_05.getitemstring(1,"wip001_waupdtdt")
	if f_dateedit(ls_fromdt) = space(8) or f_dateedit(ls_todt) = space(8) then
		uo_status.st_message.text = "��ȸ��¥�� �ùٸ��� �ʽ��ϴ�."
		return 0
	end if
	
	l_n_rowcount = ldw_03.retrieve(g_s_company,ls_plant,ls_dvsn, ls_pitno, ls_pdcd, ls_fromdt,ls_todt)
end if

if l_n_rowcount > 0 then
	uo_status.st_message.text = f_message("I010")
else
	uo_status.st_message.text = f_message("I020")
	return 0
end if
i_s_gubun = 'I'
end event

event ue_insert;call super::ue_insert;datawindow ldw_01,ldw_02, ldw_03, ldw_04, ldw_05
string ls_plant , ls_dvsn, ls_pitno, ls_slno, ls_adjdate, ls_srce,ls_mysql
int i,l_n_rowcount
dec{3} lc_qty
dec{4} lc_convqty

ldw_01 = tab_1.tabpage_1.dw_1
ldw_02 = tab_1.tabpage_2.dw_2
ldw_03 = tab_1.tabpage_3.dw_3
ldw_04 = tab_1.tabpage_1.dw_4
ldw_05 = tab_1.tabpage_3.dw_5

uo_status.st_message.text = ' '
tab_1.tabpage_1.dw_1.reset()
tab_1.tabpage_2.dw_2.reset()
tab_1.tabpage_3.dw_3.reset()
SetPointer(HourGlass!)

if i_n_index = 1 then
	//�ʼ��Է� ����, Null üũ
	ldw_04.accepttext()
	if f_wip_mandantory_chk(ldw_04) = -1 then return 0
	//�Էµ� ����Ÿ üũ
	if wf_inputdata_01('A',ldw_04) = 'N' then
		uo_status.st_message.text = f_message("E010")
		return
	end if
	//�⺻����
	ls_plant = ldw_04.getitemstring(1,"wip001_waplant")
	ls_dvsn = ldw_04.getitemstring(1,"wip001_wadvsn")
	ls_pitno = ldw_04.getitemstring(1,"wip001_waitno")
	ls_slno = ldw_04.getitemstring(1,"slno")
	ls_adjdate = ldw_04.getitemstring(1,"wip001_wainptdt")
	lc_qty = ldw_04.getitemdecimal(1,"wip001_quanty")
	i_s_plant = ls_plant
	i_s_dvsn = ls_dvsn
	select convqty into :lc_convqty from pbinv.inv101
	where comltd = :g_s_company and xplant = :ls_plant and
	      div = :ls_dvsn and itno = :ls_pitno using sqlca;
	lc_qty = lc_qty * lc_convqty
	i_n_qty = lc_qty
	//�ش絥��Ÿ ��������
	l_n_rowcount = ids_Data.retrieve(g_s_company,ls_plant,ls_dvsn,ls_pitno ,ls_slno)
	
	if l_n_rowcount <> 0 then
		uo_status.st_message.text = f_message("A060")
		return 0
	end if
	//BOM QTEMP����
	//f_creation_bom_after(ls_adjdate,ls_plant,ls_dvsn,ls_pitno,'G','Y')
	 DECLARE up_wip_16 PROCEDURE FOR PBWIP.SP_WIP_16  
         A_COMLTD = :g_s_company,   
         A_PLANT = :ls_plant,   
         A_DVSN = :ls_dvsn,   
         A_ITNO = :ls_pitno,   
         A_DATE = :ls_adjdate,   
         A_CHK = 'G',
			A_DELCHK = 'Y'	using sqlca;
   execute up_wip_16;
	
	l_n_rowcount = ldw_01.retrieve()
	
	//DELETE TEMP TABLE
	ls_mysql = "DROP TABLE QTEMP.BOMTEMP02"
	Execute Immediate :ls_mysql using sqlca;
	
	ldw_01.object.issue_qty.background.color = rgb(255,250,239)
	
	if l_n_rowcount > 0 then
		uo_status.st_message.text = f_message("A070")
	else
		uo_status.st_message.text = f_message("E330")
		return 0
	end if
	
	ldw_01.setfocus()
	for i=1 to l_n_rowcount 
		ldw_01.object.issue_qty[i] = ldw_01.object.tcqty[i] * lc_qty
		ls_srce = ldw_01.getitemstring(i,"srce")
		if ls_srce <> '03' and f_spacechk(ls_srce) <> -1 then
			ldw_01.object.ip_chk[i] = 'Y'
		end if
	next
elseif i_n_index = 2 then
//	ldw_02.reset()
//	ldw_02.insertrow(0)
else
	return 0
end if
i_s_gubun = 'A'



end event

event ue_save;call super::ue_save;datawindow ldw_01,ldw_02,ldw_04
integer li_cnt, li_rowcnt, l_n_check
string  l_s_column,l_s_slty,l_s_srno,l_s_itno,l_s_spec,l_s_rvno,l_s_cls,& 
        l_s_itnm,l_s_xunit,l_s_srce,l_s_pdcd,l_s_olddate,l_s_plant,l_s_dvsn, l_s_time
string  ls_serial, ls_message
dec{0}  l_d_amt
dec{4}  l_d_qty,l_s_oldqty
dec{5}  l_d_avrg, lc_convqty

if i_s_gubun = 'I' or f_spacechk(i_s_gubun) = -1 then
	uo_status.st_message.text = f_message("U060")
	return 0
end if

ldw_04 = tab_1.tabpage_1.dw_4
ldw_02 = tab_1.tabpage_2.dw_2
ldw_01 = tab_1.tabpage_1.dw_1
l_s_time = g_s_datetime

sqlca.Autocommit = false
Choose case i_n_index
	case 1
		ldw_01.accepttext()
		
		if mid(i_s_date,1,6) <> mid(g_s_date,1,6) then
			ls_message = "�������ڴ� ������̾�� �մϴ�."
			goto Rollback_
		end if
		
		li_rowcnt = ldw_01.rowcount()
		//���ÿ��ο� ������ �ִ��� ����
		for li_cnt = 1 to li_rowcnt
			if trim(string(ldw_01.object.ip_chk[li_cnt])) <> 'Y' then
				continue
			end if
			if ldw_01.object.issue_qty[li_cnt] <= 0 then
				ldw_01.object.cp_chk[li_cnt] = '1' 
			else
				ldw_01.object.cp_chk[li_cnt] = ' '
			end if
		next
		
		wf_rgbset("issue_qty",1,1,ldw_01)
		//������ �Ǿ����鼭 ������ 0�� ���� ������ ǥ��
		for li_cnt = 1 to li_rowcnt 
			if ldw_01.object.cp_chk[li_cnt] = '1' then
				l_s_column = 'issue_qty'
				exit
			end if
		next
		
		if len(l_s_column) > 0 then
			ls_message = "������ 0�ΰ��� �����մϴ�."
			goto Rollback_ 
		end if
		
		for li_cnt = 1 to li_rowcnt 
		
			if trim(string(ldw_01.object.ip_chk[li_cnt])) <> 'Y' then
				continue
			end if
			lc_convqty = ldw_01.object.convqty[li_cnt]
			l_d_amt     = ldw_01.object.issue_qty[li_cnt] * ldw_01.object.costav[li_cnt]
			l_d_qty     = ldw_01.object.issue_qty[li_cnt] * lc_convqty
			l_s_itno    = ldw_01.object.tcitn[li_cnt]
			l_s_cls     = ldw_01.object.cls[li_cnt]
			l_s_rvno    = ldw_01.object.rvno[li_cnt]
			l_s_spec    = ldw_01.object.spec[li_cnt]
			l_s_itnm    = ldw_01.object.itnm[li_cnt]
			l_s_srce    = ldw_01.object.srce[li_cnt]
			l_s_xunit   = ldw_01.object.xunit[li_cnt]
			l_s_pdcd    = ldw_01.object.pdcd[li_cnt]
			//��� �ø����ȣ ��������
			l_s_srno    = ldw_01.object.chk_srno[li_cnt]
		
			if len(l_s_srno) = 1 then
				ls_message = "����ø����ȣ���� ����" 
				goto Rollback_
			end if
			
			//����뷱���� ǰ����������
			select count(*) into:l_n_check from "PBWIP"."WIP001"
			where  "PBWIP"."WIP001"."WACMCD"   = :g_s_company AND "PBWIP"."WIP001"."WAPLANT" = :i_s_plant AND
					 "PBWIP"."WIP001"."WADVSN"   = :i_s_dvsn    AND "PBWIP"."WIP001"."WAORCT"  = '9999'     AND
					 "PBWIP"."WIP001"."WAITNO"   = :l_s_itno
			using sqlca;
			//ǰ���� ������ ���� ������Ʈ
			if l_n_check > 0 then
				update "PBWIP"."WIP001"
					set WAUSQT6  = WAUSQT6 + :l_d_qty, WAUSAT6  = WAUSAT6 + :l_d_amt, WAOHQT = WAOHQT - :l_d_qty,
						 WAOHAT1  = WAOHAT1 - :l_d_amt, WAUPDTDT = :g_s_date	  
				where  "PBWIP"."WIP001"."WACMCD"   = :g_s_company AND "PBWIP"."WIP001"."WAPLANT" = :i_s_plant AND
						 "PBWIP"."WIP001"."WADVSN"   = :i_s_dvsn    AND "PBWIP"."WIP001"."WAORCT"  = '9999'     AND
						 "PBWIP"."WIP001"."WAITNO"   = :l_s_itno
				using sqlca;
				
				if sqlca.sqlnrows < 1 then
					ls_message = "WIP001 ������Ʈ ����"
					goto Rollback_
				end if
			else
				//ǰ���� ������ ������ ������ ǰ������
				select COSTAV into:l_d_avrg from "PBINV"."INV101"
					where COMLTD = :g_s_company and XPLANT = :i_s_plant and DIV = :i_s_dvsn and ITNO = :l_s_itno
				using sqlca;
				
				insert into "PBWIP"."WIP001"
					values (:g_s_company,:i_s_plant,:i_s_dvsn,'9999',:l_s_itno,'1',:l_d_avrg,0,0,0,0,
								0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,:l_d_qty,:l_d_amt,0,0,0,0,0,:l_d_qty * (-1),:l_d_amt * (-1) ,0,
								0,0,' ',:g_s_ipaddr,:g_s_macaddr,:g_s_date,:g_s_date)
				using sqlca;
				
				if sqlca.sqlcode <> 0 then
					ls_message = "WIP001 ǰ�� ���� ����"
					goto Rollback_
				end if
			end if
			
			//���Ʈ������ ����̷� ����
			insert into "PBWIP"."WIP004"
				values (:g_s_company,'IE',:l_s_srno,:i_s_plant,:i_s_dvsn,'1',:l_s_itno,
						  :l_s_rvno,:l_s_itnm,:l_s_spec,:l_s_xunit,:l_s_cls,:l_s_srce,'06',
						  :l_s_pdcd,:i_s_slno,'IE',' ',' ',' ',:i_s_pitno,:i_s_dept,'9999',:i_s_date,:i_n_qty,
						  :l_d_qty,:g_s_ipaddr,:g_s_macaddr,:g_s_empno,:g_s_empno,:g_s_date,
						  :l_s_time,:g_s_date )
			using sqlca;
			//����Ÿ���� ����üũ
			if sqlca.sqlcode <> 0 then
				ls_message = "WIP004 ���⳻�� ���� ����"
				goto Rollback_
			end if
		next
		
		ldw_01.reset()
	case 2
		ldw_02.accepttext()
		//�ʼ��Է� ����,NULL üũ
		if f_wip_mandantory_chk(ldw_02) = -1 then 
			ls_message = "�ʼ��Է»����� Ȯ���Ͻʽÿ�."
			goto Rollback_
		end if
			
		li_rowcnt = ldw_02.rowcount()
		for li_cnt = 1 to li_rowcnt
			//ǰ�� üũ
			l_s_plant = ldw_02.getitemstring(li_cnt,"wdplant")
			l_s_dvsn = ldw_02.getitemstring(li_cnt,"wddvsn")
			l_s_itno = ldw_02.getitemstring(li_cnt,"wditno")
			
			select costav,convqty into:l_d_avrg,:lc_convqty from "PBINV"."INV101"
				where COMLTD = :g_s_company and XPLANT = :l_s_plant and DIV = :l_s_dvsn and ITNO = :l_s_itno
			using sqlca;
			
			i_s_plant = l_s_plant
			i_s_dvsn = l_s_dvsn
			
			l_d_qty = ldw_02.getitemdecimal(li_cnt,"chqt")
			if l_d_qty = 0 then
				ls_message = "��������� �Էµ��� �ʾҽ��ϴ�."
				goto Rollback_
			end if
			ldw_02.setitem(li_cnt,"wdchqt", l_d_qty * lc_convqty)
				
			l_s_plant = trim(ldw_02.object.wdplant[1])
			l_s_dvsn  = trim(ldw_02.object.wddvsn[1])
			l_s_itno  = trim(ldw_02.object.wditno[1])
			l_d_qty   = ldw_02.object.wdchqt[1]
			
			//����뷱���� ǰ�� ����Ȯ��
			select count(*) into:l_n_check from "PBWIP"."WIP001"
			where  "PBWIP"."WIP001"."WACMCD"   = :g_s_company AND "PBWIP"."WIP001"."WAPLANT" = :l_s_plant AND
					 "PBWIP"."WIP001"."WADVSN"   = :l_s_dvsn    AND "PBWIP"."WIP001"."WAORCT"  = '9999'     AND
					 "PBWIP"."WIP001"."WAITNO"   = :l_s_itno
			using sqlca;
			if l_n_check > 0 then
				//ǰ���� ������ ���� ������Ʈ
				update "PBWIP"."WIP001"
					set WAUSQT6  = WAUSQT6 + :l_d_qty,  WAUSAT6  = WAUSAT6 + :l_d_qty * WAAVRG1, WAOHQT = WAOHQT - :l_d_qty,
						 WAOHAT1  = WAOHAT1 - :l_d_qty * WAAVRG1,   WAUPDTDT = :g_s_date	  
				where  "PBWIP"."WIP001"."WACMCD"   = :g_s_company AND "PBWIP"."WIP001"."WAPLANT" = :l_s_plant AND
						 "PBWIP"."WIP001"."WADVSN"   = :l_s_dvsn    AND "PBWIP"."WIP001"."WAORCT"  = '9999'     AND
						 "PBWIP"."WIP001"."WAITNO"   = :l_s_itno
				using sqlca;
				
				if sqlca.sqlnrows < 1 then
					ls_message = "WIP001 ������Ʈ ����" + sqlca.sqlerrtext
					goto Rollback_
				end if
			else
				insert into "PBWIP"."WIP001"
					values (:g_s_company,:l_s_plant,:l_s_dvsn,'9999',:l_s_itno,'1',:l_d_avrg,0,0,0,0,
								0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,:l_d_qty,:l_d_qty * :l_d_avrg,0,0,0,0,0,:l_d_qty * (-1),:l_d_qty * :l_d_avrg * (-1) ,0,
								0,0,' ',:g_s_ipaddr,:g_s_macaddr,:g_s_date,:g_s_date)
				using sqlca;
				
				if sqlca.sqlcode <> 0 then
					ls_message = "WIP001 ǰ������ ����"
					goto Rollback_
				end if
			end if
		next
		if tab_1.tabpage_2.dw_2.update() <> 1 then
			ls_message = "WIP004 ��볻�� ������Ʈ ����"
			goto Rollback_
		end if
End Choose

Commit using sqlca;
sqlca.Autocommit = True
uo_status.st_message.text = '���������� ó���Ǿ����ϴ�.'
i_s_gubun = ' '
return 0

RollBack_:
Rollback using sqlca;
sqlca.Autocommit = True
uo_status.st_message.text = '�����߿� ������ �߻��Ͽ����ϴ�.' + ls_message

return -1

end event

event ue_delete;call super::ue_delete;datawindow ldw_03
int     i,l_n_yesno
string  l_s_wdslty,l_s_wdsrno,ls_plant, ls_dvsn, ls_pitno
dec{4}  l_n_wdchqt

ldw_03 = tab_1.tabpage_3.dw_3
i = ldw_03.getselectedrow(0)

if i <> 0 then
	l_n_yesno = messagebox("����Ȯ��", "���õ� �����ȣ(��)�� �����Ͻðڽ��ϱ� ?",Question!,OkCancel!,2)
	if l_n_yesno <> 1 then
		uo_status.st_message.text = f_message("D030")
		return 0
	end if
else
	uo_status.st_message.text = f_message("D100")
	return 0
end if

l_s_wdslty = ldw_03.object.wdslty[i]
l_s_wdsrno = ldw_03.object.wdsrno[i]
l_n_wdchqt = ldw_03.object.wdchqt[i]
ls_plant = ldw_03.getitemstring(i,"wdplant")
ls_dvsn = ldw_03.getitemstring(i,"wddvsn")
ls_pitno = ldw_03.getitemstring(i,"wditno")
if mid(ldw_03.object.wddate[i],1,6) <> mid(g_s_date,1,6) then
	uo_status.st_message.text = "�������ڰ� ���� ���� �ƴϹǷ� " + f_message("D040")
	return 0
end if

delete from "PBWIP"."WIP004"
	where wdslty = :l_s_wdslty and wdsrno = :l_s_wdsrno and wdcmcd = :g_s_company
using sqlca;

if sqlca.sqlcode <> 0 then
	uo_status.st_message.text = f_message("D020")
	return 
end if

update "PBWIP"."WIP001"
	set wausqt6 = wausqt6 - :l_n_wdchqt,waohqt = waohqt + :l_n_wdchqt,
		 wausat6 = wausat6 - waavrg1 * :l_n_wdchqt,waohat1 = waohat1 + waavrg1 * :l_n_wdchqt
	where wacmcd = :g_s_company and waplant = :ls_plant and wadvsn = :ls_dvsn and
			waorct = '9999' and waitno = :ls_pitno
using sqlca;

if sqlca.sqlcode <> 0 then
	uo_status.st_message.text = f_message("D020")
	return 
end if
	
this.triggerevent("ue_retrieve")
uo_status.st_message.text = f_message("D010")
i_s_gubun = ' '


end event

type uo_status from w_origin_sheet01`uo_status within w_wip023u
end type

type tab_1 from tab within w_wip023u
integer x = 9
integer y = 20
integer width = 4608
integer height = 2456
integer taborder = 10
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
boolean italic = true
long backcolor = 12632256
boolean raggedright = true
boolean focusonbuttondown = true
boolean boldselectedtext = true
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.tabpage_3=create tabpage_3
this.Control[]={this.tabpage_1,&
this.tabpage_2,&
this.tabpage_3}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
destroy(this.tabpage_3)
end on

event selectionchanged;i_n_index = newindex
if i_n_index = 1 then
	// ��ȸ, �Է�, ����, ����, ����ȸ, ȭ���μ�, Ư������
	wf_icon_onoff( false, true, true, false, false, false, false)
elseif i_n_index = 2 then
	i_s_gubun = 'A'
	tab_1.tabpage_2.dw_2.reset()
//	tab_1.tabpage_2.dw_2.insertrow(0)
//	wf_protect('N')
//	tab_1.tabpage_2.dw_2.setcolumn('wdplant')
//	tab_1.tabpage_2.dw_2.setfocus()
	// ��ȸ, �Է�, ����, ����, ����ȸ, ȭ���μ�, Ư������
	wf_icon_onoff( false, true, true, true, false, false, false)
elseif i_n_index = 3 then
	// ��ȸ, �Է�, ����, ����, ����ȸ, ȭ���μ�, Ư������
	wf_icon_onoff( true, false, false, true, false, false, false)
end if



end event

type tabpage_1 from userobject within tab_1
integer x = 18
integer y = 112
integer width = 4571
integer height = 2328
long backcolor = 12632256
string text = "BULK �Է�"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
gb_1 gb_1
dw_1 dw_1
dw_4 dw_4
end type

on tabpage_1.create
this.gb_1=create gb_1
this.dw_1=create dw_1
this.dw_4=create dw_4
this.Control[]={this.gb_1,&
this.dw_1,&
this.dw_4}
end on

on tabpage_1.destroy
destroy(this.gb_1)
destroy(this.dw_1)
destroy(this.dw_4)
end on

type gb_1 from groupbox within tabpage_1
integer x = 5
integer width = 4539
integer height = 452
integer taborder = 70
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

type dw_1 from datawindow within tabpage_1
integer x = 14
integer y = 496
integer width = 4535
integer height = 1692
integer taborder = 80
string title = "none"
string dataobject = "d_wip023u_list"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event retrieveend;integer li_cnt

for li_cnt = 1 to rowcount
	This.setitem(li_cnt,"chk_srno",f_wip_get_serialno(g_s_company))
next
end event

type dw_4 from datawindow within tabpage_1
event ue_enterkey pbm_keydown
integer x = 41
integer y = 48
integer width = 4425
integer height = 388
integer taborder = 50
boolean bringtotop = true
string title = "none"
string dataobject = "d_wip023u_01"
boolean border = false
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_enterkey;if key = keyenter! then
	window l_s_wsheet
	l_s_wsheet = w_frame.GetActiveSheet()
	l_s_wsheet.TriggerEvent("ue_retrieve")
end if

return 0
end event

event itemchanged;string ls_colname, ls_plant, ls_dvsn, ls_null
datawindowchild cdw_1

uo_status.st_message.text = ""
This.AcceptText()
ls_colname = This.GetColumnName()
IF ls_colname = 'wip001_waplant' Then
   This.SetItem(1,'wip001_wadvsn', ' ')
   ls_plant = This.GetItemString(1,'wip001_waplant')
   This.GetChild("wip001_wadvsn",cdw_1)
   cdw_1.SetTransObject(Sqlca)
   cdw_1.Retrieve(ls_plant)
END IF

if ls_colname = "dept" then
	string ls_rtnvalue
	if f_spacechk(data) <> -1 then
		ls_rtnvalue = f_get_deptnm(data,'5')
		if f_spacechk(ls_rtnvalue) = -1 then
			uo_status.st_message.text = "�μ��ڵ尡 Ʋ���ϴ�."
		else
			This.setitem(1,"deptnm",ls_rtnvalue)
		end if
	end if
end if

if ls_colname = 'wip001_waitno' then
	This.AcceptText()
	ls_plant = this.getitemstring(1,"wip001_waplant")
	ls_dvsn = this.getitemstring(1,"wip001_wadvsn")
   if f_get_itemproperty(g_s_company, ls_plant, ls_dvsn, data, this) = -1 then
		uo_status.st_message.text = "���ǵ��� ���� ǰ���Դϴ�."
		return 0
	end if
end if
end event

event buttonclicked;string ls_parm

if dwo.name = 'b_search' then
	openwithparm(w_find_001 , ' I')
	ls_parm = message.stringparm
	if f_spacechk(ls_parm) <> -1 then
		This.setitem(1,"deptnm",trim(mid(ls_parm,16)))
		This.setitem(1,"dept",trim(mid(ls_parm,1,5)))
	end if
end if

if dwo.name = 'b_itemfind' then
	string ls_plant, ls_dvsn
	ls_plant = This.getitemstring(1,"wip001_waplant")
	ls_dvsn = This.getitemstring(1,"wip001_wadvsn")
	if f_spacechk(ls_plant) = -1 or f_spacechk(ls_dvsn) = -1 then
		uo_status.st_message.text = "�����̳� ������ ���� �����Ͻʽÿ�"
		return 0
	end if
	openwithparm(w_find_002 , ls_plant + ls_dvsn)
	ls_parm = message.stringparm
	if f_spacechk(ls_parm) <> -1 then
   	This.setitem(1,"wip001_waitno", mid(ls_parm,1,15))
		This.setitem(1,"inv002_itnm",mid(ls_parm,16,30))
	end if
end if
end event

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 112
integer width = 4571
integer height = 2328
long backcolor = 12632256
string text = "ITEM �Է�"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
dw_2 dw_2
cb_insert cb_insert
cb_delete cb_delete
gb_3 gb_3
dw_6 dw_6
end type

on tabpage_2.create
this.dw_2=create dw_2
this.cb_insert=create cb_insert
this.cb_delete=create cb_delete
this.gb_3=create gb_3
this.dw_6=create dw_6
this.Control[]={this.dw_2,&
this.cb_insert,&
this.cb_delete,&
this.gb_3,&
this.dw_6}
end on

on tabpage_2.destroy
destroy(this.dw_2)
destroy(this.cb_insert)
destroy(this.cb_delete)
destroy(this.gb_3)
destroy(this.dw_6)
end on

type dw_2 from datawindow within tabpage_2
integer x = 14
integer y = 348
integer width = 4535
integer height = 1968
integer taborder = 10
string title = "none"
string dataobject = "d_wip023u_insert"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event buttonclicked;string ls_parm

uo_status.st_message.text = ""
if dwo.name = 'b_search' then
	openwithparm(w_find_001 , ' I')
	ls_parm = message.stringparm
	if f_spacechk(ls_parm) <> -1 then
		This.setitem(row,"deptnm",trim(mid(ls_parm,16)))
		This.setitem(row,"wdprdpt",trim(mid(ls_parm,1,5)))
	end if
end if

if dwo.name = 'b_itemfind' then
	string ls_plant, ls_dvsn
	ls_plant = This.getitemstring(row,"wdplant")
	ls_dvsn = This.getitemstring(row,"wddvsn")
	if f_spacechk(ls_plant) = -1 or f_spacechk(ls_dvsn) = -1 then
		uo_status.st_message.text = "�����̳� ������ ���� �����Ͻʽÿ�"
		return 0
	end if
	openwithparm(w_find_002 , ls_plant + ls_dvsn)
	ls_parm = message.stringparm
	if f_spacechk(ls_parm) <> -1 then
   	This.setitem(row,"wditno", mid(ls_parm,1,15))
		This.setitem(row,"wddesc",mid(ls_parm,16,30))
	end if
end if
end event

event itemchanged;string ls_colname, ls_plant, ls_dvsn, ls_cls,ls_srce,ls_pdcd, ls_rvno
string ls_unit, ls_desc, ls_spec
integer l_n_slchk
datawindowchild cdw_1

uo_status.st_message.text = ""
This.AcceptText()
ls_colname = This.GetColumnName()

if ls_colname = "wdprdpt" then
	string ls_rtnvalue
	if f_spacechk(data) <> -1 then
		ls_rtnvalue = f_get_deptnm(data,'5')
		if f_spacechk(ls_rtnvalue) = -1 then
			This.setitem(row,"wdprdpt",'')
			This.setitem(row,"deptnm",'')
			uo_status.st_message.text = "�μ��ڵ尡 Ʋ���ϴ�."
			return 1
		else
			This.setitem(row,"deptnm",ls_rtnvalue)
		end if
	end if
end if

if ls_colname = 'wditno' then
	This.AcceptText()
	ls_plant = this.getitemstring(row,"wdplant")
	ls_dvsn = this.getitemstring(row,"wddvsn")
	
	select rvno, itnm, spec into :ls_rvno, :ls_desc, :ls_spec
	from pbinv.inv002
	where comltd = :g_s_company and itno = :data using sqlca;
	
	select cls,srce,xunit,pdcd into :ls_cls,:ls_srce,:ls_unit,:ls_pdcd
	from pbinv.inv101
	where comltd = :g_s_company and xplant = :ls_plant and
	      div = :ls_dvsn and itno = :data using sqlca;
	
	if sqlca.sqlcode <> 0 or ls_cls = '30' or ls_srce = '03' then
		This.setitem(row,"wditno",'')
		uo_status.st_message.text = "���� ��� ǰ���� �ƴմϴ�."
		return 1
	end if
	
	This.setitem(row,"wdprno",data)
   This.setitem(row,"wditcl",ls_cls)
	This.setitem(row,"wdsrce",ls_srce)
	This.setitem(row,"wdpdcd",mid(ls_pdcd,1,2))
	This.setitem(row,"wdunit",ls_unit)
	This.setitem(row,"wddesc",ls_desc)
	This.setitem(row,"wdspec",ls_spec)
	This.setitem(row,"wdrvno",ls_rvno)	
	
end if

if ls_colname = 'wdslno' then
	// ������ ��ȣ üũ
	if f_spacechk(mid(data,1,4)) <> -1 and f_spacechk(f_get_deptnm(mid(data,1,4),'5')) <> -1 then
		l_n_slchk = 1
	end if
	if mid(data,5,1) >= '0' and mid(data,5,1) <= '9' then
		l_n_slchk += 1
	end if
	if (mid(data,6,1) >= '1' and mid(data,6,1) <= '9') or &
		 mid(data,6,1) = 'X' or mid(data,6,1) = 'Y' or mid(data,6,1) = 'Z' then
		l_n_slchk += 1
	end if
	if isnumber(mid(data,7,4)) = true then
		l_n_slchk += 1
	end if
	if l_n_slchk <> 4 then
		This.setitem(row,"wdslno",'')
		uo_status.st_message.text = "������ü�谡 ���� �Ƚ��ϴ�. �μ��ڵ� + ��(01) + �Ϸù�ȣ"
		return 1
	end if
end if

if ls_colname = 'chqt' then
	if isNull(dec(data)) = true or dec(data) = 0 then
		uo_status.st_message.text = "��������� �Է��Ͻʽÿ�"
		return 1
	end if
end if

if ls_colname = 'wddate' then
	if (f_dateedit(data) = space(8)) or (mid(data,1,6) <> mid(g_s_date,1,6)) then
		This.setitem(row,"wddate",'')
		uo_status.st_message.text = "���⳯¥�� �ٽ� Ȯ���� �ֽʽÿ�"
		return 1
	end if
end if
end event

event clicked;if row <= 0 then
	return
end if

this.SelectRow(0, FALSE)
this.SelectRow(row, TRUE)

end event

type cb_insert from commandbutton within tabpage_2
integer x = 32
integer y = 232
integer width = 375
integer height = 92
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
string text = "�Է�"
end type

event clicked;string ls_plant, ls_dvsn, ls_srno, ls_slno, ls_dept, ls_deptnm
long ll_currow

uo_status.st_message.text = ""

tab_1.tabpage_2.dw_6.accepttext()
ls_plant = tab_1.tabpage_2.dw_6.getitemstring(1,"wip001_waplant")
ls_dvsn = tab_1.tabpage_2.dw_6.getitemstring(1,"wip001_wadvsn")
ls_dept = tab_1.tabpage_2.dw_6.getitemstring(1,"dept")
ls_deptnm = tab_1.tabpage_2.dw_6.getitemstring(1,"deptnm")
ls_slno = tab_1.tabpage_2.dw_6.getitemstring(1,"slno")

if f_spacechk(ls_plant) = -1 or f_spacechk(ls_dvsn) = -1 then
	uo_status.st_message.text = "���� �Ǵ� ������ ���õ��� �ʾҽ��ϴ�."
	return 0
end if

if f_spacechk(ls_slno) = -1 or f_spacechk(ls_dept) = -1 then
	uo_status.st_message.text = "��������ȣ �Ǵ� ����μ��� ���õ��� �ʾҽ��ϴ�."
	return 0
end if

ls_srno = f_wip_get_serialno(g_s_company)
if ls_srno = '0' then
	uo_status.st_message.text = "�Ϸù�ȣ���������Դϴ�."
	return 0
end if
ll_currow = tab_1.tabpage_2.dw_2.insertrow(0)
tab_1.tabpage_2.dw_2.setitem(ll_currow,"wdslty",'IE')
tab_1.tabpage_2.dw_2.setitem(ll_currow,"wdsrno",ls_srno)
tab_1.tabpage_2.dw_2.setitem(ll_currow,"wdcmcd",g_s_company)
tab_1.tabpage_2.dw_2.setitem(ll_currow,"wdplant",ls_plant)
tab_1.tabpage_2.dw_2.setitem(ll_currow,"wddvsn",ls_dvsn)
tab_1.tabpage_2.dw_2.setitem(ll_currow,"wdslno",ls_slno)
tab_1.tabpage_2.dw_2.setitem(ll_currow,"wdprdpt",ls_dept)
tab_1.tabpage_2.dw_2.setitem(ll_currow,"deptnm",ls_deptnm)
tab_1.tabpage_2.dw_2.setitem(ll_currow,"wdiocd",'1')
tab_1.tabpage_2.dw_2.setitem(ll_currow,"wdusge",'06')
tab_1.tabpage_2.dw_2.setitem(ll_currow,"wdprsrty",'IE')
tab_1.tabpage_2.dw_2.setitem(ll_currow,"wdprsrno",' ')
tab_1.tabpage_2.dw_2.setitem(ll_currow,"wdprsrno1",' ')
tab_1.tabpage_2.dw_2.setitem(ll_currow,"wdprsrno2",' ')
tab_1.tabpage_2.dw_2.setitem(ll_currow,"wdprno",'')
tab_1.tabpage_2.dw_2.setitem(ll_currow,"wdchdpt",'9999')
tab_1.tabpage_2.dw_2.setitem(ll_currow,"wdprqt",0)
tab_1.tabpage_2.dw_2.setitem(ll_currow,"wddate",g_s_date)
tab_1.tabpage_2.dw_2.setitem(ll_currow,"wdipaddr",g_s_ipaddr)
tab_1.tabpage_2.dw_2.setitem(ll_currow,"wdmacaddr",g_s_macaddr)
tab_1.tabpage_2.dw_2.setitem(ll_currow,"wdinptid",g_s_empno)
tab_1.tabpage_2.dw_2.setitem(ll_currow,"wdupdtid",g_s_empno)
tab_1.tabpage_2.dw_2.setitem(ll_currow,"wdinpttm",'')
tab_1.tabpage_2.dw_2.setitem(ll_currow,"wdinptdt",g_s_date)
tab_1.tabpage_2.dw_2.setitem(ll_currow,"wdupdtdt",g_s_date)

tab_1.tabpage_2.dw_2.setcolumn("wditno")
tab_1.tabpage_2.dw_2.setfocus()
end event

type cb_delete from commandbutton within tabpage_2
integer x = 480
integer y = 236
integer width = 375
integer height = 92
integer taborder = 70
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
string text = "����"
end type

event clicked;long ll_selrow

ll_selrow = tab_1.tabpage_2.dw_2.getselectedrow(0)
if ll_selrow < 1 then
	uo_status.st_message.text = "������ ���� ������ �ֽʽÿ�."
	return -1
end if


tab_1.tabpage_2.dw_2.deleterow(ll_selrow)

end event

type gb_3 from groupbox within tabpage_2
integer x = 14
integer width = 4530
integer height = 196
integer taborder = 80
integer textsize = -6
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 33554432
long backcolor = 12632256
end type

type dw_6 from datawindow within tabpage_2
integer x = 41
integer y = 36
integer width = 4352
integer height = 152
integer taborder = 70
boolean bringtotop = true
string title = "none"
string dataobject = "d_wip023u_03"
boolean border = false
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;string ls_colname, ls_plant, ls_dvsn, ls_null
integer l_n_slchk
datawindowchild cdw_1

uo_status.st_message.text = ""
This.AcceptText()
ls_colname = This.GetColumnName()
IF ls_colname = 'wip001_waplant' Then
   This.SetItem(1,'wip001_wadvsn', ' ')
   ls_plant = This.GetItemString(1,'wip001_waplant')
   This.GetChild("wip001_wadvsn",cdw_1)
   cdw_1.SetTransObject(Sqlca)
   cdw_1.Retrieve(ls_plant)
END IF

if ls_colname = "dept" then
	string ls_rtnvalue
	if f_spacechk(data) <> -1 then
		ls_rtnvalue = f_get_deptnm(data,'5')
		if f_spacechk(ls_rtnvalue) = -1 then
			This.setitem(row,"dept",'')
			This.setitem(row,"deptnm",'')
			uo_status.st_message.text = "�μ��ڵ尡 Ʋ���ϴ�."
			return 1
		else
			This.setitem(row,"deptnm",ls_rtnvalue)
		end if
	end if
end if

if ls_colname = 'slno' then
	// ������ ��ȣ üũ
	if f_spacechk(mid(data,1,4)) <> -1 and f_spacechk(f_get_deptnm(mid(data,1,4),'5')) <> -1 then
		l_n_slchk = 1
	end if
	if mid(data,5,1) >= '0' and mid(data,5,1) <= '9' then
		l_n_slchk += 1
	end if
	if (mid(data,6,1) >= '1' and mid(data,6,1) <= '9') or &
		 mid(data,6,1) = 'X' or mid(data,6,1) = 'Y' or mid(data,6,1) = 'Z' then
		l_n_slchk += 1
	end if
	if isnumber(mid(data,7,4)) = true then
		l_n_slchk += 1
	end if
	if l_n_slchk <> 4 then
		This.setitem(row,"slno",'')
		uo_status.st_message.text = "������ü�谡 ���� �Ƚ��ϴ�. �μ��ڵ� + ��(01) + �Ϸù�ȣ"
		return 1
	end if
end if

end event

event buttonclicked;string ls_parm

if dwo.name = 'b_search' then
	openwithparm(w_find_001 , ' I')
	ls_parm = message.stringparm
	if f_spacechk(ls_parm) <> -1 then
		This.setitem(1,"deptnm",trim(mid(ls_parm,16)))
		This.setitem(1,"dept",trim(mid(ls_parm,1,5)))
	end if
end if
end event

type tabpage_3 from userobject within tab_1
integer x = 18
integer y = 112
integer width = 4571
integer height = 2328
long backcolor = 12632256
string text = "��볻�� ��ȸ "
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
gb_2 gb_2
dw_3 dw_3
dw_5 dw_5
pb_down pb_down
end type

on tabpage_3.create
this.gb_2=create gb_2
this.dw_3=create dw_3
this.dw_5=create dw_5
this.pb_down=create pb_down
this.Control[]={this.gb_2,&
this.dw_3,&
this.dw_5,&
this.pb_down}
end on

on tabpage_3.destroy
destroy(this.gb_2)
destroy(this.dw_3)
destroy(this.dw_5)
destroy(this.pb_down)
end on

type gb_2 from groupbox within tabpage_3
integer x = 9
integer y = 8
integer width = 4549
integer height = 324
integer taborder = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 33554432
long backcolor = 12632256
end type

type dw_3 from datawindow within tabpage_3
integer x = 9
integer y = 356
integer width = 4553
integer height = 1960
integer taborder = 50
string title = "none"
string dataobject = "d_wip023u_history"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;if row <= 0 then
	return
end if

If Keydown(KeyShift!) then
	wf_Shift_Highlight(row, this)
ElseIf Keydown(KeyControl!) then
	i_i_LastRow = row
	if this.IsSelected(row) Then
		this.SelectRow(row,FALSE)
	else
		this.SelectRow(row,TRUE)
	end if	
Else
	i_i_LastRow = row
	this.SelectRow(0, FALSE)
	this.SelectRow(row, TRUE)
End If
end event

event doubleclicked;//string ls_slty, ls_srno
//dec{4} lc_convqty, lc_chqt
//if row <= 0 then
//	return
//end if
//
//ls_slty = tab_1.tabpage_3.dw_3.object.wdslty[row]
//ls_srno = tab_1.tabpage_3.dw_3.object.wdsrno[row]
//lc_convqty = tab_1.tabpage_3.dw_3.object.inv101_convqty[row]
//tab_1.selecttab(2)
//tab_1.tabpage_2.dw_2.retrieve(g_s_company,ls_slty,ls_srno)
//lc_chqt = tab_1.tabpage_2.dw_2.getitemdecimal(1,"wdchqt")
//lc_chqt = lc_chqt / lc_convqty
//tab_1.tabpage_2.dw_2.object.chqt[1] = lc_chqt
//// ��ȸ, �Է�, ����, ����, ����ȸ, ȭ���μ�, Ư������
//wf_icon_onoff( false, true, true, true, false, false, false)
//wf_protect('P')
//
end event

type dw_5 from datawindow within tabpage_3
integer x = 41
integer y = 52
integer width = 4000
integer height = 264
integer taborder = 60
boolean bringtotop = true
string title = "none"
string dataobject = "d_wip023u_02"
boolean border = false
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;string ls_colname, ls_plant, ls_dvsn
datawindowchild cdw_1,  cdw_2

uo_status.st_message.text = ""
This.AcceptText()
ls_colname = This.GetColumnName()
IF ls_colname = 'wip001_waplant' Then
   This.SetItem(1,'wip001_wadvsn', ' ')
   ls_plant = This.GetItemString(1,'wip001_waplant')
   This.GetChild("wip001_wadvsn",cdw_1)
   cdw_1.SetTransObject(Sqlca)
   cdw_1.Retrieve(ls_plant)
END IF

IF ls_colname = 'wip001_wadvsn' Then
   This.SetItem(1,'inv101_pdcd', ' ')
   ls_dvsn = This.GetItemString(1,'wip001_wadvsn')
   This.GetChild("inv101_pdcd",cdw_2)
   cdw_2.SetTransObject(Sqlca)
   cdw_2.Retrieve(ls_dvsn)
END IF

if ls_colname = 'wip001_waitno' then
	This.AcceptText()
	ls_plant = this.getitemstring(1,"wip001_waplant")
	ls_dvsn = this.getitemstring(1,"wip001_wadvsn")
   if f_get_itemproperty(g_s_company, ls_plant, ls_dvsn, data, this) = -1 then
		uo_status.st_message.text = "���ǵ��� ���� ǰ���Դϴ�."
		return 0
	end if
end if
end event

event buttonclicked;string ls_parm

if dwo.name = 'b_itemfind' then
	string ls_plant, ls_dvsn
	ls_plant = This.getitemstring(1,"wip001_waplant")
	ls_dvsn = This.getitemstring(1,"wip001_wadvsn")
	if f_spacechk(ls_plant) = -1 or f_spacechk(ls_dvsn) = -1 then
		uo_status.st_message.text = "�����̳� ������ ���� �����Ͻʽÿ�"
		return 0
	end if
	openwithparm(w_find_002 , ls_plant + ls_dvsn)
	ls_parm = message.stringparm
	if f_spacechk(ls_parm) <> -1 then
   	This.setitem(1,"wip001_waitno", mid(ls_parm,1,15))
		This.setitem(1,"inv002_itnm",mid(ls_parm,16,30))
	end if
end if
end event

type pb_down from picturebutton within tabpage_3
integer x = 3195
integer y = 64
integer width = 425
integer height = 104
integer taborder = 70
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
string picturename = "C:\kdac\bmp\Excel.bmp"
alignment htextalign = left!
end type

event clicked;long ll_rowcnt

ll_rowcnt = tab_1.tabpage_3.dw_3.rowcount()
if ll_rowcnt < 1 then
	uo_status.st_message.text = "�ٿ�ε��� ����Ÿ�� �����ϴ�."
	return 0
end if

f_save_to_excel_number(tab_1.tabpage_3.dw_3)
end event

type st_1 from statictext within w_wip023u
integer x = 1509
integer y = 44
integer width = 2459
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 128
long backcolor = 12639424
string text = "��������ȣü�� : �μ��ڵ� + ��(0-9) + ��(1-9,X,Y,Z) + �Ϸù�ȣ(0000)"
alignment alignment = center!
boolean focusrectangle = false
end type

