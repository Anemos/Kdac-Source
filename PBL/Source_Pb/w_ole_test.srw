$PBExportHeader$w_ole_test.srw
$PBExportComments$대체품번 등록
forward
global type w_ole_test from w_origin_sheet01
end type
type sle_input from singlelineedit within w_ole_test
end type
type st_output from statictext within w_ole_test
end type
type cb_3 from commandbutton within w_ole_test
end type
type oleobject_1 from oleobject within w_ole_test
end type
end forward

global type w_ole_test from w_origin_sheet01
integer width = 3657
integer height = 2100
string title = "대체품번등록"
boolean clientedge = true
sle_input sle_input
st_output st_output
cb_3 cb_3
oleobject_1 oleobject_1
end type
global w_ole_test w_ole_test

type variables

end variables

on w_ole_test.create
int iCurrent
call super::create
this.sle_input=create sle_input
this.st_output=create st_output
this.cb_3=create cb_3
this.oleobject_1=create oleobject_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.sle_input
this.Control[iCurrent+2]=this.st_output
this.Control[iCurrent+3]=this.cb_3
end on

on w_ole_test.destroy
call super::destroy
destroy(this.sle_input)
destroy(this.st_output)
destroy(this.cb_3)
destroy(this.oleobject_1)
end on

type uo_status from w_origin_sheet01`uo_status within w_ole_test
integer y = 1832
integer width = 3685
integer height = 92
end type

type sle_input from singlelineedit within w_ole_test
integer x = 1317
integer y = 248
integer width = 457
integer height = 92
integer taborder = 60
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "L10500"
textcase textcase = upper!
borderstyle borderstyle = stylelowered!
end type

type st_output from statictext within w_ole_test
integer x = 1861
integer y = 248
integer width = 1312
integer height = 104
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type cb_3 from commandbutton within w_ole_test
integer x = 1646
integer y = 380
integer width = 457
integer height = 124
integer taborder = 70
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "실행"
end type

event clicked;//any rcds = 0, parms,parm[2]
//long ll_status
//oleobject partsrcdcmd
//oleobject cn400
//
//setpointer(Hourglass!)
//partsrcdcmd = create oleobject
//cn400       = create oleobject
//ll_status = cn400.connecttonewobject("adodb.connection")
//messagebox("CN400 Connection",string(ll_status))
//ll_status = partsrcdcmd.connecttonewobject("adodb.command")
//messagebox("Part Connection",string(ll_status))
//
//// ll_status = cn400.open("PROVIDER=IBMDA400;DATA SOURCE=CA/400 ODBC for PB;","","")
//ll_status = cn400.open("PROVIDER=MSDASQL;dsn=as400820;uid=ca400dft;pwd=odbc2300;")
////ll_status = cn400.open("PROVIDER=IBMDA400;DSN=CA/400 ODBC for PB;UID=CASINV;PWD=DPAINV")
//IF ISNULL(LL_STATUS) = TRUE THEN
//	messagebox("Open1 Connection","NULL")
//ELSE
//	messagebox("Open2 Connection",string(ll_status))
//END IF
//
//partsrcdcmd.activeconnection = cn400
//partsrcdcmd.commandtext = " {call pbcommon.sp_samp02(?,?)}"
//partsrcdcmd.prepared = true
//
//partsrcdcmd.parameters[0].direction  = 1 
//partsrcdcmd.parameters[1].direction  = 2
//
//parm[1] = trim(sle_input.text)
//parm[2] = st_output.text
//
//parms   = parm
//
//ll_status =  partsrcdcmd.execute(rcds,parms,1)
//
//messagebox("1", string(ll_status))
//messagebox("2", string(parm[1]))
//messagebox("3", string(parm[2]))
//st_output.text = parm[2]
//
uo_transaction ll

string l_s_1
string l_s_2 

st_output.text = ''

l_s_1 = STRING(sle_input.text,'@@@@@@')
l_s_2 = STRING(st_output.text,'@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@')
ll = create uo_transaction
ll.SP_SAMP02(l_s_1,l_s_2)
st_output.text = l_s_2
destroy ll
end event

type oleobject_1 from oleobject within w_ole_test descriptor "pb_nvo" = "true" 
end type

on oleobject_1.create
call super::create
TriggerEvent( this, "constructor" )
end on

on oleobject_1.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

