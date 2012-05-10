$PBExportHeader$w_seq117i.srw
$PBExportComments$납품표발행(DPI)
forward
global type w_seq117i from w_origin_sheet09
end type
type uo_3 from u_pisc_date_applydate within w_seq117i
end type
type st_2 from statictext within w_seq117i
end type
type uo_4 from u_pisc_date_applydate_1 within w_seq117i
end type
type dw_2 from datawindow within w_seq117i
end type
type cb_print from commandbutton within w_seq117i
end type
type dw_print from datawindow within w_seq117i
end type
type pb_excel from picturebutton within w_seq117i
end type
type st_1 from statictext within w_seq117i
end type
type uo_1 from u_pisc_date_applydate_1 within w_seq117i
end type
type st_3 from statictext within w_seq117i
end type
type gb_1 from groupbox within w_seq117i
end type
end forward

global type w_seq117i from w_origin_sheet09
integer height = 2724
string title = "납품표발행(DPI)"
uo_3 uo_3
st_2 st_2
uo_4 uo_4
dw_2 dw_2
cb_print cb_print
dw_print dw_print
pb_excel pb_excel
st_1 st_1
uo_1 uo_1
st_3 st_3
gb_1 gb_1
end type
global w_seq117i w_seq117i

type variables
string is_areacode,is_divisioncode,is_shipdate,is_shipdate1,is_printdate

end variables
on w_seq117i.create
int iCurrent
call super::create
this.uo_3=create uo_3
this.st_2=create st_2
this.uo_4=create uo_4
this.dw_2=create dw_2
this.cb_print=create cb_print
this.dw_print=create dw_print
this.pb_excel=create pb_excel
this.st_1=create st_1
this.uo_1=create uo_1
this.st_3=create st_3
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_3
this.Control[iCurrent+2]=this.st_2
this.Control[iCurrent+3]=this.uo_4
this.Control[iCurrent+4]=this.dw_2
this.Control[iCurrent+5]=this.cb_print
this.Control[iCurrent+6]=this.dw_print
this.Control[iCurrent+7]=this.pb_excel
this.Control[iCurrent+8]=this.st_1
this.Control[iCurrent+9]=this.uo_1
this.Control[iCurrent+10]=this.st_3
this.Control[iCurrent+11]=this.gb_1
end on

on w_seq117i.destroy
call super::destroy
destroy(this.uo_3)
destroy(this.st_2)
destroy(this.uo_4)
destroy(this.dw_2)
destroy(this.cb_print)
destroy(this.dw_print)
destroy(this.pb_excel)
destroy(this.st_1)
destroy(this.uo_1)
destroy(this.st_3)
destroy(this.gb_1)
end on

event ue_retrieve;call super::ue_retrieve;setpointer(hourglass!)
string ls_shipdate,ls_shipdate1

dw_2.reset()

ls_shipdate 	= mid(is_shipdate,1,4) 	+ mid(is_shipdate,6,2) 	+ mid(is_shipdate,9,2)
ls_shipdate1 	= mid(is_shipdate1,1,4) + mid(is_shipdate1,6,2) + mid(is_shipdate1,9,2)
if dw_2.retrieve("L10502",ls_shipdate,ls_shipdate1) > 0 then
	uo_status.st_message.text = "  " + string(dw_2.rowcount()) + " 건의 정보가 조회되었습니다"
	cb_print.enabled = true
else
	uo_status.st_message.text = '조회할 정보가 없습니다'
	cb_print.enabled = false
end if

end event

event activate;call super::activate;dw_print.settransobject(sqlpis)
dw_2.settransobject(sqlca)
end event

event open;call super::open;long ln_position
string ls_ipaddr,ls_database,ls_logpass,ls_computer
disconnect using sqlpis ;
ln_position = lastpos(g_s_ipaddr,'.')
ls_ipaddr   = mid(g_s_ipaddr,1,ln_position - 1)
ls_ipaddr   = ProfileString(gs_inifile,"IPADDR",ls_ipaddr," ")
if ls_ipaddr <> 'KUN' and ls_ipaddr <> 'BUP' then
	close(this)
end if
RegistryGet("HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\VxD\VNETSUP", "ComputerName", ls_computer)
ls_database    		= trim(ProfileString(gs_inifile,ls_ipaddr,"DataBase",			" "))
ls_logpass     		= trim(ProfileString(gs_inifile,ls_ipaddr,"LogPass",		" "))
gs_servername	 		= ProfileString(gs_inifile,ls_ipaddr,"ServerName",	" ")
SQLPIS.ServerName 	= gs_servername
SQLPIS.DBMS       	= ProfileString(gs_inifile,ls_ipaddr,"DBMS",			" ")
SQLPIS.Database   	= ls_database
SQLPIS.LogID      	= ProfileString(gs_inifile,ls_ipaddr,"LogId",			" ")
SQLPIS.LogPass    	= ls_logpass
SQLPIS.DbParm     	= "appname='IPIS for KDAC', host='" + ls_computer + "'"
SQLPIS.AutoCommit 	= True
gs_appname	    		= ProfileString(gs_inifile,"PARAMETER","AppName",            " ")
connect using sqlpis;
 

end event

type uo_status from w_origin_sheet09`uo_status within w_seq117i
end type

type uo_3 from u_pisc_date_applydate within w_seq117i
integer x = 256
integer y = 80
integer taborder = 90
boolean bringtotop = true
end type

event constructor;call super::constructor;is_shipdate = is_uo_date
dw_2.reset()
end event

event ue_losefocus;call super::ue_losefocus;//is_shipdate = is_uo_date
end event

event ue_select;if is_shipdate <> is_uo_date then
	dw_2.reset()
end if	
is_shipdate = is_uo_date

end event

on uo_3.destroy
call u_pisc_date_applydate::destroy
end on

type st_2 from statictext within w_seq117i
integer x = 923
integer y = 88
integer width = 105
integer height = 48
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
string text = "~~"
alignment alignment = center!
boolean focusrectangle = false
end type

type uo_4 from u_pisc_date_applydate_1 within w_seq117i
event destroy ( )
integer x = 1033
integer y = 80
integer taborder = 100
boolean bringtotop = true
end type

on uo_4.destroy
call u_pisc_date_applydate_1::destroy
end on

event ue_select;call super::ue_select;is_shipdate1 = is_uo_date
dw_2.reset()
end event

event constructor;call super::constructor;is_shipdate1 = is_uo_date
dw_2.reset()
end event
type dw_2 from datawindow within w_seq117i
integer x = 78
integer y = 196
integer width = 3849
integer height = 2256
integer taborder = 30
boolean bringtotop = true
string title = "none"
string dataobject = "d_seq_deliver_retrieve"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event retrieveend;setpointer(hourglass!)
string ls_citno 
long   i,ln_scanqty 
for i = 1 to rowcount
	ls_citno = this.object.citno[i]
	SELECT isnull(sum(TSEQSTOCK.inQty),0) into :ln_scanqty
		FROM TSEQSTOCK  
	WHERE TSEQSTOCK.CustomerItemCode = :ls_citno and  
			( TSEQSTOCK.Createdate between :is_shipdate and :is_shipdate1 ) and
			( TSEQSTOCK.partid =  'DPI' )   
	using sqlpis ;
	this.object.scanqty[i] 	= ln_scanqty
next
 
end event

type cb_print from commandbutton within w_seq117i
integer x = 3237
integer y = 64
integer width = 411
integer height = 100
integer taborder = 110
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
boolean enabled = false
string text = "납품표발행"
boolean default = true
end type

event clicked;integer ln_rowcount,ln_mode,i
integer ln_shipqty[5] = {0,0,0,0,0}
string ls_itemcode[5] = {'','','','',''}

ln_rowcount  = dw_2.rowcount()
for i = 1 to ln_rowcount
	ln_mode = mod(i,5)
	if ln_mode = 0 then
		ln_mode = 5
	end if
	ls_itemcode[ln_mode] = dw_2.object.citno[i]
	ln_shipqty[ln_mode] 	= dw_2.object.shipqty[i]
	if ln_mode = 5 or i 	= ln_rowcount then
		dw_print.reset()
		dw_print.retrieve(ls_itemcode[1],ls_itemcode[2],ls_itemcode[3],ls_itemcode[4],ls_itemcode[5],is_shipdate,is_printdate,&
								ln_shipqty[1],ln_shipqty[2],ln_shipqty[3],ln_shipqty[4],ln_shipqty[5])
		dw_print.print()
		ls_itemcode[1] = ''
		ls_itemcode[2] = ''
		ls_itemcode[3] = ''
		ls_itemcode[4] = ''
		ls_itemcode[5] = ''	
		ln_shipqty[1] 	= 0
		ln_shipqty[2] 	= 0
		ln_shipqty[3] 	= 0
		ln_shipqty[4] 	= 0
		ln_shipqty[5] 	= 0
	end if
next




end event
type dw_print from datawindow within w_seq117i
boolean visible = false
integer x = 283
integer y = 300
integer width = 3383
integer height = 1720
integer taborder = 40
boolean bringtotop = true
boolean enabled = false
string title = "none"
string dataobject = "d_seq_deliver_03"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type pb_excel from picturebutton within w_seq117i
integer x = 3739
integer y = 44
integer width = 155
integer height = 132
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string picturename = "C:\KDAC\bmp\Excel.bmp"
alignment htextalign = left!
end type

event clicked;f_save_to_excel(dw_2)



end event

type st_1 from statictext within w_seq117i
integer x = 114
integer y = 88
integer width = 142
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
string text = "납품"
boolean focusrectangle = false
end type

type uo_1 from u_pisc_date_applydate_1 within w_seq117i
integer x = 2779
integer y = 80
integer taborder = 110
boolean bringtotop = true
end type

on uo_1.destroy
call u_pisc_date_applydate_1::destroy
end on

event ue_select;call super::ue_select;is_printdate = is_uo_date
end event
event constructor;call super::constructor;is_printdate = is_uo_date
end event
type st_3 from statictext within w_seq117i
integer x = 2450
integer y = 87
integer width = 329
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
string text = "발행일자 :"
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_seq117i
integer x = 78
integer width = 3598
integer height = 184
integer taborder = 60
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

