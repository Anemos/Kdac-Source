$PBExportHeader$w_select_inifile.srw
$PBExportComments$INI File Select
forward
global type w_select_inifile from window
end type
type st_16 from statictext within w_select_inifile
end type
type st_15 from statictext within w_select_inifile
end type
type st_14 from statictext within w_select_inifile
end type
type st_7 from statictext within w_select_inifile
end type
type st_6 from statictext within w_select_inifile
end type
type cb_browse from commandbutton within w_select_inifile
end type
type cb_ok from commandbutton within w_select_inifile
end type
type st_5 from statictext within w_select_inifile
end type
type st_4 from statictext within w_select_inifile
end type
type st_3 from statictext within w_select_inifile
end type
type st_2 from statictext within w_select_inifile
end type
type st_1 from statictext within w_select_inifile
end type
type cb_cancel from commandbutton within w_select_inifile
end type
type gb_1 from groupbox within w_select_inifile
end type
type sle_file from singlelineedit within w_select_inifile
end type
type st_9 from statictext within w_select_inifile
end type
type st_8 from statictext within w_select_inifile
end type
type st_11 from statictext within w_select_inifile
end type
type st_10 from statictext within w_select_inifile
end type
type st_13 from statictext within w_select_inifile
end type
type st_12 from statictext within w_select_inifile
end type
end forward

global type w_select_inifile from window
integer x = 823
integer y = 360
integer width = 2240
integer height = 1388
boolean titlebar = true
string title = "Select a parameter file"
boolean controlmenu = true
boolean minbox = true
long backcolor = 79741120
event ue_postopen ( )
st_16 st_16
st_15 st_15
st_14 st_14
st_7 st_7
st_6 st_6
cb_browse cb_browse
cb_ok cb_ok
st_5 st_5
st_4 st_4
st_3 st_3
st_2 st_2
st_1 st_1
cb_cancel cb_cancel
gb_1 gb_1
sle_file sle_file
st_9 st_9
st_8 st_8
st_11 st_11
st_10 st_10
st_13 st_13
st_12 st_12
end type
global w_select_inifile w_select_inifile

type variables

end variables

forward prototypes
public function boolean wf_connect ()
end prototypes

event ue_postopen;
cb_ok.PostEvent(clicked!)
end event

public function boolean wf_connect ();//SQLCA.DBMS       =ProfileString(gs_ini_file, "Database", "DBMS",             "X") - IPIS
SQLCA.DBMS       =ProfileString(gs_ini_file, "MIS", "DBMS",             "X")
	
If SQLCA.DBMS = "X" Then
	MessageBox("Cannot find sfc.ini","The '.ini' file used by the SFC was not found."+&
				  "Please ensure that it is in the same directory as the System "+&
				  "libraries and that this is your current directory.",StopSign!)
	Return False
End if
	
SQLCA.Database   	= ProfileString(gs_ini_file, "MIS", "DataBase",         " ")
SQLCA.LogID      	= ProfileString(gs_ini_file, "MIS", "LogID",            " ")
SQLCA.LogPass    	= ProfileString(gs_ini_file, "MIS", "LogPassword",      " ")
SQLCA.ServerName 	= ProfileString(gs_ini_file, "MIS", "ServerName",       " ")
SQLCA.UserID     	= ProfileString(gs_ini_file, "MIS", "UserID",           " ")
SQLCA.DBPass     	= ProfileString(gs_ini_file, "MIS", "DatabasePassword", " ")
SQLCA.Lock       	= ProfileString(gs_ini_file, "MIS", "Lock",             " ")
SQLCA.DbParm     	= ProfileString(gs_ini_file, "MIS", "DbParm",           " ")
SQLCA.AutoCommit	= True

Connect;
	
If sqlca.Sqlcode = 0 Then
	Return True
Else
	MessageBox("SQL Error : " + String(SQLCA.SQLCODE),SQLCA.SQLErrText, StopSign!)
	Return False
End If
end function

on w_select_inifile.create
this.st_16=create st_16
this.st_15=create st_15
this.st_14=create st_14
this.st_7=create st_7
this.st_6=create st_6
this.cb_browse=create cb_browse
this.cb_ok=create cb_ok
this.st_5=create st_5
this.st_4=create st_4
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.cb_cancel=create cb_cancel
this.gb_1=create gb_1
this.sle_file=create sle_file
this.st_9=create st_9
this.st_8=create st_8
this.st_11=create st_11
this.st_10=create st_10
this.st_13=create st_13
this.st_12=create st_12
this.Control[]={this.st_16,&
this.st_15,&
this.st_14,&
this.st_7,&
this.st_6,&
this.cb_browse,&
this.cb_ok,&
this.st_5,&
this.st_4,&
this.st_3,&
this.st_2,&
this.st_1,&
this.cb_cancel,&
this.gb_1,&
this.sle_file,&
this.st_9,&
this.st_8,&
this.st_11,&
this.st_10,&
this.st_13,&
this.st_12}
end on

on w_select_inifile.destroy
destroy(this.st_16)
destroy(this.st_15)
destroy(this.st_14)
destroy(this.st_7)
destroy(this.st_6)
destroy(this.cb_browse)
destroy(this.cb_ok)
destroy(this.st_5)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.cb_cancel)
destroy(this.gb_1)
destroy(this.sle_file)
destroy(this.st_9)
destroy(this.st_8)
destroy(this.st_11)
destroy(this.st_10)
destroy(this.st_13)
destroy(this.st_12)
end on

event open;Int li_filenum

SetPointer(HourGlass!)
This.visible = False
f_win_center_move(This)

If FileExists('interface_parameter') Then
	li_filenum = FileOpen('interface_parameter', LineMode!, Read!, LockReadWrite!, Append!)
	FileRead(li_filenum, gs_ini_file)
	gs_ini_file = Trim(gs_ini_file)
	FileClose(li_filenum)
	sle_file.text = gs_ini_file
	sle_file.SetFocus()
	sle_file.SelectText(1, Len(sle_file.Text))
	This.PostEvent('ue_postopen')
Else
	Halt
End If
end event

type st_16 from statictext within w_select_inifile
integer x = 133
integer y = 1184
integer width = 1545
integer height = 56
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 33554432
long backcolor = 16777215
boolean enabled = false
string text = "................"
boolean focusrectangle = false
end type

type st_15 from statictext within w_select_inifile
integer x = 133
integer y = 996
integer width = 1545
integer height = 56
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 33554432
long backcolor = 16777215
boolean enabled = false
string text = "................"
boolean focusrectangle = false
end type

type st_14 from statictext within w_select_inifile
integer x = 133
integer y = 804
integer width = 1545
integer height = 56
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 33554432
long backcolor = 16777215
boolean enabled = false
string text = "................"
boolean focusrectangle = false
end type

type st_7 from statictext within w_select_inifile
integer x = 64
integer y = 616
integer width = 430
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 255
long backcolor = 16777215
boolean enabled = false
string text = "INI File Sample"
boolean focusrectangle = false
end type

type st_6 from statictext within w_select_inifile
integer x = 27
integer y = 600
integer width = 1888
integer height = 660
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 33554432
long backcolor = 16777215
boolean enabled = false
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type cb_browse from commandbutton within w_select_inifile
integer x = 1595
integer y = 432
integer width = 270
integer height = 96
integer taborder = 40
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
string text = "&Browse"
end type

event clicked;String	ls_Path, ls_File, ls_Type, ls_Mask

ls_Type = "*.ini"
ls_Mask = " INI Files (*.ini), *.INI, ALL Files (*.*), *.*"

If GetFileOpenName("Select a File", ls_Path, ls_file, ls_Type, ls_Mask) = 1 Then
	sle_file.Text = ls_Path
End If
end event

type cb_ok from commandbutton within w_select_inifile
integer x = 1934
integer y = 44
integer width = 265
integer height = 108
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
string text = "&OK"
boolean default = true
end type

event clicked;int li_filenum

gs_ini_file = Trim(sle_file.Text)

If Len(gs_ini_file) > 0 Then
	If FileExists(gs_ini_file) Then
		If wf_connect() Then
			li_filenum = FileOpen('interface_parameter', LineMode!, Write!, LockReadWrite!, Replace!)
			FileWrite(li_filenum, gs_ini_file)
			FileClose(li_filenum)
			Open(w_wip_run)
		Else
			Halt Close
			Return
		End If
	Else
		MessageBox("File Not Exist", "입력한 " + gs_ini_file + " File이 존재하지 않습니다.~r~n정확하게 확인 입력하세요.")
		sle_file.SetFocus()
		sle_file.SelectText(1, Len(sle_file.Text))
	End If
Else
	MessageBox("Invalid FileName", "INI File을 입력하지 않으면 시스템을 시작할수 없습니다.~r~n정확하게 확인 입력하세요.")
	sle_file.SetFocus()
End If
end event

type st_5 from statictext within w_select_inifile
integer x = 82
integer y = 348
integer width = 462
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 8388608
long backcolor = 67108864
boolean enabled = false
string text = "Parameter File :"
boolean focusrectangle = false
end type

type st_4 from statictext within w_select_inifile
integer x = 78
integer y = 424
integer width = 1513
integer height = 112
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 33554432
long backcolor = 8421376
boolean enabled = false
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_3 from statictext within w_select_inifile
integer x = 398
integer y = 268
integer width = 1353
integer height = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 255
long backcolor = 67108864
boolean enabled = false
string text = "위 두가지 Parameter를 설정한 INI File을 선택하세요."
boolean focusrectangle = false
end type

type st_2 from statictext within w_select_inifile
integer x = 73
integer y = 184
integer width = 1669
integer height = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "2. Interface를 위한 Source 및 Destination의 Connect Parameter ."
boolean focusrectangle = false
end type

type st_1 from statictext within w_select_inifile
integer x = 73
integer y = 112
integer width = 1669
integer height = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "1. Interface 관련 정보를 조회하기 위한 Connect Parameter."
boolean focusrectangle = false
end type

type cb_cancel from commandbutton within w_select_inifile
integer x = 1934
integer y = 168
integer width = 265
integer height = 108
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
string text = "&Cancel"
boolean cancel = true
end type

event clicked;Close(Parent)
end event

type gb_1 from groupbox within w_select_inifile
integer x = 27
integer y = 20
integer width = 1888
integer height = 556
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 33554432
long backcolor = 67108864
string text = " Select Parameter File "
end type

type sle_file from singlelineedit within w_select_inifile
integer x = 87
integer y = 448
integer width = 1495
integer height = 80
integer taborder = 10
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 16777215
long backcolor = 8421376
boolean border = false
boolean autohscroll = false
end type

type st_9 from statictext within w_select_inifile
integer x = 133
integer y = 768
integer width = 1545
integer height = 56
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 33554432
long backcolor = 16777215
boolean enabled = false
string text = "DBMS=MSS Microsoft SQL Server"
boolean focusrectangle = false
end type

type st_8 from statictext within w_select_inifile
integer x = 133
integer y = 704
integer width = 1545
integer height = 56
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 33554432
long backcolor = 16777215
boolean enabled = false
string text = "[DataBase]"
boolean focusrectangle = false
end type

type st_11 from statictext within w_select_inifile
integer x = 133
integer y = 960
integer width = 1545
integer height = 56
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 33554432
long backcolor = 16777215
boolean enabled = false
string text = "DBMS=ODBC"
boolean focusrectangle = false
end type

type st_10 from statictext within w_select_inifile
integer x = 133
integer y = 896
integer width = 1545
integer height = 56
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 33554432
long backcolor = 16777215
boolean enabled = false
string text = "[Source]"
boolean focusrectangle = false
end type

type st_13 from statictext within w_select_inifile
integer x = 133
integer y = 1148
integer width = 1545
integer height = 56
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 33554432
long backcolor = 16777215
boolean enabled = false
string text = "DBMS=MSS Microsoft SQL Server"
boolean focusrectangle = false
end type

type st_12 from statictext within w_select_inifile
integer x = 133
integer y = 1084
integer width = 1545
integer height = 56
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 33554432
long backcolor = 16777215
boolean enabled = false
string text = "[Destination]"
boolean focusrectangle = false
end type

