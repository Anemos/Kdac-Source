$PBExportHeader$w_preview3.srw
$PBExportComments$프린트 프리뷰(rowscopy)
forward
global type w_preview3 from w_print_sheet
end type
end forward

global type w_preview3 from w_print_sheet
string title = "출력"
end type
global w_preview3 w_preview3

type variables
datawindowchild dw1, dw2
boolean	 ib_new_fg,ib_width
int	ii_size = 1
end variables

forward prototypes
public subroutine wf_set_position ()
end prototypes

public subroutine wf_set_position ();dw_1.setredraw(false)
//가로
If dw_1.object.datawindow.print.orientation = '1' Then		
	// set report orientation landscape
	dw_1.Modify("datawindow.Print.Orientation = 1");
	Choose Case ii_size
		Case 1
			dw_1.Modify("DataWindow.Print.Paper.Size='9'")
			dw_1.Modify("title.Width='4900'")			//제목 가로길이
			dw_1.Modify("page.Width='4900'")				//Page 가로길이
		Case 2
			dw_1.Modify("DataWindow.Print.Paper.Size='12'")
			dw_1.Modify("title.Width='6500'")			//제목 가로길이
			dw_1.Modify("page.Width='6500'")				//Page 가로길이
	End Choose		
//세로
Else
	// set report orientation landscape
	dw_1.Modify("datawindow.Print.Orientation = 2");
	Choose Case ii_size
		Case 1
			dw_1.Modify("DataWindow.Print.Paper.Size='9'")
			dw_1.Modify("title.Width='3400'")			//제목 가로길이
			dw_1.Modify("page.Width='3400'")				//Page 가로길이
		Case 2
			dw_1.Modify("DataWindow.Print.Paper.Size='12'")
			dw_1.Modify("title.Width='5000'")			//제목 가로길이
			dw_1.Modify("page.Width='5000'")				//Page 가로길이
	End Choose		
end if
dw_1.setredraw(true)

end subroutine

on w_preview3.create
int iCurrent
call super::create
end on

on w_preview3.destroy
call super::destroy
end on

event ue_postopen;////////////////////////////////////////////////////
//         Open Event (w_print_preview)           //
//                     for                        //
// get message, get dataobject, get window title  //
//      set transaction object, retrieve DW       //
//                                                //
////////////////////////////////////////////////////

string  ls_max_row, ls_arg[10],ls_orient,ls_col_nm,ls_mod
int i,n, li_colnbr, li_height

datawindow ldw_temp
datawindowchild ldwc_head
str_parm   lstr_parm

dw_1.setredraw(false)

// get message parameter 
lstr_parm = message.PowerObjectParm
ib_new_fg =  lstr_parm.check 
//Preview datawindow
ldw_temp = lstr_parm.dw_parm[1]
//용지 방향
ls_orient = ldw_temp.Describe("DataWindow.Print.Orientation")
//기본 Printer 표시
//st_printer.text = ldw_temp.Object.DataWindow.Printer

IF ib_new_fg = true Then
	this.title = trim(lstr_parm.s_parm[2])		// set window title
	dw_1.dataobject = 'd_print_compo'
	dw_1.settransobject(sqlcmms);
	dw_1.object.title.text = trim(lstr_parm.s_parm[1])	//제목
	dw_1.object.win_id.text = ldw_temp.dataobject		//Dataobject표시
	dw_1.Object.d_1.Dataobject = ldw_temp.dataobject

	dw_1.getchild('d_1',dw1)
	dw_1.getchild('d_2',dw2)

	dw1.settransobject(sqlcmms);
	dw2.settransobject(sqlcmms);

	//window에 있던 dw의 내용을 preview화면으로 copy
	ldw_temp.sharedata(dw1)
	dw1.groupcalc()
	//dw1의 색을 흰색으로
	dw1.Modify("DataWindow.BackgroundColor = 16777215")
	li_ColNbr = integer(dw1.Describe("DataWindow.Column.Count"))
	//Column 의 Color가 Transparent가 아닌 경우 강제로 흰색으로 조정
	For i = 1 To li_ColNbr
		ls_col_nm = dw1.Describe("#" + string(i) + ".Name")
		ls_mod = dw1.Describe("#" + string(i) + ".Background.Mode")
		string ls_type
		ls_type = dw1.Describe(ls_col_nm + ".DDDW.Name")
		If ls_mod <> '1' and ls_type = '?' Then
			ls_mod = ls_col_nm + ".Background.Color = 16777215"
			dw1.Modify(ls_mod)
		End if
	Next

	//head부분
	dw2.reset();
	//argument명과 그 값
	n = UpperBound(lstr_parm.s_parm[]) - 1
	//Head Height
	li_height = 400 + n * 90
	ls_mod = "DataWindow.Header.Height=" + "'" + string(li_height) + "'"
	dw_1.Modify(ls_mod)

	for i = 1 to n Step 1
		dw2.insertrow(0)
		dw2.setitem(i,'a_data',trim(lstr_parm.s_parm[i +1]))
	next
Else
	this.title = trim(lstr_parm.s_parm[1])  // set window title
	dw_1.dataobject = ldw_temp.dataobject
	dw_1.settransobject(sqlcmms);
	//window에 있던 dw의 내용을 preview화면으로 copy
	ldw_temp.RowsCopy(1,ldw_temp.RowCount(), Primary!, dw_1, 1, Primary!)
	dw_1.groupcalc()
End if

dw_1.Modify('datawindow.Print.Preview = Yes');   // set preview mode
//Title
wf_set_position()
dw_1.setredraw(true)

end event

event ue_print;call super::ue_print;str_print lstr_print

lstr_print = message.Powerobjectparm
If lstr_print.s_success = '0' Then    // Print flag
	wf_set_position()
End if
end event

event close;call super::close;dw1.sharedataoff();
end event

type uo_status from w_print_sheet`uo_status within w_preview3
end type

type dw_1 from w_print_sheet`dw_1 within w_preview3
integer y = 0
integer height = 1900
end type

