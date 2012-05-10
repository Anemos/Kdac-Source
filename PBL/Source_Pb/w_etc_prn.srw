$PBExportHeader$w_etc_prn.srw
$PBExportComments$±âÅ¸ÄÚµå Ãâ·Â
forward
global type w_etc_prn from w_cmms_sheet01
end type
type st_3 from statictext within w_etc_prn
end type
type ddlb_zoom from dropdownlistbox within w_etc_prn
end type
type cbx_1 from checkbox within w_etc_prn
end type
type st_1 from statictext within w_etc_prn
end type
type pb_last from picturebutton within w_etc_prn
end type
type pb_next from picturebutton within w_etc_prn
end type
type pb_prior from picturebutton within w_etc_prn
end type
type pb_first from picturebutton within w_etc_prn
end type
type st_zoom from statictext within w_etc_prn
end type
type cb_prt2 from commandbutton within w_etc_prn
end type
type cb_close from commandbutton within w_etc_prn
end type
type dw_preview from datawindow within w_etc_prn
end type
type gb_1 from groupbox within w_etc_prn
end type
type sle_1 from uo_sle within w_etc_prn
end type
end forward

global type w_etc_prn from w_cmms_sheet01
integer x = 535
integer y = 480
integer height = 2104
string title = "±âÅ¸ÄÚµå Ãâ·Â"
event ue_postopen pbm_custom01
st_3 st_3
ddlb_zoom ddlb_zoom
cbx_1 cbx_1
st_1 st_1
pb_last pb_last
pb_next pb_next
pb_prior pb_prior
pb_first pb_first
st_zoom st_zoom
cb_prt2 cb_prt2
cb_close cb_close
dw_preview dw_preview
gb_1 gb_1
sle_1 sle_1
end type
global w_etc_prn w_etc_prn

type variables

end variables

event ue_postopen;dw_preview.settransobject(sqlcmms);
sle_1.setfocus()


end event

on w_etc_prn.create
int iCurrent
call super::create
this.st_3=create st_3
this.ddlb_zoom=create ddlb_zoom
this.cbx_1=create cbx_1
this.st_1=create st_1
this.pb_last=create pb_last
this.pb_next=create pb_next
this.pb_prior=create pb_prior
this.pb_first=create pb_first
this.st_zoom=create st_zoom
this.cb_prt2=create cb_prt2
this.cb_close=create cb_close
this.dw_preview=create dw_preview
this.gb_1=create gb_1
this.sle_1=create sle_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_3
this.Control[iCurrent+2]=this.ddlb_zoom
this.Control[iCurrent+3]=this.cbx_1
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.pb_last
this.Control[iCurrent+6]=this.pb_next
this.Control[iCurrent+7]=this.pb_prior
this.Control[iCurrent+8]=this.pb_first
this.Control[iCurrent+9]=this.st_zoom
this.Control[iCurrent+10]=this.cb_prt2
this.Control[iCurrent+11]=this.cb_close
this.Control[iCurrent+12]=this.dw_preview
this.Control[iCurrent+13]=this.gb_1
this.Control[iCurrent+14]=this.sle_1
end on

on w_etc_prn.destroy
call super::destroy
destroy(this.st_3)
destroy(this.ddlb_zoom)
destroy(this.cbx_1)
destroy(this.st_1)
destroy(this.pb_last)
destroy(this.pb_next)
destroy(this.pb_prior)
destroy(this.pb_first)
destroy(this.st_zoom)
destroy(this.cb_prt2)
destroy(this.cb_close)
destroy(this.dw_preview)
destroy(this.gb_1)
destroy(this.sle_1)
end on

event ue_retrieve;string ls_class
long ll_row

If isnull(sle_1.text) or trim(sle_1.text) = "" Then
	ls_class = ' '
Else
	ls_class = trim(sle_1.text)
End if

//setting Datawindow
dw_preview.setredraw(false)
ll_row = dw_preview.retrieve(ls_class)

If ll_row > 0 Then
	wf_message_line('Á¶È¸¿Ï·á')
Else
	wf_message_line('Á¶È¸ÀÚ·á°¡ ¾ø½À´Ï´Ù.')
End if	

dw_preview.scrolltorow(1)//set page 1
dw_preview.setredraw(true)

dw_preview.Modify('datawindow.Print.Preview = Yes');   // set preview mode


end event

type st_3 from statictext within w_etc_prn
integer x = 1915
integer y = 64
integer width = 160
integer height = 76
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "±¼¸²Ã¼"
long backcolor = 79741120
boolean enabled = false
string text = "±¸ºÐ"
boolean focusrectangle = false
end type

type ddlb_zoom from dropdownlistbox within w_etc_prn
integer x = 1051
integer y = 44
integer width = 270
integer height = 536
integer taborder = 50
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "System"
long backcolor = 16777215
string text = "100"
boolean allowedit = true
boolean sorted = false
boolean vscrollbar = true
string item[] = {"50","60","70","80","90","100","110","120","130","140","150","160","170","180","190","200"}
end type

event selectionchanged;

////////////////////////////////////////////////////
//             clicked Event (ddlb_zoom)          //
//                     for                        //
//               set zoom ratio                   //
//                                                //
//                    			                    //
////////////////////////////////////////////////////

// set zoom rate
dw_preview.Modify("datawindow.Print.Preview.zoom = " + this.text )
dw_preview.Modify("datawindow.zoom = " + this.text );
end event

type cbx_1 from checkbox within w_etc_prn
integer x = 1367
integer y = 48
integer width = 306
integer height = 88
integer taborder = 60
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "±¼¸²Ã¼"
long textcolor = 8388736
long backcolor = 79741120
string text = "´«±ÝÀÚ"
end type

event clicked;

////////////////////////////////////////////////////
//             clicked Event (cbx_1)              //
//                     for                        //
//            set ruler on/off (toggle)           //
//                                                //
//                                                //
////////////////////////////////////////////////////



if this.checked then
	dw_preview.Modify('datawindow.Print.Preview.Rulers = Yes'); // set ruler on
else
	dw_preview.Modify('datawindow.Print.Preview.Rulers = No'); // set ruler off
end if
end event

type st_1 from statictext within w_etc_prn
integer x = 37
integer y = 64
integer width = 347
integer height = 72
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "±¼¸²Ã¼"
long textcolor = 8388736
long backcolor = 79741120
boolean enabled = false
string text = "ÆäÀÌÁöÀÌµ¿"
boolean focusrectangle = false
end type

type pb_last from picturebutton within w_etc_prn
integer x = 736
integer y = 44
integer width = 114
integer height = 100
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "±¼¸²Ã¼"
boolean originalsize = true
string picturename = ".\bmp\arrowlast.bmp"
string disabledname = ".\bmp\arrowlast_dis.bmp"
alignment htextalign = left!
end type

event clicked;dw_preview.scrolltorow(100000)

end event

type pb_next from picturebutton within w_etc_prn
integer x = 622
integer y = 44
integer width = 114
integer height = 100
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "±¼¸²Ã¼"
boolean originalsize = true
string picturename = ".\bmp\arrowri.bmp"
string disabledname = ".\bmp\arrowri_dis.bmp"
alignment htextalign = left!
end type

event clicked;dw_preview.ScrollNextPage()

end event

type pb_prior from picturebutton within w_etc_prn
integer x = 503
integer y = 44
integer width = 114
integer height = 100
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "±¼¸²Ã¼"
boolean originalsize = true
string picturename = ".\bmp\arrowle.bmp"
string disabledname = ".\bmp\arrowle_dis.bmp"
alignment htextalign = left!

end type

event clicked;dw_preview.ScrollPriorPage()

end event

type pb_first from picturebutton within w_etc_prn
integer x = 384
integer y = 44
integer width = 114
integer height = 100
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "±¼¸²Ã¼"
boolean originalsize = true
string picturename = ".\bmp\arrowfirst.bmp"
string disabledname = ".\bmp\arrowfirst_dis.bmp"
alignment htextalign = left!
end type

event clicked;dw_preview.scrolltorow(1)

end event

type st_zoom from statictext within w_etc_prn
integer x = 891
integer y = 64
integer width = 242
integer height = 76
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "±¼¸²Ã¼"
long textcolor = 8388736
long backcolor = 79741120
boolean enabled = false
string text = "Zoom"
boolean focusrectangle = false
end type

type cb_prt2 from commandbutton within w_etc_prn
event clicked pbm_bnclicked
integer x = 3063
integer y = 44
integer width = 238
integer height = 104
integer taborder = 70
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "±¼¸²Ã¼"
string text = "&P ÀÎ¼â"
end type

event clicked;
long li_cur
str_print lstr_print

dw_preview.AcceptText()

//set instance variable lstr_print(structure)
lstr_print.dw_prt = dw_preview // assign DW
lstr_print.s_success = '0' // initialize success flag
lstr_print.s_document = parent.title // assign window title to document name

// open w_print and send message to w_print
openwithparm(w_set_print,lstr_print)


end event

type cb_close from commandbutton within w_etc_prn
integer x = 3305
integer y = 44
integer width = 238
integer height = 104
integer taborder = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "±¼¸²Ã¼"
string text = "&X ´Ý±â"
end type

event clicked;close(parent)
end event

type dw_preview from datawindow within w_etc_prn
integer x = 18
integer y = 184
integer width = 3552
integer height = 1828
string dataobject = "d_etc_print"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type gb_1 from groupbox within w_etc_prn
integer x = 18
integer width = 3561
integer height = 164
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "±¼¸²Ã¼"
long textcolor = 12632256
long backcolor = 77643992
borderstyle borderstyle = styleraised!
end type

type sle_1 from uo_sle within w_etc_prn
integer x = 2071
integer y = 52
integer width = 663
integer taborder = 20
boolean bringtotop = true
textcase textcase = upper!
end type

event ue_keydown;If key = keyenter! Then
	parent.triggerevent("ue_retrieve")
End if
end event

