$PBExportHeader$w_dw_saveas_user_r.srw
$PBExportComments$dw saveas 사용자 컬럼선택
forward
global type w_dw_saveas_user_r from window
end type
type cb_cancel from commandbutton within w_dw_saveas_user_r
end type
type cb_ok from commandbutton within w_dw_saveas_user_r
end type
type dw_2 from datawindow within w_dw_saveas_user_r
end type
type dw_1 from datawindow within w_dw_saveas_user_r
end type
type dw_invisible from datawindow within w_dw_saveas_user_r
end type
type rb_text from radiobutton within w_dw_saveas_user_r
end type
type rb_all from radiobutton within w_dw_saveas_user_r
end type
type mle_desc from multilineedit within w_dw_saveas_user_r
end type
type gb_1 from groupbox within w_dw_saveas_user_r
end type
type gb_2 from groupbox within w_dw_saveas_user_r
end type
type gb_3 from groupbox within w_dw_saveas_user_r
end type
end forward

global type w_dw_saveas_user_r from window
integer width = 2400
integer height = 1212
long backcolor = 80269524
cb_cancel cb_cancel
cb_ok cb_ok
dw_2 dw_2
dw_1 dw_1
dw_invisible dw_invisible
rb_text rb_text
rb_all rb_all
mle_desc mle_desc
gb_1 gb_1
gb_2 gb_2
gb_3 gb_3
end type
global w_dw_saveas_user_r w_dw_saveas_user_r

type prototypes
FUNCTION UInt FindWindowA( Ulong className, string winName )  LIBRARY "user32.dll"
FUNCTION UInt SetFocus( int winHand )  LIBRARY "user32.dll"
FUNCTION boolean DeleteFileA(ref string filename) LIBRARY "Kernel32.dll"

//FUNCTION boolean chdir(string d) LIBRARY "FUNCky32.DLL"
//SUBROUTINE _curdir(ref string d,ref string b) LIBRARY "FUNCky32.DLL"
end prototypes

type variables
Datawindow		idw_dw
Long				il_drag_row
Long				il_old_row
Long				il_drag1
Long				il_drag2
String			is_describe
String         is_flag

end variables

forward prototypes
public subroutine wf_option ()
public subroutine wf_excel ()
end prototypes

public subroutine wf_option ();If rb_text.checked = True Then
	mle_desc.text = "※ 계산형필드를 포함한 모든 Data를 SaveAs할 수 있습니다." + &
	"~r~n※ 엑셀로는 저장이 되지 않습니다." + &
	"~r~n※ *.CSV로 저장시 숫자 맨 앞의 0은 인식하지 못합니다." + &
	"~r~n 예) 00002 -> 2 로 인식"
	is_flag = "TEXT"
ElseIf rb_all.checked =true Then
	mle_desc.text = "※ 모든 Type으로 SaveAs가 가능하나 계산형 필드는 저장이 되지 않습니다." + &
	            "~r~n※ DDDW(Drop Down DataWindow)를 포함하고 있는 DataWindow는 사용자 Column지정" + &
					"~r~n   저장이 되지 않습니다.." 
	is_flag = "EXCEL"
End If

end subroutine

public subroutine wf_excel ();////변수 선언
//int object_count, object_index, object_max
//string objects, object_name, object_list[], object_select, object_band, object_type
//string detail_object_spec, detail_objects[], detail_object_labels, s_header, header_text[]
//string s_trailer1, s_trailer1_object[], s_footer, s_footer_object[], s_footer_data
//boolean object_visible, b_detail = false, b_trailer1= false, b_summury = false, b_footer = false
//int i_trailer1_count = 0, i_detail_count = 0, i_footer_count = 0
//
//
////데이터윈도우의 모든 오브젝트를 읽어온다.
//objects = dw_invisible.describe("Datawindow.Objects" )
//
//int i_pos, i, i_target, j, i_target_row, i_row = 1
//
//object_max = 1
//i_pos = 1
//
////오브젝트들을 탭을 구분으로 하나씩 분리해 저장한다.
//do while(true)
//  i_target = pos(objects, '~t', i_pos)
//if i_target = 0 then 
// object_list[object_max] = mid(objects, i_pos, len(objects))
// exit
//end if
//  object_list[object_max] = mid(objects, i_pos, i_target - i_pos)
//i_pos = i_target + 1
//object_max++
//loop
//
////각 오브젝트들이 속해 있는 밴드와 타입, visible여부를 알아내어서
////오브젝트의 갯수와 각 변수들에 저장을 한다.
//for object_index = 1 to object_max 
//object_name = trim(object_list[object_index])
//object_band = upper(dw_invisible.describe( object_name + ".band" ))
//object_type = upper(dw_invisible.describe( object_name + ".type" ))
//object_visible = dw_invisible.describe( object_name + ".visible" ) = "1" 
//  if object_visible then //보이는 오브젝트만 처리
// choose case object_band
//  case "TRAILER.1" //그룹밴드
//   b_trailer1 = true
//   if (object_type = "COLUMN" or object_type = "COMPUTE" or object_type = "TEXT") then
//          i_trailer1_count++
//              s_trailer1_object[i_trailer1_count] = object_name
//   end if
//  case "DETAIL" //Detail 밴드
//           if (object_type = "COLUMN" or object_type = "COMPUTE") then
//              object_select = object_select + "/" + object_name
//      i_detail_count++         
//         end if
//  case "FOOTER" //Footer 밴드
//   b_footer = true
//   if (object_type = "COLUMN" or object_type = "COMPUTE" or object_type = "TEXT") then
//          i_footer_count++
//              s_footer_object[i_footer_count] = object_name
//   end if
//   end choose
//  end if
//next
//
//i_target = 0 ; i_pos = 1 ; object_max = 1
//
//dw_invisible.SetRedraw(false)
////컬럼의 순서를 알아내기 위한 작업을 한다.
//object_select = '1/1' + object_select
//dw_invisible.modify("datawindow.selected= '" + object_select + "'")
//
//object_select = dw_invisible.describe("datawindow.selected")
//
//detail_object_spec = right(object_select, len(object_select) - 4)
//
//detail_object_spec = detail_object_spec + '/'
//dw_invisible.modify(" datawindow.selected=''")
//dw_invisible.SetRedraw(true)
//
//
//i_pos = 1
//object_max = 1
//
////각 컬럼의 이름을 배치된 순서대로 다시 저장한다.
//do while(true)
//  i_target = pos(detail_object_spec, '/', i_pos)
//if i_target = 0 then 
// detail_objects[object_max] = mid(detail_object_spec,i_pos, len(detail_object_spec))
// exit
//end if
//  detail_objects[object_max] = mid(detail_object_spec,i_pos, i_target - i_pos)
//i_pos = i_target + 1
//object_max++
//loop
//
////헤드에 있는 텍스트들의 text값을 저장한다.
////for object_index = 1 to object_max 
////object_name = detail_objects[object_index]
////if detail_object_labels <> '' then detail_object_labels = detail_object_labels + '~t'
//// if dw_invisible.describe( object_name + "_s_f.visible" ) <> '!' then
////  detail_object_labels = detail_object_labels + dw_invisible.describe(object_name + "_s_f.text")
//// else 
////    detail_object_labels = detail_object_labels + "?"
//// end if
////next
//////요기까지 detail 밴드의 화면상에 보이는 컬럼들만 detail_objects에 담는다.
//
////========
//for object_index = 1 to object_max 
//object_name = detail_objects[object_index]
//if detail_object_labels <> '' then detail_object_labels = detail_object_labels + '~t'
// if dw_invisible.describe( object_name + "_s_f.visible" ) <> '!' then
//  detail_object_labels = detail_object_labels + dw_invisible.describe(object_name + "_s_f.text")
//elseif dw_invisible.describe( object_name + "_s.visible" ) <> '!' then
//  detail_object_labels = detail_object_labels + dw_invisible.describe(object_name + "_s.text")
//elseif dw_invisible.describe( object_name + "_f.visible" ) <> '!' then
//  detail_object_labels = detail_object_labels + dw_invisible.describe(object_name + "_f.text")
//elseif dw_invisible.describe( object_name + "_t.visible" ) <> '!' then
//  detail_object_labels = detail_object_labels + dw_invisible.describe(object_name + "_t.text")
//
//else 
//    detail_object_labels = detail_object_labels + "?"
// end if
//next
//
////========
//detail_object_labels = detail_object_labels + "~r~n"
//
////엑셀과 연결 시작
//oleobject export_object
//uint excel_handle, excel_state
//string excel_title
//
//export_object = create oleobject
//
//export_object.connecttonewobject("excel.application")
//
//excel_title = export_object.Application.Caption
//
//export_object.Application.Visible = True
//excel_handle = FindWindowA( 0, excel_title )
//SetFocus( excel_handle )
//
////파일작성
//long row_count, start_row
//string data_buffer, s_select, filename, s_syn, s_trailer1_data
//int file_num, ii
//
//filename = "c:\export.txt"
//start_row = 1
//
//row_count = dw_invisible.rowcount()
//if row_count = 0 then Return 
//
//if fileexists(filename) then 
//DeleteFileA(filename)
//end if
//
//file_num = fileopen(filename, streammode!, write!, lockreadwrite!, append!)
//
////각 로우별로 데이터를 읽어서 파일에 기록한다.
//for start_row = 1 to row_count
//  s_select = string(start_row) + "/" + string(start_row) + "/" +detail_object_spec
// dw_invisible.modify(" Datawindow.selected = '" + s_select + "'")
//   data_buffer = dw_invisible.describe("datawindow.selected.data") + "~r~n"
// if start_row = 1 then data_buffer = detail_object_labels + data_buffer
//   if b_trailer1 then //그룹이 존재한다면
//  i_target_row = dw_invisible.FindGroupChange(start_row, 1) - 1
//    if i_target_row = start_row then
//   for i = 1 to i_trailer1_count
//     if upper(dw_invisible.describe( s_trailer1_object[i] + ".type" )) = "COMPUTE" then
//      s_syn = dw_invisible.describe(s_trailer1_object[i] + ".expression")
//              s_syn = dw_invisible.Describe("Evaluate('" + s_syn + "',"  + string(start_row) + ")")
//              if i = 1 then
//      for ii = 1 to i_detail_count - i_trailer1_count - 1
//       s_trailer1_data = s_trailer1_data + '~t'
//        next
//      end if
//      s_trailer1_data = s_trailer1_data + '~t' + s_syn  
//      elseif upper(dw_invisible.describe( s_trailer1_object[i] + ".type" )) = "COLUMN" then
//      s_syn = dw_invisible.Describe("Evaluate('LookUpDisplay(" + s_trailer1_object[i] + ") '," + &
//                          string(start_row) + ")")
//              if i = 1 then
//       for ii = 1 to i_detail_count - i_trailer1_count - 1
//        s_trailer1_data = s_trailer1_data + '~t'
//       next
//      end if
//      s_trailer1_data = s_trailer1_data + '~t' + s_syn           
//      elseif upper(dw_invisible.describe( s_trailer1_object[i] + ".type" )) = "TEXT" then
//      s_syn = dw_invisible.Describe(s_trailer1_object[i] + ".text")
//              if i = 1 then
//       for ii = 1 to i_detail_count - i_trailer1_count - 1
//        s_trailer1_data = s_trailer1_data + '~t'
//       next
//      end if
//      s_trailer1_data = s_trailer1_data + '~t' + s_syn                  
//      end if
//     next
//   data_buffer = data_buffer + "~r~n" + s_trailer1_data + "~r~n"
//   end if
//end if
//filewrite(file_num, data_buffer)
//setnull(data_buffer)
//s_trailer1_data = ''
//next
//
////Footer 밴드를 마지막으로 파일에 덧붙힌다.
//if b_footer then
//  for i = 1 to i_footer_count
//    if upper(dw_invisible.describe( s_footer_object[i] + ".type" )) = "COMPUTE" then
//     s_syn = dw_invisible.describe(s_footer_object[i] + ".expression")
//       s_syn = dw_invisible.Describe("Evaluate('" + s_syn + "',"  + string(row_count) + ")")
//         if i = 1 then
//    for ii = 1 to i_detail_count - i_footer_count - 1
//      s_footer_data = s_footer_data + '~t'
//      next
//     end if
//   s_footer_data = s_footer_data + '~t' + s_syn  
//    elseif upper(dw_invisible.describe( s_footer_object[i] + ".type" )) = "COLUMN" then
//   s_syn = dw_invisible.Describe("Evaluate('LookUpDisplay(" + s_footer_object[i] + ") '," + &
//                         string(row_count) + ")")
//         if i = 1 then
//    for ii = 1 to i_detail_count - i_footer_count - 1
//      s_footer_data = s_footer_data + '~t'
//      next
//     end if          
//     s_footer_data = s_footer_data + '~t' + s_syn           
//    elseif upper(dw_invisible.describe( s_footer_object[i] + ".type" )) = "TEXT" then
//   s_syn = dw_invisible.Describe(s_footer_object[i] + ".text")
//         if i = 1 then
//    for ii = 1 to i_detail_count - i_footer_count - 1
//      s_footer_data = s_footer_data + '~t'
//      next
//     end if    
//       s_footer_data = s_footer_data + '~t' + s_syn                  
//    end if
//  next
//data_buffer = "~r~n" + s_footer_data 
//filewrite(file_num, data_buffer)
//end if
//
//fileclose(file_num)
//
//export_object.statusbar = "Importing data...."
//export_object.workbooks.opentext(filename)
//export_object.windows("export.txt").caption = "Export Workbook"
//
////엑셀파일의 포맷을 실시한다.
//
////자동 칸맞춤을 적용한다.
//export_object.Worksheets[1].Columns.AutoFit
//
////헤드 줄은 bold로 지정한다.
//export_object.rows("1:1").select
//export_object.selection.font.bold = true
//export_object.selection.font.italic = false
//
//
//export_object.statusbar = " Formatting labels....."
//export_object.rows("1:1").select
////셀들의 줄맞춤을 실시한다.
//export_object.selection.wraptext  = true
//export_object.selection.horizontalalignment = true
//export_object.selection.verticalalignment = true
//
////미리보기에서 헤드셀들은 반복되어 나타나게 한다.
//export_object.Activesheet.PageSetup.PrintTitleRows = "$1:$1"
//
//export_object.DisConnectObject() //연결종료
//Destroy export_object //오브젝트 제거 
//
end subroutine

on w_dw_saveas_user_r.create
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.dw_2=create dw_2
this.dw_1=create dw_1
this.dw_invisible=create dw_invisible
this.rb_text=create rb_text
this.rb_all=create rb_all
this.mle_desc=create mle_desc
this.gb_1=create gb_1
this.gb_2=create gb_2
this.gb_3=create gb_3
this.Control[]={this.cb_cancel,&
this.cb_ok,&
this.dw_2,&
this.dw_1,&
this.dw_invisible,&
this.rb_text,&
this.rb_all,&
this.mle_desc,&
this.gb_1,&
this.gb_2,&
this.gb_3}
end on

on w_dw_saveas_user_r.destroy
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.dw_2)
destroy(this.dw_1)
destroy(this.dw_invisible)
destroy(this.rb_text)
destroy(this.rb_all)
destroy(this.mle_desc)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.gb_3)
end on

event open;	datawindow		ldw_current
Long		i, ll_len, ll_pos, ll_text_len, ll_rowcount
String 	ls_describe, ls_object, ls_id, ls_band, ls_visible, ls_text, ls_mid, ls_column_display = ''
String	ls_tag
String	ls_tag2
String   ls_describe2
String   ls_objectname
String   ls_compute
Blob 		lblb_data   // invisible datawindow 에 뿌려줄 데이터 값
Integer	li_tab

f_pisc_win_center_move(This)

//대상 Datawindow
ldw_current = message.powerobjectparm
idw_dw = ldw_current
ls_describe	= ldw_current.Describe("DataWindow.Objects")
is_describe = ls_describe
this.title = "사용자 지정 Columns 저장"


If ls_describe <> '!' Then
	ll_len		= Len(Trim(ls_describe))
	ll_pos		= Pos(ls_describe, '~t')
	DO 
		ls_object	= Left(ls_describe, ll_pos - 1)
		ls_id			= ldw_current.Describe(ls_object + ".ID")
		ls_band		= ldw_current.Describe(ls_object + ".Band")
		ls_visible	= ldw_current.Describe(ls_object + ".Visible")
		ls_compute  = Upper(ldw_current.Describe(ls_object + ".Type"))


		// Column Object인지 Check한다.(Column또는 Table Blob Object만이 ID를 가지고 있다)
		// Detail Band 안에 존재해야 한다.
		// Visible 상태의 Column만을 대상으로 한다.
		// Column Object인지 Check한다.
		If Upper(ls_band) = 'DETAIL' And ls_visible = '1' THen
			ls_tag 	= ldw_current.Describe(ls_object + "_s_f.name")
         li_tab = pos(ls_tag, "_s_f", 1)
			If li_tab > 0 Then  // 헤더의 TEXT가 "_s_f"로 끝날 경우..
				ls_text	= ldw_current.Describe(ls_object + "_s_f.text")
				
								
				ll_text_len	= Len(ls_text)
				For i = 1 To ll_text_len
					ls_mid	= Mid(ls_text, i, 1)
					If Asc(ls_mid) >= 33 Then
						ls_column_display	= ls_column_display + ls_mid
					End If
				Next
			Else
				ls_tag 	= ldw_current.Describe(ls_object + "_t.name")
   			li_tab = pos(ls_tag, "_t", 1)
				If li_tab > 0 Then  // 헤더의 TEXT가 "_t"로 끝날 경우..
					ls_text	= ldw_current.Describe(ls_object + "_t.text")
				   ll_text_len	= Len(ls_text)
					For i = 1 To ll_text_len
						ls_mid	= Mid(ls_text, i, 1)
						If Asc(ls_mid) >= 33 Then
							ls_column_display	= ls_column_display + ls_mid
						End If
					Next
				Else
					ls_tag 	= ldw_current.Describe(ls_object + "_s.name")
   				li_tab = pos(ls_tag, "_s", 1)
					If li_tab > 0 Then // 헤더의 TEXT가 "_s"로 끝날 경우..
						ls_text	= ldw_current.Describe(ls_object + "_s.text")
				   	ll_text_len	= Len(ls_text)
						For i = 1 To ll_text_len
						ls_mid		= Mid(ls_text, i, 1)
							If Asc(ls_mid) >= 33 Then
								ls_column_display	= ls_column_display + ls_mid
							End If
						Next
					Else
						ls_tag 	= ldw_current.Describe(ls_object + "_f.name")
   					li_tab = pos(ls_tag, "_f", 1)
							If li_tab > 0 Then  // 헤더의 TEXT가 "_f"로 끝날 경우..
								ls_text	= ldw_current.Describe(ls_object + "_f.text")
				   			ll_text_len	= Len(ls_text)
								For i = 1 To ll_text_len
								ls_mid		= Mid(ls_text, i, 1)
									If Asc(ls_mid) >= 33 Then
										ls_column_display	= ls_column_display + ls_mid
									End If
								Next

							End If
					End If
				End If
			End If
			// Text가 "~r~n"을 포함하고 있는 경우에 String 앞뒤에 " 를 붙여서 Return 한다. 
			// 앞뒤의 " 를 제외시킨다.
      If Left(ls_column_display, 1) = '"' And Right(ls_column_display, 1) = '"'  Then
			ls_column_display = Mid(ls_column_display, 2, Len(ls_column_display) - 2 )
		End If
			
			ll_rowcount	= dw_1.RowCount()
						
			// User에게 Test의 내용을 Display한다.
			If len(trim(ls_column_display)) <> 0 Then
				dw_1.InsertRow(ll_rowcount + 1)
				dw_1.SetItem(ll_rowcount + 1, 'columndisplay',ls_column_display)
            // 실제 column선택시는 Column Object를 이용한다.
            dw_1.SetItem(ll_rowcount + 1, 'columnname',	ls_object)
			   dw_1.SetItem(ll_rowcount + 1, 'columnid', 	Integer(ls_id))
			End IF
      End If
		ls_column_display = ''

		ls_describe			= Trim(Mid(ls_describe, ll_pos + 1, ll_len))
		ll_len				= Len(ls_describe)
		ll_pos				= Pos(ls_describe, "~t")
		ls_column_display = ''

// DataWindow Objects 중 마지막 Object
		If ll_pos = 0 Then
			ls_object	= ls_describe
			ls_id			= ldw_current.Describe(ls_object + ".ID")
			ls_band		= ldw_current.Describe(ls_object + ".Band")
			ls_visible	= ldw_current.Describe(ls_object + ".Visible")
			ls_compute  = Upper(ldw_current.Describe(ls_object + ".Type"))

//			 Column Object인지 Check한다.
		If Upper(ls_band) = 'DETAIL' And ls_visible = '1' Then 
			ls_tag 	= ldw_current.Describe(ls_object + "_s_f.name")
			li_tab = pos(ls_tag, "_s_f", 1)
			If li_tab > 0 Then
				ls_text	= ldw_current.Describe(ls_object + "_s_f.text")
				ll_text_len	= Len(ls_text)
			   For i = 1 To ll_text_len
					ls_mid		= Mid(ls_text, i, 1)
					If Asc(ls_mid) >= 33 Then
						ls_column_display	= ls_column_display + ls_mid
					End If
				Next
			Else
				ls_tag 	= ldw_current.Describe(ls_object + "_t.name")
   			li_tab = pos(ls_tag, "_t", 1)
				If li_tab > 0 Then
					ls_text	= ldw_current.Describe(ls_object + "_t.text")
				   ll_text_len	= Len(ls_text)
					For i = 1 To ll_text_len
						ls_mid		= Mid(ls_text, i, 1)
						If Asc(ls_mid) >= 33 Then
							ls_column_display	= ls_column_display + ls_mid
						End If
					Next
				Else
					ls_tag 	= ldw_current.Describe(ls_object + "_s.name")
   				li_tab = pos(ls_tag, "_s", 1)
					If li_tab > 0 Then
						ls_text	= ldw_current.Describe(ls_object + "_s.text")
				   	ll_text_len	= Len(ls_text)
						For i = 1 To ll_text_len
						ls_mid		= Mid(ls_text, i, 1)
							If Asc(ls_mid) >= 33 Then
								ls_column_display	= ls_column_display + ls_mid
							End If
						Next
					Else
						ls_tag 	= ldw_current.Describe(ls_object + "_f.name")
   					li_tab = pos(ls_tag, "_f", 1)
							If li_tab > 0 Then
								ls_text	= ldw_current.Describe(ls_object + "_f.text")
				   			ll_text_len	= Len(ls_text)
								For i = 1 To ll_text_len
								ls_mid		= Mid(ls_text, i, 1)
									If Asc(ls_mid) >= 33 Then
										ls_column_display	= ls_column_display + ls_mid
									End If
								Next

							 End If
						End If
					End If
				End If
			End If

				// Text가 "~r~n"을 포함하고 있는 경우에 String 앞뒤에 " 를 붙여서 Return 한다. 
				// 앞뒤의 " 를 제외시킨다.
				If Left(ls_column_display, 1) = '"' And Right(ls_column_display, 1) = '"'  Then
					ls_column_display = Mid(ls_column_display, 2, Len(ls_column_display) - 2 )
		      End If
				ll_rowcount	= dw_1.RowCount()
	  	   	// User에게 Test의 내용을 Display한다.
					If len(trim(ls_column_display)) <> 0 Then    //0912 새로 추가한 내용임(bitmap제거).
						dw_1.InsertRow(ll_rowcount + 1)
						dw_1.SetItem(ll_rowcount + 1, 'columndisplay',ls_column_display)
				   End If
//				// 실제 column선택시는 Column Object를 이용한다.
					dw_1.SetItem(ll_rowcount + 1, 'columnname',	ls_object)
			   	dw_1.SetItem(ll_rowcount + 1, 'columnid', 		Integer(ls_id))
			   End IF
   	ls_column_display = ''
	LOOP UNTIL ll_pos = 0
End If

//해당 datawindow의 dataobject를 알아와서 invisible datawindow에 뿌려준다
ls_objectname = idw_dw.dataobject
//multi row 입력값을 받기 위해 Bolb로 데이타를 넘긴다.
idw_dw.getfullstate(lblb_data) 			
dw_invisible.dataobject = ls_objectname
//multi row 입력값을 받기 위해 Bolb로 데이타를 받는다.
dw_invisible.Setfullstate(lblb_data)	
mle_desc.DisplayOnly = TRUE
rb_all.checked = true
wf_option()

end event

type cb_cancel from commandbutton within w_dw_saveas_user_r
integer x = 1883
integer y = 256
integer width = 402
integer height = 104
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
string text = "취소(&C)"
boolean cancel = true
end type

event clicked;Close(parent)
end event

type cb_ok from commandbutton within w_dw_saveas_user_r
integer x = 1883
integer y = 120
integer width = 402
integer height = 104
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
string text = "확인(&O)"
boolean default = true
end type

event clicked;Long		ll_rowcount
Long     ll_rowcount2
Long		i
LONG     i2
Long		ll_len, ll_pos
String	ls_col_list  //DESTROY 시킬 컬럼 리스트
sTRING   ls_col_list2 //선택한 컬럼 리스트
String   ls_header    //한글명으로 바꾼 헤더
String   ls_pathname
String   ls_filename
String   ls_text
String   ls_compute_text
String   ls_extention
String   ls_separator
String 	ls_object
String   ls_visible
String   ls_col_list3


// DW 내의 Invisible로 된 컬럼들 지우기...
If is_describe <> '!' Then
	ll_len		= Len(Trim(is_describe))
	ll_pos		= Pos(is_describe, '~t')
	DO 
		ls_object	= Left(is_describe, ll_pos - 1)
		ls_visible	= idw_dw .Describe(ls_object + ".Visible")
	
		If ls_visible <> '1' THen
			ls_col_list3 	= idw_dw .Describe(ls_object + ".name")
      End If
		
		//dw_invisible.modify("destroy " + ' ' + ls_text)           // 컬럼의 text를 지운다.
		dw_invisible.modify("destroy column" + ' ' + ls_col_list3) // 컬럼을 지운다.
		ls_col_list3 = ''
		
		is_describe			= Trim(Mid(is_describe, ll_pos + 1, ll_len))
		ll_len				= Len(is_describe)
		ll_pos				= Pos(is_describe, "~t")
		ls_col_list3 = ''
		
	LOOP Until ll_pos = 0
End If


ll_rowcount = dw_1.rowcount()
ll_rowcount2 = dw_2.rowcount()
//
//// 선택한 칼럼들을 제외한 컬럼들을 지운다.
////<<0920수정>>  좌측으로 이동시킨 컬럼만 지운다..
//If ll_rowcount2 > 0 Then
	For i = 1 To ll_rowcount2
		ls_col_list = ls_col_list + ' ' + dw_2.GetItemString(i, 'columnname')
		IF dw_invisible.describe(ls_col_list + ".ID") <> '!' Then
			ls_text = dw_invisible.Describe(ls_col_list + "_s_f.name")
			If ls_text = '!' Then
				ls_text = dw_invisible.Describe(ls_col_list + "_f.name")
			   If ls_text = '!' Then
				   ls_text = dw_invisible.Describe(ls_col_list + "_s.name")
					If ls_text = '!' Then
				      ls_text = dw_invisible.Describe(ls_col_list + "_t.name")
					End IF
				End If
			End If
			dw_invisible.modify("destroy " + ' ' + ls_text)           // 컬럼의 text를 지운다.
			dw_invisible.modify("destroy column" + ' ' + ls_col_list) // 컬럼을 지운다.
		Else  //compute field의 헤더 텍스트의 이름은 항상 끝에 _t로 통일
			   // _s, _f, _s_f 와 같이 분류하지 말 것 
			   //그래야 compute field를 destroy시킬때 같이 없앨 수 있다.
			   //단, SQL로 처리한 compute column은 관계 없음.
			ls_compute_text = dw_invisible.Describe(ls_col_list + "_s_f.name")
			If ls_compute_text = '!' Then
				ls_compute_text = dw_invisible.Describe(ls_col_list + "_f.name")
			   If ls_compute_text = '!' Then
				   ls_compute_text = dw_invisible.Describe(ls_col_list + "_s.name")
					If ls_compute_text = '!' Then
				      ls_compute_text = dw_invisible.Describe(ls_col_list + "_t.name")
					End IF
				End If
			End If
			dw_invisible.modify("destroy" + ' ' + ls_compute_text) //text를 지운다
			dw_invisible.modify("destroy" + ' ' + ls_col_list)     //compute field를 지운다.
		End If
		ls_col_list = ''
	Next

	CHOOSE CASE is_flag 
		CASE "TEXT"
			IF GetFileSaveName ( "화일로 저장", ls_pathname, ls_filename , &
													"CSV", &
													"Tab-separated columns (*.TXT),*.TXT," + &
													"Comma-separated values (*CSV),*.CSV" ) < 1 THEN
					RETURN -1
			END IF
			
										
				SetPointer(HourGlass!)										
													
				//Format에 따라
				ls_extention = Right(Upper(ls_filename),3)
				IF ls_extention = "TXT" THEN
					ls_separator = "~t"
				ELSEIF ls_extention = "CSV" THEN
					ls_separator = ","
				ELSE
					ls_separator = "~t"		
				END IF
						
						
			//PowerBuilder의 한계...
			//compute field까지 포함해서 SaveAs할 려면 이 방법 밖에 없다..
			// 하지만 , 텍스트로 밖에,,엑셀은 불가능,,!!
			dw_invisible.SaveAsAscii(ls_pathname  , ls_separator)	
//         wf_excel()
		CASE "EXCEL" 
			//컬럼 헤더를 한글명으로 바꾼다...	
			For i2 = 1 To ll_rowcount
				ls_col_list2 = ls_col_list2 + ' ' + dw_1.GetItemString(i2, 'columnname')
				ls_header = dw_invisible.Describe(ls_col_list2 + "_s_f.text")
			//	messagebox("ls_col_list2", ls_col_list2)
			//	messagebox("header", ls_header)
				If ls_header = "!" Then
					ls_header = dw_invisible.Describe(ls_col_list2 + "_s.text")
					If ls_header = "!" Then
						ls_header = dw_invisible.Describe(ls_col_list2 + "_t.text")
						If ls_header = "!" Then
							ls_header = dw_invisible.Describe(ls_col_list2 + "_f.text")
						End If	
					End If
				End If
					dw_invisible.Modify(ls_col_list2 + ".dbName = '" + ls_header + "'")
				ls_col_list2 = ''
			Next
   	   dw_invisible.SaveAs("", Excel!, True)
	END CHOOSE
	
	// 2001.11.14 - 현재 디렉토리를 diconet 디렉토리로 변경(Funcky32.dll 이용)
	// 파일저장등으로 현재 디렉토리가 바뀌면 toolbar icon을 참조하지 못하기 때문
	//chdir(gstr_login.ss_work_directory)

	close(Parent)
//Else
//	messagebox("확인", "지정한 칼럼이 없습니다." + &
//					"~r~nSaveas하고자는 칼럼을 Drag해 주세요..")
//End If

end event

type dw_2 from datawindow within w_dw_saveas_user_r
integer x = 951
integer y = 128
integer width = 841
integer height = 664
integer taborder = 20
string dragicon = ".\resource\row.ico"
string title = "none"
string dataobject = "d_xc001_ex_user_column_right"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;If row > 0 Then
	SelectRow(0, False)
	SelectRow(row, True)
	
	il_drag_row	= row

	Drag(Begin!)
End If

end event

event dragdrop;Long			ll_find
String		ls_column
DragObject	ldo_object
DataWindow	ldw_control

// Dragged중인 Object를 알아낸다.
ldo_object = DraggedObject()
If TypeOf (ldo_object) = DataWindow! Then
	ldw_control = ldo_object
	If ldw_control = This Then
		RowsMove(il_drag_row, il_drag_row, Primary!, This, il_old_row, Primary!)
		SelectRow(0, False)
		
	ElseIf ldw_control = dw_1 Then
		dw_1.SelectRow(0, False)
		ls_column	= dw_1.GetItemString(il_drag_row, 'columnname')
		ll_find	= Find("columnname  = '" + ls_column + "'", 1, RowCount())
		If ll_Find > 0 Then
			RowsMove(ll_find, ll_find, Primary!, This, il_old_row, Primary!)
			
		Else
			InsertRow(il_old_row)
			SetItem(il_old_row, 'columndisplay', dw_1.GetItemString(il_drag_row, 'columndisplay'))
			SetItem(il_old_row, 'columnname', ls_column)
			SetItem(il_old_row, 'columnid', dw_1.GetItemNumber(il_drag_row, 'columnid'))
			dw_1.deleterow(il_drag_row)
		End If
	End If
	
End If


end event

event dragwithin;Long	ll_first_row, ll_header, ll_detail, ll_last_row
DragObject	ldo_object
DataWindow	ldw_control

If row > 0 Then
	If il_old_row <> row Then
		ll_first_row	= Long(Object.DataWindow.FirstRowOnPage)
		ll_header		= Long(Describe("DataWindow.Header.Height"))
		ll_detail		= Long(Describe("DataWindow.Detail.Height"))
		il_old_row = row
	End If
Else
	ll_last_row 	= Long(Object.DataWindow.LastRowOnPage)
	ll_first_row	= Long(Object.DataWindow.FirstRowOnPage)
	ll_header		= Long(Describe("DataWindow.Header.Height"))
	ll_detail		= Long(Describe("DataWindow.Detail.Height"))
	If PointerY() > ll_header Then
		If ll_last_row < RowCount() Then
			ScrollNextRow()
		Else
					
			il_old_row = ll_last_row + 1
		End If
	Else
		ScrollPriorRow()
	End If
End If

// Dragged중인 Object를 알아낸다.
ldo_object = DraggedObject()
If TypeOf (ldo_object) = DataWindow! Then
	ldw_control = ldo_object
End If	
end event

type dw_1 from datawindow within w_dw_saveas_user_r
integer x = 73
integer y = 128
integer width = 841
integer height = 664
integer taborder = 10
string dragicon = ".\resource\row.ico"
string title = "none"
string dataobject = "d_xc001_ex_user_column_left"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;If row > 0 Then
	SelectRow(0, False)
	SelectRow(row, True)
	
	il_drag_row	= row
	
	Drag(Begin!)
End If


end event

event dragdrop;Long			ll_find
String		ls_column
DragObject	ldo_object
DataWindow	ldw_control

// Dragged중인 Object를 알아낸다.
ldo_object = DraggedObject()
If TypeOf (ldo_object) = DataWindow! Then
	ldw_control = ldo_object
	If ldw_control = This Then
		RowsMove(il_drag_row, il_drag_row, Primary!, This, il_old_row, Primary!)
		SelectRow(0, False)
		
	ElseIf ldw_control = dw_2 Then
		dw_2.SelectRow(0, False)
		ls_column	= dw_2.GetItemString(il_drag_row, 'columnname')
		ll_find	= Find("columnname  = '" + ls_column + "'", 1, RowCount())
		If ll_Find > 0 Then
			RowsMove(ll_find, ll_find, Primary!, This, il_old_row, Primary!)
			
		Else
			InsertRow(il_old_row)
			SetItem(il_old_row, 'columndisplay', dw_2.GetItemString(il_drag_row, 'columndisplay'))
			SetItem(il_old_row, 'columnname', ls_column)
			SetItem(il_old_row, 'columnid', dw_2.GetItemNumber(il_drag_row, 'columnid'))
			dw_2.deleterow(il_drag_row)
		End If
	End If
	
End If



end event

event dragwithin;Long	ll_first_row, ll_header, ll_detail, ll_last_row
DragObject	ldo_object
DataWindow	ldw_control

If row > 0 Then
	If il_old_row <> row Then
		ll_first_row	= Long(Object.DataWindow.FirstRowOnPage)
		ll_header		= Long(Describe("DataWindow.Header.Height"))
		ll_detail		= Long(Describe("DataWindow.Detail.Height"))
		il_old_row = row
	End If
Else
	ll_last_row 	= Long(Object.DataWindow.LastRowOnPage)
	ll_first_row	= Long(Object.DataWindow.FirstRowOnPage)
	ll_header		= Long(Describe("DataWindow.Header.Height"))
	ll_detail		= Long(Describe("DataWindow.Detail.Height"))
	If PointerY() > ll_header Then
		If ll_last_row < RowCount() Then
			ScrollNextRow()
		Else
					
			il_old_row = ll_last_row + 1
		End If
	Else
		ScrollPriorRow()
	End If
End If

// Dragged중인 Object를 알아낸다.
ldo_object = DraggedObject()
If TypeOf (ldo_object) = DataWindow! Then
	ldw_control = ldo_object
End If	
end event

type dw_invisible from datawindow within w_dw_saveas_user_r
boolean visible = false
integer x = 658
integer y = 600
integer width = 174
integer height = 136
integer taborder = 50
boolean bringtotop = true
string title = "none"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

type rb_text from radiobutton within w_dw_saveas_user_r
integer x = 1920
integer y = 576
integer width = 379
integer height = 64
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 33554432
long backcolor = 67108864
string text = "Text 형식"
borderstyle borderstyle = stylelowered!
end type

event clicked;wf_option()
end event

type rb_all from radiobutton within w_dw_saveas_user_r
integer x = 1920
integer y = 720
integer width = 320
integer height = 64
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 33554432
long backcolor = 67108864
string text = "모든 형식"
borderstyle borderstyle = stylelowered!
end type

event clicked;wf_option()
end event

type mle_desc from multilineedit within w_dw_saveas_user_r
integer x = 37
integer y = 864
integer width = 2295
integer height = 224
integer taborder = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 255
long backcolor = 80269528
string text = "Description..."
boolean autovscroll = true
integer limit = 3
integer tabstop[] = {0}
borderstyle borderstyle = stylelowered!
end type

type gb_1 from groupbox within w_dw_saveas_user_r
integer x = 37
integer y = 48
integer width = 1792
integer height = 792
integer taborder = 10
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 8388608
long backcolor = 67108864
string text = "삭제할 Column을 오른쪽으로 Drag 하세요"
borderstyle borderstyle = stylelowered!
end type

type gb_2 from groupbox within w_dw_saveas_user_r
integer x = 1847
integer y = 48
integer width = 485
integer height = 360
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 8388608
long backcolor = 67108864
borderstyle borderstyle = stylelowered!
end type

type gb_3 from groupbox within w_dw_saveas_user_r
integer x = 1847
integer y = 440
integer width = 485
integer height = 400
integer taborder = 50
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
boolean underline = true
long textcolor = 8388608
long backcolor = 67108864
string text = "저장파일 Option"
end type

