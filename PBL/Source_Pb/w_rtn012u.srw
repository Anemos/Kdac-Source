$PBExportHeader$w_rtn012u.srw
$PBExportComments$대체Line 등록[결재]
forward
global type w_rtn012u from w_origin_sheet01
end type
type uo_1 from uo_plandiv_bom within w_rtn012u
end type
type dw_1 from u_vi_std_datawindow within w_rtn012u
end type
type gb_2 from groupbox within w_rtn012u
end type
end forward

global type w_rtn012u from w_origin_sheet01
integer height = 2712
string title = "대체Line등록"
uo_1 uo_1
dw_1 dw_1
gb_2 gb_2
end type
global w_rtn012u w_rtn012u

type variables
string i_s_sqlselect,i_s_selected
long   i_i_LastRow , ll_print , GENERIC_WRITE  ,hcommdev
int    in_row
end variables

forward prototypes
public function integer wf_shift_highlight (integer al_aclickedrow, datawindow dw)
public subroutine wf_set_dw1 (string i_s_protect)
public subroutine wf_rgbset (string ag_s_column, integer ag_n_number, integer ag_n_color, datawindow ag_dw_1)
public subroutine wf_protect (string ag_s_column, integer ag_n_number, datawindow ag_dw_1)
public function long wf_hex_to_long (string as_hex)
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

public subroutine wf_set_dw1 (string i_s_protect);
if i_s_protect = 'C' then
    dw_1.object.rblnmn.background.color  = rgb(255,255,239)
	dw_1.object.rblctn.background.color  = rgb(255,255,239)
	dw_1.object.rbvend.background.color  = rgb(255,255,239)
	dw_1.object.rbline1.background.color = rgb(192,192,192)
	dw_1.object.rbline2.background.color = rgb(192,192,192)
	dw_1.object.rbline1.protect = true
	dw_1.object.rbline2.protect = true
	dw_1.object.rblnmn.protect  = false
	dw_1.object.rblctn.protect  = false
	dw_1.object.rbvend.protect  = false
else
    dw_1.object.rblnmn.background.color  = rgb(192,192,192)
	dw_1.object.rblctn.background.color  = rgb(192,192,192)
	dw_1.object.rbvend.background.color  = rgb(192,192,192)
	dw_1.object.rbline1.background.color = rgb(192,192,192)
	dw_1.object.rbline2.background.color = rgb(192,192,192)
	dw_1.object.rbline1.protect = true
	dw_1.object.rbline2.protect = true
	dw_1.object.rblnmn.protect  = true
	dw_1.object.rblctn.protect  = true
	dw_1.object.rbvend.protect  = true
end if
end subroutine

public subroutine wf_rgbset (string ag_s_column, integer ag_n_number, integer ag_n_color, datawindow ag_dw_1);string l_s_command
long 	 l_l_color = 16777215						//	white

//--	Argument	=> ag_s_column = column 명, 
//---             ag_n_number = column 순서,
//--  				ag_n_color  = column 색상( 1 = Cream[255,250,239], 2 = White[255,255,255] )  
// ag_dw_1.setredraw(False)
if ag_n_color 	= 	1	then
	l_s_command	=	ag_s_column + ".Background.Color = '" + String(l_l_color) &            
					+	"~tIf(mid(cp_chk," + string(ag_n_number) + ", 1) =" + "~~'1~~' ," & 
					+ 	" rgb(255,255,0), " + "~tIf(mid(cp_chk," + string(ag_n_number) + ", 1) =" + "~~'2~~' ," &
					+  " rgb(192,192,192),rgb(255,250,239)))'"
else
	l_s_command	=	ag_s_column + ".Background.Color = '" + String(l_l_color) &            
					+	"~tIf(mid(cp_chk," + string(ag_n_number) + ", 1) =" + "~~'1~~' ," & 
					+ 	" rgb(255,255,0), " + "~tIf(mid(cp_chk," + string(ag_n_number) + ", 1) =" + "~~'2~~' ," &
					+  " rgb(192,192,192),rgb(255,255,255)))'"
end if
ag_dw_1.Modify(l_s_command)
// ag_dw_1.setredraw(True)
end subroutine

public subroutine wf_protect (string ag_s_column, integer ag_n_number, datawindow ag_dw_1);string l_s_command
long 	 l_l_color = 16777215						//	white

//--	Argument	=> ag_s_column = column 명, 
//---             ag_n_number = column 순서,
ag_dw_1.setredraw(False)
l_s_command	=	ag_s_column + ".Protect = '1" &            
					+	"~tIf(mid(pt_chk," + string(ag_n_number) + ", 1) = " + "~~'1~~'," &
					+  " 1, 0 )'"
					
ag_dw_1.Modify(l_s_command)

l_s_command = ' '
l_s_command	=	ag_s_column + ".Background.Color = '" + String(l_l_color) &            
					+	"~tIf(mid(pt_chk," + string(ag_n_number) + ", 1) =" + "~~'1~~'," & 
					+ 	" rgb(192,192,192), rgb(255,250,239))'"			

ag_dw_1.Modify(l_s_command)
ag_dw_1.setredraw(True)
end subroutine

public function long wf_hex_to_long (string as_hex);Integer             n
Integer             i
Long                a[]
Long                ll_Return
String              strhex

strHex = Upper(as_hex) 

For n = Len(strhex) To 1 Step -1 
                Choose Case Mid(strHex, Len(strhex) - n + 1, 1) 
                         Case "0" To "9" 
                          a[n] = Long(Mid(strHex, Len(strhex) - n + 1, 1))      
                         Case "A" 
                          a[n] = 10 
                         Case "B" 
                          a[n] = 11 
                         Case "C" 
                          a[n] = 12 
                         Case "D" 
                          a[n] = 13 
                         Case "E" 
                          a[n] = 14 
                         Case "F" 
                          a[n] = 15
                    Case Else
                                MessageBox('Error','hex2Dec Error')
                                Return 0
                   End Choose 
   
   ll_Return = ll_Return + a[n] * 16 ^ (n - 1) 
Next

Return ll_Return
end function

on w_rtn012u.create
int iCurrent
call super::create
this.uo_1=create uo_1
this.dw_1=create dw_1
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_1
this.Control[iCurrent+2]=this.dw_1
this.Control[iCurrent+3]=this.gb_2
end on

on w_rtn012u.destroy
call super::destroy
destroy(this.uo_1)
destroy(this.dw_1)
destroy(this.gb_2)
end on

event open;call super::open;dw_1.settransobject(sqlca)

i_b_dretrieve = false
i_b_dprint = true
i_b_dchar = false
i_b_retrieve = true
i_b_insert = true
i_b_save = true
i_b_delete = true
wf_icon_onoff(i_b_retrieve, i_b_insert, i_b_save, i_b_delete, i_b_dretrieve, &
  	              i_b_dprint,   i_b_dchar)

end event

event ue_retrieve;string l_s_parm,l_s_plant,l_s_dvsn
long i

SetPointer(HourGlass!)
//----------- 공장 선택 ----------
uo_status.st_message.text = ''

dw_1.reset()
l_s_parm     = uo_1.uf_Return()
l_s_plant    = mid(l_s_parm,1,1)
l_s_dvsn   = mid(l_s_parm,2,1)

if dw_1.retrieve(l_s_plant, l_s_dvsn) > 0 then
	dw_1.setfocus()
	dw_1.setcolumn("rblnmn")
	uo_status.st_message.text = f_message("I010")
else
	uo_status.st_message.text = f_message("I020")
end if

return 0
end event

event ue_save;call super::ue_save;string  ls_message

SetPointer(HourGlass!)
//----------- 공장 선택 ----------
uo_status.st_message.text = ''
dw_1.accepttext()

if f_wip_mandantory_chk(dw_1) = -1 then
	return -1
end if

SQLCA.AUTOCOMMIT = FALSE

if dw_1.update() <> 1 then
	ls_message = "저장시 오류가 발생했습니다."
	goto Rollback_
end if

COMMIT USING SQLCA;
SQLCA.AUTOCOMMIT = TRUE

this.triggerevent("ue_retrieve")
uo_status.st_message.text = "정상적으로 처리되었습니다."
return 0

Rollback_:
ROLLBACK USING SQLCA;
SQLCA.AUTOCOMMIT = TRUE
uo_status.st_message.text = ls_message

return -1
end event

event ue_insert;string  l_s_parm,l_s_plant,l_s_dvsn
integer li_currow

uo_status.st_message.text = ''
//----------- 공장 선택 ----------
l_s_parm     = uo_1.uf_Return()
l_s_plant    = mid(l_s_parm,1,1)
l_s_dvsn   = mid(l_s_parm,2,1)

li_currow = dw_1.insertrow(0)

dw_1.scrolltorow(li_currow)

dw_1.setitem(li_currow,"rbcmcd",g_s_company)
dw_1.setitem(li_currow,"rbplant",l_s_plant)
dw_1.setitem(li_currow,"rbdvsn",l_s_dvsn)
dw_1.setitem(li_currow,"rblctn",'A')
dw_1.setitem(li_currow,"rbvend",'I')
dw_1.setitem(li_currow,"rbflag",'A')
dw_1.setitem(li_currow,"rbepno",g_s_empno)
dw_1.setitem(li_currow,"rbipad",g_s_ipaddr)
dw_1.setitem(li_currow,"rbupdt",g_s_date)
dw_1.setitem(li_currow,"rbsydt",g_s_date)
dw_1.setitem(li_currow,"del_chk",0)

dw_1.setrow(li_currow)
dw_1.setcolumn("rbline1")
dw_1.setfocus()

//dw_1.modify("rbline1.Background.Color = 15780518")
//dw_1.modify("rbline2.Background.Color = 15780518")

uo_status.st_message.text = f_message("A070")   
end event

event ue_delete;call super::ue_delete;integer l_n_row,l_n_yesno

SetPointer(HourGlass!)
//----------- 공장 선택 ----------
uo_status.st_message.text = ''

l_n_row = dw_1.getselectedrow(0)

if l_n_row > 0 then
	l_n_yesno = messagebox("삭제확인", "선택된 대체 Line(들)을 삭제하시겠습니까 ?",Question!,OkCancel!,2)
	if l_n_yesno <> 1 then
		uo_status.st_message.text = f_message("D030")
		return 0
	end if
else
	uo_status.st_message.text = f_message("D100")
	return 0
end if

if dw_1.getitemnumber(l_n_row,"del_chk") > 0 then
	messagebox("확인","Routing 상세 정보가 등록된 대체 라인이 있습니다. 상세정보를 먼저 삭제하세요")
	return 0
end if

dw_1.deleterow(l_n_row)
uo_status.st_message.text = "저장아이콘을 클릭해야 삭제가 반영됩니다."
return 0
end event

event timer;call super::timer;this.triggerevent("ue_dprint")
end event

type uo_status from w_origin_sheet01`uo_status within w_rtn012u
end type

type uo_1 from uo_plandiv_bom within w_rtn012u
integer x = 759
integer y = 44
integer taborder = 20
boolean bringtotop = true
end type

on uo_1.destroy
call uo_plandiv_bom::destroy
end on

type dw_1 from u_vi_std_datawindow within w_rtn012u
integer x = 699
integer y = 196
integer width = 3177
integer height = 2276
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_rtn01_dw_daechae_line_input"
boolean hscrollbar = true
boolean vscrollbar = true
end type

type gb_2 from groupbox within w_rtn012u
integer x = 695
integer y = 4
integer width = 3182
integer height = 172
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
end type

