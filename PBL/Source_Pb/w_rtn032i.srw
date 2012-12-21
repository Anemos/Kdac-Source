$PBExportHeader$w_rtn032i.srw
$PBExportComments$조코드/품번 조회[결재]
forward
global type w_rtn032i from w_origin_sheet04
end type
type st_1 from statictext within w_rtn032i
end type
type sle_inputnm from singlelineedit within w_rtn032i
end type
type st_3 from statictext within w_rtn032i
end type
type dw_rtninfo from datawindow within w_rtn032i
end type
type tv_query from treeview within w_rtn032i
end type
type st_nm from statictext within w_rtn032i
end type
type em_ajdate from editmask within w_rtn032i
end type
type st_2 from statictext within w_rtn032i
end type
type st_4 from statictext within w_rtn032i
end type
type pb_find_wkct from picturebutton within w_rtn032i
end type
type pb_find_item from picturebutton within w_rtn032i
end type
type uo_1 from uo_plandiv_bom within w_rtn032i
end type
type pb_excel from picturebutton within w_rtn032i
end type
type em_wcode from singlelineedit within w_rtn032i
end type
type gb_1 from groupbox within w_rtn032i
end type
end forward

global type w_rtn032i from w_origin_sheet04
event ue_keydown pbm_keydown
st_1 st_1
sle_inputnm sle_inputnm
st_3 st_3
dw_rtninfo dw_rtninfo
tv_query tv_query
st_nm st_nm
em_ajdate em_ajdate
st_2 st_2
st_4 st_4
pb_find_wkct pb_find_wkct
pb_find_item pb_find_item
uo_1 uo_1
pb_excel pb_excel
em_wcode em_wcode
gb_1 gb_1
end type
global w_rtn032i w_rtn032i

type variables
datawindowchild i_dwc_nvmo,i_dwc_mcno
datastore ids_data1,ids_data2,ids_data3
string i_s_chkpt,i_s_ajdate,i_s_wkct,i_s_plant,i_s_dvsn
end variables

forward prototypes
public subroutine wf_itempopulate (long ag_handle, treeview ag_tvcurrent)
public subroutine wf_set_items (integer ag_level, integer ag_row, readonly treeviewitem ag_tvinew)
public function integer wf_add_items (long ag_parent, integer ag_level, integer ag_rows, treeview ag_this)
public subroutine wf_init ()
end prototypes

event ue_keydown;if key = keyenter! then
//	window l_s_wsheet
//	l_s_wsheet = w_frame.GetActiveSheet()
	this.TriggerEvent("ue_retrieve")
end if

return 0
end event

public subroutine wf_itempopulate (long ag_handle, treeview ag_tvcurrent);Integer			l_n_Level, l_n_rows
string			l_s_rcitno, l_s_wkct
TreeViewItem	l_tvi_Current,l_tvi_parent
Treeview			l_tv_current
long l_s_handle1

SetPointer(HourGlass!)

// Determine the level
ag_tvcurrent.GetItem(ag_handle, l_tvi_Current)
l_n_Level = l_tvi_Current.Level
l_s_rcitno = l_tvi_current.data

if i_s_chkpt = '1' then
	choose case l_n_level
		case 1
			ids_data1.reset()
			l_s_wkct = l_s_rcitno
			l_n_rows = ids_data1.retrieve(g_s_company,i_s_plant,i_s_dvsn,l_s_wkct,i_s_ajdate)
		case 2
			ids_data2.reset()
			l_s_handle1 = ag_tvcurrent.finditem(roottreeitem!, ag_handle)
			ag_tvcurrent.GetItem(l_s_handle1, l_tvi_parent)
			l_s_wkct = l_tvi_parent.data + '%'
			l_n_rows = ids_data2.retrieve(g_s_company,i_s_plant,i_s_dvsn,l_s_wkct,l_tvi_current.data,i_s_ajdate)
		case 3
			ids_data3.reset()
			l_s_handle1 = ag_tvcurrent.finditem(roottreeitem!, ag_handle)
			ag_tvcurrent.GetItem(l_s_handle1, l_tvi_parent)
			l_s_wkct = l_tvi_parent.data + '%'
			l_s_handle1 = ag_tvcurrent.finditem(parenttreeitem!, ag_handle)
			ag_tvcurrent.GetItem(l_s_handle1, l_tvi_parent)
			l_s_rcitno = l_tvi_parent.data
			l_n_rows = ids_data3.retrieve(g_s_company,i_s_plant,i_s_dvsn,l_s_wkct,l_s_rcitno,l_tvi_current.data,i_s_ajdate)
	end choose
end if

if i_s_chkpt = '2' then
	l_s_wkct = '%'
	choose case l_n_level
		case 1
			ids_data2.reset()
			l_n_rows = ids_data2.retrieve(g_s_company,i_s_plant,i_s_dvsn,l_s_wkct,l_tvi_current.data,i_s_ajdate)
		case 2
			ids_data3.reset()
			l_s_handle1 = ag_tvcurrent.finditem(parenttreeitem!, ag_handle)
			ag_tvcurrent.GetItem(l_s_handle1, l_tvi_parent)
			l_s_rcitno = l_tvi_parent.data
			l_n_rows = ids_data3.retrieve(g_s_company,i_s_plant,i_s_dvsn,l_s_wkct,l_s_rcitno,l_tvi_current.data,i_s_ajdate)
	end choose
end if

wf_add_items(ag_handle,l_n_level,l_n_rows,ag_tvcurrent)
end subroutine

public subroutine wf_set_items (integer ag_level, integer ag_row, readonly treeviewitem ag_tvinew);string ls_getdata, l_s_wkct
integer l_n_sqlcount
long ll_chkcnt

if i_s_chkpt = '1' then
	choose case ag_level
		case 1
			ls_getdata = trim(ids_data1.object.rcitno[ag_row])
			ag_tvinew.data = ls_getdata 
			ag_tvinew.label = ls_getdata
			ag_tvinew.pictureindex = 1
			ag_tvinew.selectedpictureindex = 2
//			ll_chkcnt = ids_data2.retrieve(g_s_company,i_s_plant,i_s_dvsn,i_s_wkct,ls_getdata,i_s_ajdate)
//			if ll_chkcnt > 0 then
				ag_tvinew.children = true
//			else
//				ag_tvinew.children = false
//			end if
		case 2
			ls_getdata = ids_data2.object.rcline1[ag_row]
			ag_tvinew.data  = ls_getdata
			ag_tvinew.label = ls_getdata
			ag_tvinew.pictureindex = 1
			ag_tvinew.selectedpictureindex = 2
			
//			ll_chkcnt = ids_data3.retrieve(g_s_company,i_s_plant,i_s_dvsn,i_s_wkct,ids_data2.object.rcitno[ag_row],ls_getdata,i_s_ajdate)
//			if ll_chkcnt > 0 then
				ag_tvinew.children = true
//			else
//				ag_tvinew.children = false
//			end if
		case 3
			if len(trim(ids_data3.object.rcline1[ag_row])) < 5 then
				ag_tvinew.data  = ids_data3.object.rcline1[ag_row] + ' ' + ids_data3.object.rcline2[ag_row]
			else
				ag_tvinew.data  = ids_data3.object.rcline1[ag_row] + ids_data3.object.rcline2[ag_row]
			end if
			ag_tvinew.label = ids_data3.object.rcline1[ag_row] + '-' + ids_data3.object.rcline2[ag_row]
			ag_tvinew.pictureindex = 1
			ag_tvinew.selectedpictureindex = 2
			ag_tvinew.children = false
	end choose
end if
if i_s_chkpt = '2' then
	l_s_wkct = '%'
	choose case ag_level
		case 1
			ls_getdata = ids_data2.object.rcline1[ag_row]
			ag_tvinew.data  = ls_getdata
			ag_tvinew.label = ls_getdata
			ag_tvinew.pictureindex = 1
			ag_tvinew.selectedpictureindex = 2
			ll_chkcnt = ids_data3.retrieve(g_s_company,i_s_plant,i_s_dvsn,l_s_wkct,ids_data2.object.rcitno[ag_row],ls_getdata,i_s_ajdate)
			if ll_chkcnt > 0 then
				ag_tvinew.children = true
			else
				ag_tvinew.children = false
			end if
		case 2
			if len(trim(ids_data3.object.rcline1[ag_row])) < 5 then
				ag_tvinew.data  = ids_data3.object.rcline1[ag_row] + ' ' + ids_data3.object.rcline2[ag_row]
			else
				ag_tvinew.data  = ids_data3.object.rcline1[ag_row] + ids_data3.object.rcline2[ag_row]
			end if
			ag_tvinew.label = ids_data3.object.rcline1[ag_row] + '-' + ids_data3.object.rcline2[ag_row]
			ag_tvinew.pictureindex = 1
			ag_tvinew.selectedpictureindex = 2
			ag_tvinew.children = false
	end choose
end if

end subroutine

public function integer wf_add_items (long ag_parent, integer ag_level, integer ag_rows, treeview ag_this);Integer			l_n_Cnt
TreeViewItem	l_tvi_New

For l_n_Cnt = 1 To ag_Rows
	// TreeView의 Item에 각각의 값을 Setting시킨다.
	
	wf_set_items(ag_Level, l_n_Cnt, l_tvi_New)
	
	// TreeView에 Item을 추가시킨다.
	If ag_this.InsertItemLast(ag_Parent, l_tvi_New) < 1 Then
		Return -1
	End If
Next

Return ag_Rows

end function

public subroutine wf_init ();em_wcode.backcolor = rgb(255,250,239)
sle_inputnm.backcolor = rgb(255,255,255)
em_ajdate.backcolor = rgb(255,250,239)
st_4.text = ""
st_nm.text = ""
em_ajdate.text = g_s_date
end subroutine

on w_rtn032i.create
int iCurrent
call super::create
this.st_1=create st_1
this.sle_inputnm=create sle_inputnm
this.st_3=create st_3
this.dw_rtninfo=create dw_rtninfo
this.tv_query=create tv_query
this.st_nm=create st_nm
this.em_ajdate=create em_ajdate
this.st_2=create st_2
this.st_4=create st_4
this.pb_find_wkct=create pb_find_wkct
this.pb_find_item=create pb_find_item
this.uo_1=create uo_1
this.pb_excel=create pb_excel
this.em_wcode=create em_wcode
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.sle_inputnm
this.Control[iCurrent+3]=this.st_3
this.Control[iCurrent+4]=this.dw_rtninfo
this.Control[iCurrent+5]=this.tv_query
this.Control[iCurrent+6]=this.st_nm
this.Control[iCurrent+7]=this.em_ajdate
this.Control[iCurrent+8]=this.st_2
this.Control[iCurrent+9]=this.st_4
this.Control[iCurrent+10]=this.pb_find_wkct
this.Control[iCurrent+11]=this.pb_find_item
this.Control[iCurrent+12]=this.uo_1
this.Control[iCurrent+13]=this.pb_excel
this.Control[iCurrent+14]=this.em_wcode
this.Control[iCurrent+15]=this.gb_1
end on

on w_rtn032i.destroy
call super::destroy
destroy(this.st_1)
destroy(this.sle_inputnm)
destroy(this.st_3)
destroy(this.dw_rtninfo)
destroy(this.tv_query)
destroy(this.st_nm)
destroy(this.em_ajdate)
destroy(this.st_2)
destroy(this.st_4)
destroy(this.pb_find_wkct)
destroy(this.pb_find_item)
destroy(this.uo_1)
destroy(this.pb_excel)
destroy(this.em_wcode)
destroy(this.gb_1)
end on

event open;call super::open;//f_window_resize(this)
ids_data1 = create Datastore
// 품번에 대한 대체LINE1
ids_data1.dataobject = "d_rtn01_wkct_item"
ids_data1.settransobject(sqlca)
ids_data2 = create Datastore
// 품번기준 대체LINE1에 대한 대체LINE2
ids_data2.dataobject = "d_rtn01_wkct_item_line"
ids_data2.settransobject(sqlca)
ids_data3 = create Datastore
// 품번기준 대체LINE1에 대한 대체LINE2
ids_data3.dataobject = "d_rtn01_wkct_item_line2"
ids_data3.settransobject(sqlca)

//dw_secjobinfo.getchild("rdnvmo",i_dwc_nvmo)
//i_dwc_nvmo.settransobject(sqlca)
//i_dwc_nvmo.retrieve('RTN010')
//dw_secjobinfo.getchild("rdmcno",i_dwc_mcno)
//i_dwc_mcno.settransobject(sqlca)
//i_dwc_mcno.retrieve('RTN020')
pb_Excel.enabled = false
wf_init()
dw_rtninfo.settransobject(sqlca)
//dw_mcnoinfo.settransobject(sqlca)
//dw_secjobinfo.settransobject(sqlca)

return 0

end event

event ue_retrieve;string       ls_inputnm, ls_chknm, ls_chkcode, ls_line3, ls_linename
integer      k, l_n_rows, l_n_root, l_n_count
boolean      lb_errchk = true
treeviewitem l_tvi_root
long         l_n_tvi

st_4.text = ""
st_nm.text = ""
dw_rtninfo.reset()
//dw_mcnoinfo.reset()
//dw_secjobinfo.reset()
setpointer(hourglass!)

//조코드 체크
i_s_wkct = trim(em_wcode.text)
if f_spacechk(i_s_wkct) <> -1 then
	select dcode,dname into :ls_chkcode,:ls_chknm from PBCOMMON.DAC001
	where duse = ' ' and dtodt = 0 and dcode = :i_s_wkct and dacttodt = 0 
	using sqlca;
	
	if f_spacechk(ls_chkcode) = -1 then
		em_wcode.backcolor = rgb(255,255,0)
		lb_errchk = false
	else
		em_wcode.backcolor = rgb(255,250,239)
		st_4.text = ls_chknm
	end if
end if

//적용일 체크
em_ajdate.getdata(i_s_ajdate)
if f_spacechk(i_s_ajdate) = -1 or f_dateedit(i_s_ajdate) = space(8) then
	em_ajdate.backcolor = rgb(255,255,0)
	lb_errchk = false
else
	em_ajdate.backcolor = rgb(255,250,239)
end if

ls_inputnm = trim(sle_inputnm.text)
ls_chknm = mid(f_bom_get_itemname(ls_inputnm),1,30)
//품번 체크
if f_spacechk(ls_inputnm) = -1 then
	i_s_chkpt = '1'    //품번이 입력되지 않은 경우
else
	if f_spacechk(ls_chknm) = -1 then
		sle_inputnm.backcolor = rgb(255,255,0)
		lb_errchk = false
	else
		sle_inputnm.backcolor = rgb(255,255,255)
		st_nm.text = ls_chknm
	end if
	i_s_chkpt = '2'    //품번이 입력된 경우
end if

if lb_errchk = false then
	uo_status.st_message.text = "입력상에 오류가 있습니다."
	return 0
end if

do until tv_query.FindItem(roottreeitem!, 0) = -1 
    l_n_tvi = tv_query.FindItem(roottreeitem!, 0)
    tv_query.DeleteItem(l_n_tvi)
loop

uo_status.st_message.text = ""
setpointer(HourGlass!)

i_s_plant = mid(uo_1.uf_return(),1,1)
i_s_dvsn = mid(uo_1.uf_return(),2,1)

ids_data1.reset()
ids_data2.reset()

if i_s_chkpt = '1' then
	if f_spacechk(i_s_wkct) = -1 then
		ls_line3 = ''
		do while true
			SELECT DISTINCT "PBRTN"."RTN015"."RELINE3", "PBCOMMON"."DAC001"."DFNAME4" 
			INTO :ls_line3, :ls_linename
			FROM "PBRTN"."RTN015","PBCOMMON"."DAC001"
			WHERE ( "PBCOMMON"."DAC001"."DUSE" = ' ' ) AND
				( "PBCOMMON"."DAC001"."DTODT" = 0 ) AND
				( "PBCOMMON"."DAC001"."DCODE" = "PBRTN"."RTN015"."RELINE3" ) AND
				( "PBCOMMON"."DAC001"."DACTTODT" = 0 ) AND
				( "PBRTN"."RTN015"."RECMCD" = '01' ) AND    
				( "PBRTN"."RTN015"."REDVSN"  = :i_s_dvsn ) AND  
				( "PBRTN"."RTN015"."REPLANT" = :i_s_plant ) AND
				( "PBRTN"."RTN015"."RELINE3" > :ls_line3 ) AND
				( "PBRTN"."RTN015"."REEDFM" <= :i_s_ajdate AND "PBRTN"."RTN015"."REEDTO" >= :i_s_ajdate AND
					"PBRTN"."RTN015"."REEDFM" <= "PBRTN"."RTN015"."REEDTO" )
			ORDER BY "PBRTN"."RTN015"."RELINE3"
			FETCH FIRST 1 ROW ONLY
			using sqlca;
			if sqlca.sqlcode <> 0 or f_spacechk(ls_line3) = -1 then
				exit
			end if
			l_tvi_root.label = ls_linename + "(" + ls_line3 + ")"
			l_tvi_root.data  = ls_line3
			l_tvi_root.pictureindex = 1	
			l_tvi_root.selectedpictureindex = 2
	//			if ids_data1.retrieve(g_s_company,i_s_plant,i_s_div,ls_line3,i_s_ajdate) > 0 then
				l_tvi_root.children = true
	//			else
	//				l_tvi_root.children = false
	//			end if
			l_n_root = tv_query.insertitemlast(0,l_tvi_root)
	//			l_s_populate = 0
	//			tv_query.expanditem(l_n_root)
		loop
	else
		l_tvi_root.label = i_s_wkct
		l_tvi_root.data  = i_s_wkct
		l_tvi_root.pictureindex = 1	
		l_tvi_root.selectedpictureindex = 2
		l_tvi_root.children = true
		l_n_root = tv_query.insertitemlast(0,l_tvi_root)
	end if
else
	ls_inputnm = f_rtn02_conv_itno(i_s_plant,i_s_dvsn,ls_inputnm,i_s_ajdate)
	if trim(sle_inputnm.text) <> trim(ls_inputnm) then
		messagebox("확인", trim(sle_inputnm.text) + "  품번은 유사 품번입니다. 대표품번 " + trim(ls_inputnm) + &
								 "의 Routing 정보가 조회 됩니다 " )
	end if

	select count(*) into :l_n_count from pbrtn.rtn015
		where recmcd = '01' and replant = :i_s_plant and redvsn = :i_s_dvsn and reitno = :ls_inputnm
	and reedfm <= :i_s_ajdate and reedto >= :i_s_ajdate
	using sqlca;

	if l_n_count < 1 then
		uo_status.st_message.text = f_message("I020")
		return 0
	end if
	
	l_tvi_root.label = ls_inputnm
	l_tvi_root.data  = ls_inputnm
	l_tvi_root.pictureindex = 1	
	l_tvi_root.selectedpictureindex = 2
	l_tvi_root.children = true
	l_n_root = tv_query.insertitemlast(0,l_tvi_root)
end if
setpointer(arrow!)
uo_status.st_message.text = f_message("I010")
return 0
end event

event close;call super::close;destroy ids_data1
destroy ids_data2
destroy ids_data3
 
return 0

end event

event resize;call super::resize;
dw_rtninfo.Width = newwidth - ( dw_rtninfo.x + 10 ) 
dw_rtninfo.Height = newheight - ( dw_rtninfo.y + uo_status.Height + 10 ) 

tv_query.Height = dw_rtninfo.Height
end event

type uo_status from w_origin_sheet04`uo_status within w_rtn032i
end type

type st_1 from statictext within w_rtn032i
integer x = 37
integer y = 76
integer width = 265
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "조코드"
boolean focusrectangle = false
end type

type sle_inputnm from singlelineedit within w_rtn032i
event ue_keydown pbm_keydown
integer x = 270
integer y = 176
integer width = 594
integer height = 80
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
textcase textcase = upper!
borderstyle borderstyle = stylelowered!
end type

event ue_keydown;if key = keyenter! then
	parent.triggerevent("ue_retrieve")
end if
end event

type st_3 from statictext within w_rtn032i
integer x = 2057
integer y = 72
integer width = 242
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "적용일"
boolean focusrectangle = false
end type

type dw_rtninfo from datawindow within w_rtn032i
integer x = 1303
integer y = 300
integer width = 3305
integer height = 2164
boolean bringtotop = true
string title = "none"
string dataobject = "d_rtn032i_detail_rtninfo"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;integer li_rowcnt

li_rowcnt = this.rowcount()
if row > 0 and row <= li_rowcnt then
	this.selectrow(0, false)
	this.selectrow(row,true)
else
	this.selectrow(0,false)
end if

return 0
end event

event doubleclicked;//string ls_itno,ls_line,ls_opno,ls_div,ls_plant
//long ll_rowcnt,ll_rowcnt1,ll_rowcnt2
//
//dw_mcnoinfo.reset()
//dw_secjobinfo.reset()
//uo_status.st_message.text = ""
//
//ls_line  = trim(dw_rtninfo.object.rcline1[row]) + trim(dw_rtninfo.object.rcline2[row])
//ls_plant = dw_rtninfo.object.rcplant[row]
//ls_div   = dw_rtninfo.object.rcdvsn[row]
//ls_itno  = dw_rtninfo.object.rcitno[row]
//ls_opno  = dw_rtninfo.object.rcopno[row]
//
//ll_rowcnt1 = dw_mcnoinfo.retrieve(g_s_company,ls_plant,ls_div,ls_itno,ls_line,ls_opno)
//ll_rowcnt2 = dw_secjobinfo.retrieve(g_s_company,ls_plant,ls_div,ls_itno,ls_line,ls_opno,i_s_ajdate)
//
//ll_rowcnt = ll_rowcnt1 + ll_rowcnt2
//choose case ll_rowcnt
//	case 0
//		uo_status.st_message.text = " 공정에 대한 장비및 부대작업내역이 없습니다."
//	case else
//		if ll_rowcnt1 = 0 then
//			uo_status.st_message.text = "공정에 대한 장비내역이 없습니다."
//		elseif ll_rowcnt2 = 0 then
//			uo_status.st_message.text = "공정에 대한 부대작업내역이 없습니다."
//		end if
//end choose
//return 0
//
end event

type tv_query from treeview within w_rtn032i
integer x = 18
integer y = 296
integer width = 1262
integer height = 2160
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
borderstyle borderstyle = stylelowered!
string picturename[] = {"Custom039!","Custom050!"}
long picturemaskcolor = 536870912
long statepicturemaskcolor = 536870912
end type

event selectionchanged;string l_s_itno, l_s_itno1, l_s_itno2, ls_line1, ls_line2, l_s_wkct
treeviewitem l_tvi_item	, l_tvi_item1 , l_tvi_item2
integer l_n_rows
long l_s_handle , l_s_handle1

uo_status.st_message.text = ""

dw_rtninfo.reset()
//dw_mcnoinfo.reset()
//dw_secjobinfo.reset()
//
tv_query.getitem(newhandle, l_tvi_item)
l_s_itno = f_spacedel(l_tvi_item.data)
if i_s_chkpt = '1' then
	if l_tvi_item.level <> 4 then 
		return 0
	end if
	l_s_handle = tv_query.finditem(roottreeitem!,newhandle)
	tv_query.getitem(l_s_handle, l_tvi_item1)
	l_s_wkct = f_spacedel(l_tvi_item1.data) + '%'
else
	if l_tvi_item.level <> 3 then 
		return 0
	end if
	l_s_wkct = '%'
end if

l_s_handle = tv_query.finditem(parenttreeitem!,newhandle)
tv_query.getitem(l_s_handle, l_tvi_item1)
l_s_itno1 = f_spacedel(l_tvi_item1.data)

l_s_handle1 = tv_query.finditem(parenttreeitem!,l_s_handle)
tv_query.getitem(l_s_handle1, l_tvi_item2)
l_s_itno2 = f_spacedel(l_tvi_item2.data)

ls_line1 = mid(l_s_itno,1,len(l_s_itno) - 1)
ls_line2 = mid(l_s_itno,len(l_s_itno),1)
l_n_rows = dw_rtninfo.retrieve(g_s_company,i_s_plant,i_s_dvsn,l_s_wkct,l_s_itno2,ls_line1,ls_line2,i_s_ajdate)

if l_n_rows < 1 then
	uo_status.st_message.text = "조회할 데이타가 없습니다."
	pb_Excel.enabled = false
else
	uo_status.st_message.text = "조회되었습니다."
	pb_Excel.enabled = true
end if

return 0
end event

event itempopulate;Integer			l_n_Level
TreeViewItem	l_tvi_Current
long           l_n_rows

// Determine the level
tv_query.GetItem(handle, l_tvi_Current)
l_n_Level = l_tvi_Current.Level

if i_s_chkpt = '1' then
	if l_n_level > 3 then 
		return 0
	end if
else
	if l_n_level > 2 then 
		return 0
	end if
end if
		
wf_itempopulate(handle, tv_query)
return 0
end event

event clicked;Integer			l_n_Level
TreeViewItem	l_tvi_Current
long           l_n_rows

// Determine the level
tv_query.GetItem(handle, l_tvi_Current)
l_n_Level = l_tvi_Current.Level

if l_n_level < 4 then
	pb_excel.enabled = false
end if
end event

type st_nm from statictext within w_rtn032i
integer x = 1193
integer y = 176
integer width = 914
integer height = 80
boolean bringtotop = true
integer textsize = -11
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type em_ajdate from editmask within w_rtn032i
event ue_keydown pbm_keydown
integer x = 2309
integer y = 60
integer width = 389
integer height = 80
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
alignment alignment = right!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "####.##.##"
end type

event ue_keydown;//if key = keyenter! then
//	parent.triggerevent("ue_retrieve")
//end if
end event

type st_2 from statictext within w_rtn032i
integer x = 37
integer y = 184
integer width = 219
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "품  번"
boolean focusrectangle = false
end type

type st_4 from statictext within w_rtn032i
integer x = 901
integer y = 64
integer width = 1006
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type pb_find_wkct from picturebutton within w_rtn032i
integer x = 622
integer y = 56
integer width = 238
integer height = 108
integer taborder = 20
boolean bringtotop = true
integer textsize = -11
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string picturename = "C:\kdac\bmp\search.gif"
alignment htextalign = left!
end type

event clicked;string l_s_parm

l_s_parm = ' I'

openwithparm(w_find_001 , l_s_parm)
l_s_parm = message.stringparm

if f_spacechk(l_s_parm) <> -1 then
	st_4.text = ''
	st_4.text = mid(l_s_parm,16,30)
	em_wcode.text = trim(mid(l_s_parm,1,5))
end if

return 0
end event

type pb_find_item from picturebutton within w_rtn032i
integer x = 901
integer y = 168
integer width = 238
integer height = 108
integer taborder = 70
boolean bringtotop = true
integer textsize = -11
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
boolean originalsize = true
string picturename = "C:\kdac\bmp\search.gif"
alignment htextalign = left!
end type

event clicked;string ls_plant,ls_div,ls_pdcd,ls_parm

uo_status.st_message.text = ""
ls_parm  = uo_1.uf_return()
ls_plant = mid(ls_parm,1,1)
ls_div   = mid(ls_parm,2,1)
ls_pdcd  = mid(ls_parm,3,2)

if f_spacechk(ls_pdcd) = -1 then
	uo_status.st_message.text = "제품군을 선택해 주십시요"
	return 0
end if
ls_parm = g_s_date + ls_plant + ls_div + ls_pdcd
openwithparm(w_bom110u_res_03,ls_parm)
ls_parm = message.stringparm
sle_inputnm.text = ls_parm

return 0
end event

type uo_1 from uo_plandiv_bom within w_rtn032i
integer x = 2857
integer y = 44
integer taborder = 40
boolean bringtotop = true
end type

on uo_1.destroy
call uo_plandiv_bom::destroy
end on

type pb_excel from picturebutton within w_rtn032i
integer x = 4261
integer y = 136
integer width = 315
integer height = 132
integer taborder = 40
boolean bringtotop = true
integer textsize = -11
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string picturename = "C:\KDAC\bmp\Excel.bmp"
alignment htextalign = left!
end type

event clicked;f_save_to_excel(dw_rtninfo)
end event

type em_wcode from singlelineedit within w_rtn032i
integer x = 270
integer y = 64
integer width = 329
integer height = 80
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
string text = " "
textcase textcase = upper!
borderstyle borderstyle = stylelowered!
end type

type gb_1 from groupbox within w_rtn032i
integer x = 18
integer width = 4585
integer height = 288
integer textsize = -11
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
end type

