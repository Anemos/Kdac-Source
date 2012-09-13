$PBExportHeader$w_rtn031i.srw
$PBExportComments$품번/대체 Line별 조회[결재]
forward
global type w_rtn031i from w_origin_sheet04
end type
type rb_line from radiobutton within w_rtn031i
end type
type rb_item from radiobutton within w_rtn031i
end type
type sle_inputnm from singlelineedit within w_rtn031i
end type
type tv_query from treeview within w_rtn031i
end type
type pb_find_itno from picturebutton within w_rtn031i
end type
type dw_rtninfo from datawindow within w_rtn031i
end type
type st_nm from statictext within w_rtn031i
end type
type st_3 from statictext within w_rtn031i
end type
type em_date from editmask within w_rtn031i
end type
type uo_1 from uo_plandiv_pdcd within w_rtn031i
end type
type pb_excel from picturebutton within w_rtn031i
end type
type cb_rtn015_template from commandbutton within w_rtn031i
end type
type cb_rtn016_template from commandbutton within w_rtn031i
end type
type dw_down from datawindow within w_rtn031i
end type
type gb_1 from groupbox within w_rtn031i
end type
end forward

global type w_rtn031i from w_origin_sheet04
rb_line rb_line
rb_item rb_item
sle_inputnm sle_inputnm
tv_query tv_query
pb_find_itno pb_find_itno
dw_rtninfo dw_rtninfo
st_nm st_nm
st_3 st_3
em_date em_date
uo_1 uo_1
pb_excel pb_excel
cb_rtn015_template cb_rtn015_template
cb_rtn016_template cb_rtn016_template
dw_down dw_down
gb_1 gb_1
end type
global w_rtn031i w_rtn031i

type variables
datawindowchild i_dwc_nvmo,i_dwc_mcno
datastore ids_data1,ids_data2,ids_data3,ids_data4
string i_s_chkpt,i_s_ajdate,i_s_div,i_s_plant,i_s_pdcd
end variables

forward prototypes
public subroutine wf_init ()
public subroutine wf_set_items (integer ag_level, integer ag_row, readonly treeviewitem ag_tvinew)
public subroutine wf_itempopulate (long ag_handle, treeview ag_tvcurrent)
public function integer wf_add_items (long ag_parent, integer ag_level, integer ag_rows, treeview ag_this)
end prototypes

public subroutine wf_init ();//em_ajdate.backcolor = rgb(255,250,239)
sle_inputnm.backcolor = rgb(255,250,239)
//em_ajdate.text = g_s_date
rb_item.checked = true
end subroutine

public subroutine wf_set_items (integer ag_level, integer ag_row, readonly treeviewitem ag_tvinew);string l_s_rcline, l_s_rcitno
integer l_n_sqlcount

if ag_level = 1 then
	//품번
	if i_s_chkpt = '1' then
		ag_tvinew.data  = ids_data1.object.rcline1[ag_row] 
		ag_tvinew.label = ids_data1.object.rcline1[ag_row] 
		ag_tvinew.pictureindex = 1
		ag_tvinew.selectedpictureindex = 2
		l_s_rcline = trim(ag_tvinew.data)
		l_s_rcitno = trim(ids_data1.object.rcitno[ag_row]) 
		select count(*) into: l_n_sqlcount from pbrtn.rtn015
	       where replant = :i_s_plant and redvsn = :i_s_div and reline1 = :l_s_rcline and reitno = :l_s_rcitno using sqlca;
	//LINE
	elseif i_s_chkpt = '2' then
		
		ag_tvinew.data  = trim(ids_data3.object.rcline1[ag_row]) + ids_data3.object.rcline2[ag_row]
		
		ag_tvinew.label = ids_data3.object.rcline1[ag_row] + '-' + ids_data3.object.rcline2[ag_row]
		ag_tvinew.pictureindex = 1
		ag_tvinew.selectedpictureindex = 2
		l_s_rcline = ag_tvinew.data
		select count(*) into: l_n_sqlcount from pbrtn.rtn015
	       where replant = :i_s_plant and redvsn = :i_s_div and trim(reline1) || reline2 = :l_s_rcline using sqlca;
	end if
	if l_n_sqlcount > 0 then 
		ag_tvinew.children = true
	else
		ag_tvinew.children = false
	end if
elseif ag_level = 2 then
	if i_s_chkpt = '2' then
		ag_tvinew.data = ids_data4.object.rcitno[ag_row]
		ag_tvinew.label = ids_data4.object.rcitno[ag_row]
		ag_tvinew.pictureindex = 1
		ag_tvinew.selectedpictureindex = 2
		ag_tvinew.children = false
	elseif i_s_chkpt = '1' then
		ag_tvinew.data  = trim(ids_data2.object.rcline1[ag_row]) + ' ' + ids_data2.object.rcline2[ag_row]
		ag_tvinew.label = ids_data2.object.rcline1[ag_row] + '-' + ids_data2.object.rcline2[ag_row]
		ag_tvinew.pictureindex = 1
		ag_tvinew.selectedpictureindex = 2
		ag_tvinew.children = false
	end if
end if
end subroutine

public subroutine wf_itempopulate (long ag_handle, treeview ag_tvcurrent);Integer			l_n_Level, l_n_rows
string			l_s_rcitno
TreeViewItem	l_tvi_Current,l_tvi_parent
Treeview			l_tv_current
long l_s_handle1

SetPointer(HourGlass!)

// Determine the level
ag_tvcurrent.GetItem(ag_handle, l_tvi_Current)
l_n_Level = l_tvi_Current.Level
l_s_rcitno = l_tvi_current.data

if l_n_level = 1 and i_s_chkpt = '1' then
	l_n_rows = ids_data1.retrieve(g_s_company,i_s_plant,i_s_div,l_tvi_current.data,i_s_ajdate,i_s_pdcd)
elseif l_n_level = 1 and i_s_chkpt = '2' then
	l_n_rows = ids_data3.retrieve(g_s_company,i_s_plant,i_s_div,l_tvi_current.data,i_s_ajdate,i_s_pdcd)
elseif l_n_level = 2 and i_s_chkpt = '2' then
	l_n_rows = ids_data4.retrieve(g_s_company,i_s_plant,i_s_div,l_tvi_current.data,i_s_ajdate,i_s_pdcd)
elseif l_n_level = 2 and i_s_chkpt = '1' then
	l_s_handle1 = ag_tvcurrent.finditem(parenttreeitem!, ag_handle)
	ag_tvcurrent.GetItem(l_s_handle1, l_tvi_parent)
	l_s_rcitno = l_tvi_parent.data
	l_n_rows = ids_data2.retrieve(g_s_company,i_s_plant,i_s_div,l_s_rcitno,l_tvi_current.data,i_s_ajdate,i_s_pdcd)
end if
if l_n_rows <= 0 then
	uo_status.st_message.text = f_message("I020")
end if
wf_add_items(ag_handle,l_n_level,l_n_rows,ag_tvcurrent)
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

on w_rtn031i.create
int iCurrent
call super::create
this.rb_line=create rb_line
this.rb_item=create rb_item
this.sle_inputnm=create sle_inputnm
this.tv_query=create tv_query
this.pb_find_itno=create pb_find_itno
this.dw_rtninfo=create dw_rtninfo
this.st_nm=create st_nm
this.st_3=create st_3
this.em_date=create em_date
this.uo_1=create uo_1
this.pb_excel=create pb_excel
this.cb_rtn015_template=create cb_rtn015_template
this.cb_rtn016_template=create cb_rtn016_template
this.dw_down=create dw_down
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.rb_line
this.Control[iCurrent+2]=this.rb_item
this.Control[iCurrent+3]=this.sle_inputnm
this.Control[iCurrent+4]=this.tv_query
this.Control[iCurrent+5]=this.pb_find_itno
this.Control[iCurrent+6]=this.dw_rtninfo
this.Control[iCurrent+7]=this.st_nm
this.Control[iCurrent+8]=this.st_3
this.Control[iCurrent+9]=this.em_date
this.Control[iCurrent+10]=this.uo_1
this.Control[iCurrent+11]=this.pb_excel
this.Control[iCurrent+12]=this.cb_rtn015_template
this.Control[iCurrent+13]=this.cb_rtn016_template
this.Control[iCurrent+14]=this.dw_down
this.Control[iCurrent+15]=this.gb_1
end on

on w_rtn031i.destroy
call super::destroy
destroy(this.rb_line)
destroy(this.rb_item)
destroy(this.sle_inputnm)
destroy(this.tv_query)
destroy(this.pb_find_itno)
destroy(this.dw_rtninfo)
destroy(this.st_nm)
destroy(this.st_3)
destroy(this.em_date)
destroy(this.uo_1)
destroy(this.pb_excel)
destroy(this.cb_rtn015_template)
destroy(this.cb_rtn016_template)
destroy(this.dw_down)
destroy(this.gb_1)
end on

event open;call super::open;// f_window_resize(this)

// dw_secjobinfo.getchild("rdnvmo",i_dwc_nvmo)
i_dwc_nvmo.settransobject(sqlca)
i_dwc_nvmo.retrieve('RTN010')
// dw_secjobinfo.getchild("rdmcno",i_dwc_mcno)
i_dwc_mcno.settransobject(sqlca)
i_dwc_mcno.retrieve('RTN020')

ids_data1 = create Datastore
// 품번에 대한 대체LINE1
ids_data1.dataobject = "d_rtn01_item_line"
ids_data1.settransobject(sqlca)
ids_data2 = create Datastore
// 품번기준 대체LINE1에 대한 대체LINE2
ids_data2.dataobject = "d_rtn01_item_line_line"
ids_data2.settransobject(sqlca)
ids_data3 = create Datastore
// 대체LINE1에 대한 대체LINE2
ids_data3.dataobject = "d_rtn01_line_line"
ids_data3.settransobject(sqlca)
ids_data4 = create Datastore
// 대체LINE기준 대체LINE2에 대한 품번
ids_data4.dataobject = "d_rtn01_line_line_item"
ids_data4.settransobject(sqlca)

pb_excel.enabled = false
wf_init()

dw_rtninfo.settransobject(sqlca)
//dw_mcnoinfo.settransobject(sqlca)
//dw_secjobinfo.settransobject(sqlca)
em_date.text = g_s_date
//uo_1.height = 108
return 0

end event

event ue_retrieve;string       ls_inputnm,ls_test,ls_rtn, ls_itno, ls_line1,ls_chkpdcd
integer      l_n_rows, l_n_root,l_n_count
treeviewitem l_tvi_root
long         l_n_tvi

st_nm.text = ""
uo_status.st_message.text = ""
dw_rtninfo.reset()
//dw_mcnoinfo.reset()
//dw_secjobinfo.reset()
setpointer(HourGlass!)

em_date.getdata(i_s_ajdate)
//날짜 체크
if f_spacechk(i_s_ajdate) = -1 or f_dateedit(i_s_ajdate) = space(8) then
	em_date.backcolor = rgb(255,255,0)
	uo_status.st_message.text = f_message("I020")
else
	em_date.backcolor = rgb(255,250,239)
end if

do until tv_query.FindItem(roottreeitem!, 0) = -1 
    l_n_tvi = tv_query.FindItem(roottreeitem!, 0)
    tv_query.DeleteItem(l_n_tvi)
loop

string l_s_parm
l_s_parm    = uo_1.uf_Return()
i_s_plant   = mid(l_s_parm,1,1)
i_s_div     = mid(l_s_parm,2,1)
i_s_pdcd    = mid(l_s_parm,3,2)
if f_spacechk(i_s_plant) = -1 or f_spacechk(i_s_div) = -1 or f_spacechk(i_s_pdcd) = -1 then
	uo_status.st_message.text = "지역,공장,제품군은 필수입력사항 입니다."
	return 0
end if

ids_data1.reset()
ids_data2.reset()
ids_data3.reset()
ids_data4.reset()
ls_inputnm = trim(sle_inputnm.text)
if f_spacechk(ls_inputnm) <> -1 then
	select substring(pdcd,1,2) into :ls_chkpdcd
	from pbinv.inv101
	where comltd = '01' and xplant = :i_s_plant and
			div = :i_s_div and itno = :ls_inputnm
	using sqlca;
	
	if i_s_pdcd <> ls_chkpdcd then
		select prname into :ls_chkpdcd
		from pbcommon.dac007 where prprcd = :ls_chkpdcd
		using sqlca;
		
		uo_status.st_message.text = "제품군에 해당하는 품번이 아닙니다. => " + ls_chkpdcd
		return 0
	end if
end if
i_s_pdcd = i_s_pdcd + '%'

//품번 체크
if rb_item.checked = true then
	ls_rtn = mid(f_get_inv002_rtn(ls_inputnm),1,30)
	i_s_chkpt = '1'
	if f_spacechk(ls_rtn) = -1 then
		ls_itno = ''
		do while true
			SELECT DISTINCT "PBRTN"."RTN015"."REITNO" INTO :ls_itno
    		FROM "PBRTN"."RTN015",   
         	"PBINV"."INV101",   
         	"PBINV"."INV002" 
   		WHERE ( "PBINV"."INV002"."COMLTD" = "PBRTN"."RTN015"."RECMCD" ) and
         	( "PBRTN"."RTN015"."REITNO" = "PBINV"."INV002"."ITNO" ) and 
         	( "PBINV"."INV101"."COMLTD" = "PBRTN"."RTN015"."RECMCD" ) and  
         	( "PBINV"."INV101"."XPLANT" = "PBRTN"."RTN015"."REPLANT" ) and
         	( "PBRTN"."RTN015"."REDVSN" = "PBINV"."INV101"."DIV" ) and  
         	( "PBRTN"."RTN015"."REITNO" = "PBINV"."INV101"."ITNO" ) and  
         	( ( "PBRTN"."RTN015"."RECMCD" = '01' ) AND  
         	( "PBINV"."INV101"."PDCD" LIKE :i_s_pdcd ) AND  
         	( "PBRTN"."RTN015"."REDVSN"  = :i_s_div ) AND  
         	( "PBRTN"."RTN015"."REPLANT" = :i_s_plant ) AND
				( "PBRTN"."RTN015"."REITNO" > :ls_itno ) AND
				("PBRTN"."RTN015"."REEDFM" <= :i_s_ajdate AND "PBRTN"."RTN015"."REEDTO" >= :i_s_ajdate AND
          		"PBRTN"."RTN015"."REEDFM" <= "PBRTN"."RTN015"."REEDTO" ) AND 
         	( TRIM("PBINV"."INV101"."SRCE") in ( '','03','04' ) ) )
			ORDER BY "PBRTN"."RTN015"."REITNO"
			FETCH FIRST 1 ROW ONLY
			using sqlca;
			if sqlca.sqlcode <> 0 or f_spacechk(ls_itno) = -1 then
				exit
			end if
			l_tvi_root.label = ls_itno
			l_tvi_root.data  = ls_itno
			l_tvi_root.pictureindex = 1	
			l_tvi_root.selectedpictureindex = 2
//			if ids_data1.retrieve(g_s_company,i_s_plant,i_s_div,ls_itno,i_s_ajdate) > 0 then
				l_tvi_root.children = true
//			else
//				l_tvi_root.children = false
//			end if
			l_n_root = tv_query.insertitemlast(0,l_tvi_root)
//			l_s_populate = 0
//			tv_query.expanditem(l_n_root)
		loop
	else
		ls_inputnm = f_rtn02_conv_itno(i_s_plant,i_s_div,ls_inputnm,i_s_ajdate)
		if trim(sle_inputnm.text) <> trim(ls_inputnm) then
			messagebox("확인", trim(sle_inputnm.text) + "  품번은 유사 품번입니다. 대표품번 " + trim(ls_inputnm) + &
			                   "의 Routing 정보가 조회 됩니다 " )
		end if

		select count(*) into :l_n_count from pbrtn.rtn015
			where recmcd = '01' and replant = :i_s_plant and redvsn = :i_s_div and reitno = :ls_inputnm
		and reedfm <= :i_s_ajdate and reedto >= :i_s_ajdate
		using sqlca;

		if l_n_count < 1 then
			uo_status.st_message.text = f_message("I020")
			return 0
		end if
		
		st_nm.text = ls_rtn
		l_tvi_root.label = ls_inputnm
		l_tvi_root.data  = ls_inputnm
		l_tvi_root.pictureindex = 1	
		l_tvi_root.selectedpictureindex = 2
		l_tvi_root.children = true
		l_n_root = tv_query.insertitemlast(0,l_tvi_root)
		sle_inputnm.backcolor = rgb(255,250,239)
	end if
else
	i_s_chkpt = '2'
	st_nm.text = ''
	if f_spacechk(ls_inputnm) = -1 then
		ls_line1 = ''
		do while true
			SELECT DISTINCT "PBRTN"."RTN015"."RELINE1" INTO :ls_line1
    		FROM "PBRTN"."RTN015",   
         	"PBINV"."INV101"
   		WHERE ( "PBINV"."INV101"."COMLTD" = "PBRTN"."RTN015"."RECMCD" ) and  
         	( "PBINV"."INV101"."XPLANT" = "PBRTN"."RTN015"."REPLANT" ) and
         	( "PBRTN"."RTN015"."REDVSN" = "PBINV"."INV101"."DIV" ) and  
         	( "PBRTN"."RTN015"."REITNO" = "PBINV"."INV101"."ITNO" ) and  
         	( "PBRTN"."RTN015"."RECMCD" = '01' ) AND  
         	( "PBINV"."INV101"."PDCD" LIKE :i_s_pdcd ) AND  
         	( "PBRTN"."RTN015"."REDVSN"  = :i_s_div ) AND  
         	( "PBRTN"."RTN015"."REPLANT" = :i_s_plant ) AND
				( "PBRTN"."RTN015"."RELINE1" > :ls_line1 ) AND
				("PBRTN"."RTN015"."REEDFM" <= :i_s_ajdate AND "PBRTN"."RTN015"."REEDTO" >= :i_s_ajdate AND
          		"PBRTN"."RTN015"."REEDFM" <= "PBRTN"."RTN015"."REEDTO" )
			ORDER BY "PBRTN"."RTN015"."RELINE1"
			FETCH FIRST 1 ROW ONLY
			using sqlca;
			if sqlca.sqlcode <> 0 or f_spacechk(ls_line1) = -1 then
				exit
			end if
			l_tvi_root.label = ls_line1
			l_tvi_root.data  = ls_line1
			l_tvi_root.pictureindex = 1	
			l_tvi_root.selectedpictureindex = 2
//			if ids_data3.retrieve(g_s_company,i_s_plant,i_s_div,ls_line1,i_s_ajdate) > 0 then
				l_tvi_root.children = true
//			else
//				l_tvi_root.children = false
//			end if
			l_n_root = tv_query.insertitemlast(0,l_tvi_root)
//			l_s_populate = 0
//			tv_query.expanditem(l_n_root)
		loop
	else
		select count(*) into :l_n_count from pbrtn.rtn015
			where recmcd = '01' and replant = :i_s_plant and redvsn = :i_s_div and reitno = :ls_inputnm
		and reedfm <= :i_s_ajdate and reedto >= :i_s_ajdate
		using sqlca;
		
		if l_n_count < 1 then
			uo_status.st_message.text = f_message("I020")
			return
		end if
		sle_inputnm.backcolor = rgb(255,250,239)
		l_tvi_root.label = ls_inputnm
		l_tvi_root.data  = ls_inputnm
		l_tvi_root.pictureindex = 1	
		l_tvi_root.selectedpictureindex = 2
		l_tvi_root.children = true
		l_n_root = tv_query.insertitemlast(0,l_tvi_root)
	end if
end if

setpointer(arrow!)
uo_status.st_message.text = f_message("I010")
return 0
end event

event close;call super::close;destroy ids_data1
destroy ids_data2
destroy ids_data3
destroy ids_data4
 
return 0
end event

type uo_status from w_origin_sheet04`uo_status within w_rtn031i
end type

type rb_line from radiobutton within w_rtn031i
integer x = 379
integer y = 168
integer width = 439
integer height = 64
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "대체 Line"
end type

event clicked;pb_find_itno.enabled = false
end event

type rb_item from radiobutton within w_rtn031i
integer x = 69
integer y = 168
integer width = 265
integer height = 64
integer taborder = 10
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "품번"
end type

event clicked;pb_find_itno.enabled = true
end event

type sle_inputnm from singlelineedit within w_rtn031i
event ue_keydown pbm_keydown
integer x = 850
integer y = 168
integer width = 626
integer height = 80
integer taborder = 50
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

type tv_query from treeview within w_rtn031i
integer x = 27
integer y = 296
integer width = 645
integer height = 2180
integer taborder = 130
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

event selectionchanged;string l_s_itno, l_s_itno1, l_s_itno2, ls_line1, ls_line2
treeviewitem l_tvi_item	, l_tvi_item1 , l_tvi_item2
integer l_n_rows
long l_s_handle , l_s_handle1

uo_status.st_message.text = ""

dw_rtninfo.reset()
//dw_mcnoinfo.reset()
//dw_secjobinfo.reset()

tv_query.getitem(newhandle, l_tvi_item)

l_s_itno = f_spacedel(l_tvi_item.data)
if l_tvi_item.level <> 3 then 
	return
end if

l_s_handle = tv_query.finditem(parenttreeitem!,newhandle)
tv_query.getitem(l_s_handle, l_tvi_item1)
l_s_itno1 = f_spacedel(l_tvi_item1.data)

l_s_handle1 = tv_query.finditem(parenttreeitem!,l_s_handle)
tv_query.getitem(l_s_handle1, l_tvi_item2)
l_s_itno2 = f_spacedel(l_tvi_item2.data)


if i_s_chkpt = '1' then
	ls_line1 = mid(l_s_itno,1,len(l_s_itno) - 1)
	ls_line2 = mid(l_s_itno,len(l_s_itno),1)
	l_n_rows = dw_rtninfo.retrieve(g_s_company,i_s_plant,i_s_div,l_s_itno2,ls_line1,ls_line2,i_s_ajdate)
else
	ls_line1 = mid(l_s_itno1,1,len(l_s_itno1) - 1)
	ls_line2 = mid(l_s_itno1,len(l_s_itno1),1)
	l_n_rows = dw_rtninfo.retrieve(g_s_company,i_s_plant,i_s_div,l_s_itno,ls_line1,ls_line2,i_s_ajdate)
end if

if l_n_rows < 1 then
	pb_excel.enabled = false
	uo_status.st_message.text = "조회할 데이타가 없습니다."
else
	pb_excel.enabled = true
	uo_status.st_message.text = "조회 완료."
end if

return 0
end event

event itempopulate;Integer			l_n_Level
TreeViewItem	l_tvi_Current
long           l_n_rows

// Determine the level
tv_query.GetItem(handle, l_tvi_Current)
l_n_Level = l_tvi_Current.Level

if l_n_level > 2 then 
	return
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

if l_n_level < 3 then 
	pb_excel.enabled = false
end if
end event

type pb_find_itno from picturebutton within w_rtn031i
integer x = 1513
integer y = 152
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
string picturename = "C:\kdac\bmp\search.gif"
alignment htextalign = left!
end type

event clicked;if rb_item.checked = true then
	uo_status.st_message.text = ""
	string l_s_parm
	l_s_parm    = uo_1.uf_Return()
	i_s_plant   = mid(l_s_parm,1,1)
	i_s_div     = mid(l_s_parm,2,1)
	i_s_pdcd    = mid(l_s_parm,3,2)

	if f_spacechk(i_s_pdcd) = -1 then
		uo_status.st_message.text = "제품군을 선택해 주십시요"
		return 0
	end if
	l_s_parm = g_s_date + i_s_plant + i_s_div + i_s_pdcd
	
	openwithparm(w_rtn_find_item,l_s_parm)
	
	l_s_parm = message.stringparm
	
	sle_inputnm.text = l_s_parm
//elseif rb_line.checked = true then
//	openwithparm(w_rtng102u_res02 , '  ')
//	l_s_parm = message.stringparm
//	if f_spacechk(l_s_parm) <> -1 then
//	   st_nm.text = ''
//	   st_nm.text = mid(l_s_parm,1,30)
//	   sle_inputnm.text = trim(mid(l_s_parm,31,5))
//	end if
//else
//	uo_status.st_message.text = "품번 또는 대체 Line을 선택해 주십시요"
end if

return 0
end event

type dw_rtninfo from datawindow within w_rtn031i
integer x = 686
integer y = 296
integer width = 3909
integer height = 2180
integer taborder = 140
boolean bringtotop = true
string title = "none"
string dataobject = "d_rtn031i_detail_rtninfo"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;//string ls_plant,ls_div,ls_itno,ls_line,ls_opno
//long   ll_rowcnt,ll_rowcnt1,ll_rowcnt2
integer li_rowcnt
//
this.selectrow(0, false)
li_rowcnt = this.rowcount()
if row > 0 and row <= li_rowcnt then
	this.selectrow(row,true)
else
	return 0
end if
//
//dw_mcnoinfo.reset()
//dw_secjobinfo.reset()
//uo_status.st_message.text = ""
//
//
//ls_line   = trim(dw_rtninfo.object.rcline1[row]) + dw_rtninfo.object.rcline2[row]
//ls_plant  = dw_rtninfo.object.rcplant[row]
//ls_div    = dw_rtninfo.object.rcdvsn[row]
//ls_itno   = dw_rtninfo.object.rcitno[row]
//ls_opno   = dw_rtninfo.object.rcopno[row]
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
//
//
//
//return 0
end event

type st_nm from statictext within w_rtn031i
integer x = 1787
integer y = 168
integer width = 1417
integer height = 80
integer taborder = 90
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

type st_3 from statictext within w_rtn031i
integer x = 2565
integer y = 40
integer width = 242
integer height = 60
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

type em_date from editmask within w_rtn031i
event ue_keydown pbm_keydown
integer x = 2789
integer y = 28
integer width = 457
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
long backcolor = 15793151
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "XXXX.XX.XX"
boolean autoskip = true
end type

event ue_keydown;//if key = keyenter! then
//	parent.triggerevent("ue_retrieve")
//end if
end event

type uo_1 from uo_plandiv_pdcd within w_rtn031i
integer x = 59
integer y = 4
integer taborder = 20
boolean bringtotop = true
end type

on uo_1.destroy
call uo_plandiv_pdcd::destroy
end on

type pb_excel from picturebutton within w_rtn031i
integer x = 4256
integer y = 144
integer width = 343
integer height = 132
integer taborder = 80
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "C:\kdac\bmp\Excel.bmp"
alignment htextalign = left!
end type

event clicked;f_save_to_excel(dw_rtninfo)
end event

type cb_rtn015_template from commandbutton within w_rtn031i
integer x = 3301
integer y = 24
integer width = 901
integer height = 88
integer taborder = 100
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "기본정보 업로드용 템플릿"
end type

event clicked;string ls_plant, ls_dvsn, ls_itno, ls_line1, ls_line2
long ll_rowcnt

ll_rowcnt = dw_rtninfo.rowcount()
if ll_rowcnt < 1 then
	uo_status.st_message.text = "조회된 공정정보가 없습니다."
	return -1
end if

dw_down.dataobject = "d_rtn031i_rtn015_template"
dw_down.settransobject(sqlca)

ls_plant = dw_rtninfo.getitemstring(1,"replant")
ls_dvsn = dw_rtninfo.getitemstring(1,"redvsn")
ls_itno = dw_rtninfo.getitemstring(1,"reitno")
ls_line1 = dw_rtninfo.getitemstring(1,"reline1")
ls_line2 = dw_rtninfo.getitemstring(1,"reline2")
ll_rowcnt = dw_down.retrieve(g_s_company, ls_plant, ls_dvsn, ls_itno, ls_line1, ls_line2, i_s_ajdate )
if ll_rowcnt > 0 then
	f_save_to_excel_number(dw_down)
else
	uo_status.st_message.text = "다운로드할 자료가 없습니다."
end if

return 0
end event

type cb_rtn016_template from commandbutton within w_rtn031i
integer x = 3301
integer y = 140
integer width = 901
integer height = 92
integer taborder = 110
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "부대작업 업로드용 템플릿"
end type

event clicked;string ls_plant, ls_dvsn, ls_itno, ls_line1, ls_line2
long ll_rowcnt

ll_rowcnt = dw_rtninfo.rowcount()
if ll_rowcnt < 1 then
	uo_status.st_message.text = "조회된 공정정보가 없습니다."
	return -1
end if

dw_down.dataobject = "d_rtn031i_rtn016_template"
dw_down.settransobject(sqlca)

ls_plant = dw_rtninfo.getitemstring(1,"replant")
ls_dvsn = dw_rtninfo.getitemstring(1,"redvsn")
ls_itno = dw_rtninfo.getitemstring(1,"reitno")
ls_line1 = dw_rtninfo.getitemstring(1,"reline1")
ls_line2 = dw_rtninfo.getitemstring(1,"reline2")
ll_rowcnt = dw_down.retrieve(g_s_company, ls_plant, ls_dvsn, ls_itno, ls_line1, ls_line2, i_s_ajdate )
if ll_rowcnt > 0 then
	f_save_to_excel_number(dw_down)
else
	uo_status.st_message.text = "다운로드할 자료가 없습니다."
end if

return 0
end event

type dw_down from datawindow within w_rtn031i
boolean visible = false
integer x = 3465
integer y = 256
integer width = 686
integer height = 400
integer taborder = 120
boolean bringtotop = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type gb_1 from groupbox within w_rtn031i
integer x = 27
integer y = 108
integer width = 3237
integer height = 168
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
end type

