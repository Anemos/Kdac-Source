$PBExportHeader$w_comm901u.srw
$PBExportComments$PC����
forward
global type w_comm901u from w_origin_sheet09
end type
type tab_1 from tab within w_comm901u
end type
type tabpage_1 from userobject within tab_1
end type
type dw_12 from datawindow within tabpage_1
end type
type st_1 from statictext within tabpage_1
end type
type ddlb_1 from dropdownlistbox within tabpage_1
end type
type dw_11 from datawindow within tabpage_1
end type
type dw_10 from datawindow within tabpage_1
end type
type tabpage_1 from userobject within tab_1
dw_12 dw_12
st_1 st_1
ddlb_1 ddlb_1
dw_11 dw_11
dw_10 dw_10
end type
type tabpage_2 from userobject within tab_1
end type
type st_4 from statictext within tabpage_2
end type
type st_3 from statictext within tabpage_2
end type
type dw_24 from datawindow within tabpage_2
end type
type dw_23 from datawindow within tabpage_2
end type
type dw_22 from datawindow within tabpage_2
end type
type dw_21 from datawindow within tabpage_2
end type
type dw_20 from datawindow within tabpage_2
end type
type tabpage_2 from userobject within tab_1
st_4 st_4
st_3 st_3
dw_24 dw_24
dw_23 dw_23
dw_22 dw_22
dw_21 dw_21
dw_20 dw_20
end type
type tabpage_3 from userobject within tab_1
end type
type dw_33 from datawindow within tabpage_3
end type
type dw_32 from datawindow within tabpage_3
end type
type dw_31 from datawindow within tabpage_3
end type
type dw_30 from datawindow within tabpage_3
end type
type tabpage_3 from userobject within tab_1
dw_33 dw_33
dw_32 dw_32
dw_31 dw_31
dw_30 dw_30
end type
type tabpage_4 from userobject within tab_1
end type
type dw_43 from datawindow within tabpage_4
end type
type dw_42 from datawindow within tabpage_4
end type
type dw_41 from datawindow within tabpage_4
end type
type dw_40 from datawindow within tabpage_4
end type
type tabpage_4 from userobject within tab_1
dw_43 dw_43
dw_42 dw_42
dw_41 dw_41
dw_40 dw_40
end type
type tabpage_5 from userobject within tab_1
end type
type dw_51 from datawindow within tabpage_5
end type
type dw_50 from datawindow within tabpage_5
end type
type tabpage_5 from userobject within tab_1
dw_51 dw_51
dw_50 dw_50
end type
type tabpage_6 from userobject within tab_1
end type
type dw_62 from datawindow within tabpage_6
end type
type dw_61 from datawindow within tabpage_6
end type
type dw_60 from datawindow within tabpage_6
end type
type tabpage_6 from userobject within tab_1
dw_62 dw_62
dw_61 dw_61
dw_60 dw_60
end type
type tabpage_7 from userobject within tab_1
end type
type dw_72 from datawindow within tabpage_7
end type
type dw_71 from datawindow within tabpage_7
end type
type dw_70 from datawindow within tabpage_7
end type
type tabpage_7 from userobject within tab_1
dw_72 dw_72
dw_71 dw_71
dw_70 dw_70
end type
type tabpage_8 from userobject within tab_1
end type
type dw_81_print from datawindow within tabpage_8
end type
type pb_excel from picturebutton within tabpage_8
end type
type pb_print from picturebutton within tabpage_8
end type
type ddlb_2 from dropdownlistbox within tabpage_8
end type
type st_2 from statictext within tabpage_8
end type
type dw_81 from datawindow within tabpage_8
end type
type dw_80 from datawindow within tabpage_8
end type
type dw_80_dept from datawindow within tabpage_8
end type
type tabpage_8 from userobject within tab_1
dw_81_print dw_81_print
pb_excel pb_excel
pb_print pb_print
ddlb_2 ddlb_2
st_2 st_2
dw_81 dw_81
dw_80 dw_80
dw_80_dept dw_80_dept
end type
type tabpage_9 from userobject within tab_1
end type
type dw_93 from datawindow within tabpage_9
end type
type hpb_1 from hprogressbar within tabpage_9
end type
type dw_92 from datawindow within tabpage_9
end type
type dw_91 from datawindow within tabpage_9
end type
type st_5 from statictext within tabpage_9
end type
type tabpage_9 from userobject within tab_1
dw_93 dw_93
hpb_1 hpb_1
dw_92 dw_92
dw_91 dw_91
st_5 st_5
end type
type tabpage_10 from userobject within tab_1
end type
type st_6 from statictext within tabpage_10
end type
type dw_ip from datawindow within tabpage_10
end type
type tabpage_10 from userobject within tab_1
st_6 st_6
dw_ip dw_ip
end type
type tabpage_11 from userobject within tab_1
end type
type dw_111 from datawindow within tabpage_11
end type
type st_7 from statictext within tabpage_11
end type
type tabpage_11 from userobject within tab_1
dw_111 dw_111
st_7 st_7
end type
type tab_1 from tab within w_comm901u
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
tabpage_4 tabpage_4
tabpage_5 tabpage_5
tabpage_6 tabpage_6
tabpage_7 tabpage_7
tabpage_8 tabpage_8
tabpage_9 tabpage_9
tabpage_10 tabpage_10
tabpage_11 tabpage_11
end type
end forward

global type w_comm901u from w_origin_sheet09
boolean controlmenu = false
event ue_open_after ( )
tab_1 tab_1
end type
global w_comm901u w_comm901u

type variables
Int 		ii_tabindex, ii_index, ii_index2
String 	is_colnm
Long		il_PreRow
datawindowchild idwc_1, idwc_2
datawindow idw_10, idw_11, idw_12, &
			  idw_20, idw_21, idw_22, idw_23, idw_24, &
			  idw_30, idw_31, idw_32, idw_33, &
		     idw_40, idw_41, idw_42, idw_43, &
			  idw_50, idw_51, idw_52, idw_53, &
			  idw_60, idw_61, idw_62, &
			  idw_70, idw_71, idw_72, &
			  idw_80, idw_80_dept,idw_81,idw_81_print, &
			  idw_91, idw_92, idw_93, &
			  idw_ip, idw_111
window iw_sheet


end variables

event ue_open_after();iw_sheet = w_frame.getactivesheet()

end event

on w_comm901u.create
int iCurrent
call super::create
this.tab_1=create tab_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
end on

on w_comm901u.destroy
call super::destroy
destroy(this.tab_1)
end on

event open;call super::open;This.Event Post ue_open_after()

end event

event ue_dprint;call super::ue_dprint;f_screen_print(this)
end event

event ue_retrieve;call super::ue_retrieve;String    	ls_fchgdt, ls_tchgdt ,ls_xplant, ls_div, ls_dept, ls_devicegubun, &
			ls_specgubun, ls_empgubun, ls_stcd, ls_chid, ls_cogubun, &
		 	ls_swlgubun,  ls_swvgubun, ls_deptName,ls_empnm
Long 	    	ll_rcnt, ll_row 
Integer   	li_rtn

setpointer(hourglass!)
CHOOSE CASE ii_tabindex
	//UPLOAD
	CASE 1
		//UPLOAD ���� ����///////////////////////////////////////
		IF IsNull(ii_index) OR ii_index = 0 THEN
			MessageBox("Ȯ��", "UPLOAD ������ �����Ͻÿ�.")
			RETURN
		END IF
		
		idw_11.reset()
		uo_status.st_message.text	= 'ó�����Դϴ�'
		li_rtn = f_pur040_getexcel(idw_11)
		
		IF li_rtn <> -1 AND idw_11.rowcount() > 0 THEN
			uo_status.st_message.text	= 'Upload �۾��Ϸ�'
			wf_icon_onoff(true,false,true,false,false,false,false,true,false)
		ELSE
			uo_status.st_message.text	= ''
			wf_icon_onoff(true,false,false,false,false,false,false,true,false)
		END IF
		//HW�� History ���� ���ε� �Ǿ�� �Ѵ�.
	////////////////////////////////////////////////////////////////////////	
	//HW ���/����	
	CASE 2
		idw_20.Object.fchgdt.Background.Color = 1090519039         
		idw_20.Object.tchgdt.Background.Color = 1090519039         
   
		idw_20.AcceptText()
		idw_20.SetItemStatus(1,0,Primary!,DataModified!)
		
		IF f_mandantory_chk(idw_20) = -1 THEN Return
		
		IF idw_20.AcceptText() = -1 THEN
			messagebox('Ȯ��','�������� ������ ��ȸ�ϼ���!',Exclamation!)
			Return
		END IF
		
		ls_fchgdt      		= trim(idw_20.object.fchgdt[1])  
		ls_tchgdt      		= trim(idw_20.object.tchgdt[1])
		ls_xplant      		= trim(idw_20.object.xplant[1])
		ls_div         		= trim(idw_20.object.div[1])
		ls_dept        		= trim(idw_20.object.dept[1])  
		ls_devicegubun 	= trim(idw_20.object.devicegubun[1])
		ls_specgubun   	= trim(idw_20.object.specgubun[1])  
		ls_empgubun    	= trim(idw_20.object.empgubun[1])
		ls_stcd        		= trim(idw_20.object.stcd[1])  
		ls_chid        		= trim(idw_20.object.chid[1])
		ls_empnm        	= trim(idw_20.object.empnm[1])
	
		IF IsNull(ls_xplant) OR ls_xplant = '' THEN
			ls_xplant = '%'
		ELSE
			ls_xplant = ls_xplant + '%'
		END IF
		
		IF IsNull(ls_div) OR ls_div = '' THEN
			ls_div = '%'
		ELSE
			ls_div = ls_div + '%'
		END IF
		
		IF IsNull(ls_dept) OR ls_dept = '' THEN
			ls_dept = '%'
		ELSE
			ls_dept = ls_dept + '%'
		END IF
		
		IF IsNull(ls_devicegubun) OR ls_devicegubun = '' THEN
			ls_devicegubun = '%'
		ELSE
			ls_devicegubun = ls_devicegubun + '%'
		END IF
		
		IF IsNull(ls_specgubun) OR ls_specgubun = '' THEN
			ls_specgubun = '%'
		ELSE
			ls_specgubun = ls_specgubun + '%'
		END IF
		
		IF IsNull(ls_empgubun) OR ls_empgubun = '' THEN
			ls_empgubun = '%'
		ELSE
			ls_empgubun = ls_empgubun + '%'
		END IF
		
		IF IsNull(ls_stcd) OR ls_stcd = '' THEN
			ls_stcd = '%'
		ELSE
			ls_stcd = ls_stcd + '%'
		END IF
		
		IF IsNull(ls_chid) OR ls_chid = '' THEN
			ls_chid = '%'
		ELSE
			ls_chid = '%' + ls_chid + '%'
		END IF
		
		IF IsNull(ls_empnm) OR ls_empnm = '' THEN
			ls_empnm = '%'
		ELSE
			ls_empnm = '%' + ls_empnm + '%'
		END IF
		
		IF IsNull(ls_fchgdt) OR ls_fchgdt = '' THEN
			ls_fchgdt = '19000101'
		END IF
		
		IF IsNull(ls_tchgdt) OR ls_tchgdt = '' THEN
			ls_tchgdt = '99991231'
		END IF
		
		idw_21.Reset()
		idw_22.Reset()
		idw_23.Reset()
		idw_24.Reset()
		
		IF idw_21.Retrieve(ls_fchgdt,ls_tchgdt,ls_xplant,ls_div, &
		                   ls_dept,ls_devicegubun,ls_specgubun, &
								 ls_empgubun,ls_stcd,ls_chid,ls_empnm) > 0 THEN
			uo_status.st_message.text = f_message("I010")
			wf_icon_onoff(true,true,false,false,false,true,false,true,false)
		ELSE
			uo_status.st_message.text = f_message("I020")
			wf_icon_onoff(true,true,false,false,false,false,false,true,false)
		END IF
	////////////////////////////////////////////////////////////////////////	
	//HW ����
	CASE 3
		idw_30.AcceptText()
		
		idw_30.SetItemStatus(1,0,Primary!,DataModified!)
		IF f_mandantory_chk(idw_30) = -1 THEN Return
		
		IF idw_30.AcceptText() = -1 THEN
			messagebox('Ȯ��','�������� ������ ��ȸ�ϼ���!',Exclamation!)
			Return
		END IF
		
		ls_fchgdt      = trim(idw_30.object.fchgdt[1])  
		ls_tchgdt      = trim(idw_30.object.tchgdt[1])
		ls_xplant      = trim(idw_30.object.xplant[1])
		ls_div         = trim(idw_30.object.div[1])
		ls_dept        = trim(idw_30.object.dept[1])  
		ls_devicegubun = trim(idw_30.object.devicegubun[1])
		ls_specgubun   = trim(idw_30.object.specgubun[1])  
		ls_empgubun    = trim(idw_30.object.empgubun[1])
		ls_stcd        = trim(idw_30.object.stcd[1])  
		ls_chid        = trim(idw_30.object.chid[1])
	
		IF IsNull(ls_xplant) OR ls_xplant = '' THEN
			ls_xplant = '%'
		ELSE
			ls_xplant = ls_xplant + '%'
		END IF
		
		IF IsNull(ls_div) OR ls_div = '' THEN
			ls_div = '%'
		ELSE
			ls_div = ls_div + '%'
		END IF
		
		IF IsNull(ls_dept) OR ls_dept = '' THEN
			ls_dept = '%'
		ELSE
			ls_dept = ls_dept + '%'
		END IF
		
		IF IsNull(ls_devicegubun) OR ls_devicegubun = '' THEN
			ls_devicegubun = '%'
		ELSE
			ls_devicegubun = ls_devicegubun + '%'
		END IF
		
		IF IsNull(ls_specgubun) OR ls_specgubun = '' THEN
			ls_specgubun = '%'
		ELSE
			ls_specgubun = ls_specgubun + '%'
		END IF
		
		IF IsNull(ls_empgubun) OR ls_empgubun = '' THEN
			ls_empgubun = '%'
		ELSE
			ls_empgubun = ls_empgubun + '%'
		END IF
		
		IF IsNull(ls_stcd) OR ls_stcd = '' THEN
			ls_stcd = '%'
		ELSE
			ls_stcd = ls_stcd + '%'
		END IF
		
		IF IsNull(ls_chid) OR ls_chid = '' THEN
			ls_chid = '%'
		ELSE
			ls_chid = ls_chid + '%'
		END IF
		
		IF IsNull(ls_fchgdt) OR ls_fchgdt = '' THEN
			ls_fchgdt = '19000101'
		END IF
		
		IF IsNull(ls_tchgdt) OR ls_tchgdt = '' THEN
			ls_tchgdt = '99991231'
		END IF
		
		idw_31.Reset()
		idw_32.Reset()
		idw_33.Reset()
		
		IF idw_31.Retrieve(ls_fchgdt,ls_tchgdt,ls_xplant,ls_div, &
		                   ls_dept,ls_devicegubun,ls_specgubun, &
								 ls_empgubun,ls_stcd,ls_chid) > 0 THEN
			uo_status.st_message.text = f_message("I010")
			wf_icon_onoff(true,true,false,false,false,true,false,true,false)
		ELSE
			uo_status.st_message.text = f_message("I020")
			wf_icon_onoff(true,true,false,false,false,false,false,true,false)
		END IF
	////////////////////////////////////////////////////////////////////////		
	//SW ����	
	CASE 4
		idw_40.Object.fchgdt.Background.Color = 1090519039         
		idw_40.Object.tchgdt.Background.Color = 1090519039 
		
		idw_40.AcceptText()
		
		idw_40.SetItemStatus(1,0,Primary!,DataModified!)
		
		IF f_mandantory_chk(idw_40) = -1 THEN Return
		
		IF idw_40.AcceptText() = -1 THEN
			messagebox('Ȯ��','�������� ������ ��ȸ�ϼ���!',Exclamation!)
			Return
		END IF
		
		ls_fchgdt      = trim(idw_40.object.fchgdt[1])  
		ls_tchgdt      = trim(idw_40.object.tchgdt[1])
		ls_xplant      = trim(idw_40.object.xplant[1])
		ls_div         = trim(idw_40.object.div[1])
		ls_dept        = trim(idw_40.object.dept[1])  
		ls_swlgubun    = trim(idw_40.object.swlgubun[1])
		ls_swvgubun    = trim(idw_40.object.swvgubun[1])  
		ls_chid        = trim(idw_40.object.chid[1])
	
		IF IsNull(ls_xplant) OR ls_xplant = '' THEN
			ls_xplant = '%'
		ELSE
			ls_xplant = ls_xplant + '%'
		END IF
		
		IF IsNull(ls_div) OR ls_div = '' THEN
			ls_div = '%'
		ELSE
			ls_div = ls_div + '%'
		END IF
		
		IF IsNull(ls_dept) OR ls_dept = '' THEN
			ls_dept = '%'
		ELSE
			ls_dept = ls_dept + '%'
		END IF
		
		IF IsNull(ls_swlgubun) OR ls_swlgubun = '' THEN
			ls_swlgubun = '%'
		ELSE
			ls_swlgubun = ls_swlgubun + '%'
		END IF
		
		IF IsNull(ls_swvgubun) OR ls_swvgubun = '' THEN
			ls_swvgubun = '%'
		ELSE
			ls_swvgubun = ls_swvgubun + '%'
		END IF
		
		IF IsNull(ls_chid) OR ls_chid = '' THEN
			ls_chid = '%'
		ELSE
			ls_chid = ls_chid + '%'
		END IF
		
		IF IsNull(ls_fchgdt) OR ls_fchgdt = '' THEN
			ls_fchgdt = '19000101'
		END IF
		
		IF IsNull(ls_tchgdt) OR ls_tchgdt = '' THEN
			ls_tchgdt = '99991231'
		END IF
		
		idw_41.Reset()
		idw_42.Reset()
		
		IF idw_41.Retrieve(ls_fchgdt,ls_tchgdt,ls_xplant,ls_div, &
		                   ls_dept,ls_swlgubun,ls_swvgubun,ls_chid) > 0 THEN
			uo_status.st_message.text = f_message("I010")
			wf_icon_onoff(true,true,false,false,false,true,false,true,false)
		ELSE
			uo_status.st_message.text = f_message("I020")
			wf_icon_onoff(true,true,false,false,false,false,false,true,false)
		END IF
	////////////////////////////////////////////////////////////////////////		
	//SW ��ȸ	
	CASE 5
		idw_50.AcceptText()
		
		idw_50.SetItemStatus(1,0,Primary!,DataModified!)
		
		IF f_mandantory_chk(idw_50) = -1 THEN Return
		
		IF idw_50.AcceptText() = -1 THEN
			messagebox('Ȯ��','�������� ������ ��ȸ�ϼ���!',Exclamation!)
			Return
		END IF
		
		ls_xplant      = trim(idw_50.object.xplant[1])
		ls_div         = trim(idw_50.object.div[1])
		ls_dept        = trim(idw_50.object.dept[1])  
		ls_swlgubun    = trim(idw_50.object.swlgubun[1])
		ls_swvgubun    = trim(idw_50.object.swvgubun[1])  
		ls_chid        = trim(idw_50.object.chid[1])
	
		IF IsNull(ls_xplant) OR ls_xplant = '' THEN
			ls_xplant = '%'
		ELSE
			ls_xplant = ls_xplant + '%'
		END IF
		
		IF IsNull(ls_div) OR ls_div = '' THEN
			ls_div = '%'
		ELSE
			ls_div = ls_div + '%'
		END IF
		
		IF IsNull(ls_dept) OR ls_dept = '' THEN
			ls_dept = '%'
		ELSE
			ls_dept = ls_dept + '%'
		END IF
		
		IF IsNull(ls_swlgubun) OR ls_swlgubun = '' THEN
			ls_swlgubun = '%'
		ELSE
			ls_swlgubun = ls_swlgubun + '%'
		END IF
		
		IF IsNull(ls_swvgubun) OR ls_swvgubun = '' THEN
			ls_swvgubun = '%'
		ELSE
			ls_swvgubun = ls_swvgubun + '%'
		END IF
		
		IF IsNull(ls_chid) OR ls_chid = '' THEN
			ls_chid = '%'
		ELSE
			ls_chid = ls_chid + '%'
		END IF
		
		idw_51.Reset()
		
		IF idw_51.Retrieve(ls_xplant,ls_div,ls_dept,ls_swlgubun,ls_swvgubun,ls_chid) > 0 THEN
			uo_status.st_message.text = f_message("I010")
			wf_icon_onoff(true,true,false,false,false,true,false,true,false)
		ELSE
			uo_status.st_message.text = f_message("I020")
			wf_icon_onoff(true,false,false,false,false,false,false,true,false)
		END IF	
		
	///////////////////////////////////////////////////////////////////////	
	//////SW ��������.
	CASE 6
		idw_60.AcceptText()
		
		idw_60.SetItemStatus(1,0,Primary!,DataModified!)
		IF f_mandantory_chk(idw_60) = -1 THEN Return
		
		IF idw_60.AcceptText() = -1 THEN
			messagebox('Ȯ��','�������� ������ ��ȸ�ϼ���!',Exclamation!)
			Return
		END IF
		
		ls_xplant      = trim(idw_60.object.xplant[1])
		ls_div         = trim(idw_60.object.div[1])
		ls_dept        = trim(idw_60.object.dept[1])  
		ls_swlgubun    = trim(idw_60.object.swlgubun[1])
		ls_swvgubun    = trim(idw_60.object.swvgubun[1])
		
		IF IsNull(ls_xplant) OR ls_xplant = '' THEN
			ls_xplant = '%'
		ELSE
			ls_xplant = ls_xplant + '%'
		END IF
		
		IF IsNull(ls_div) OR ls_div = '' THEN
			ls_div = '%'
		ELSE
			ls_div = ls_div + '%'
		END IF
		
		IF IsNull(ls_dept) OR ls_dept = '' THEN
			ls_dept = '%'
		ELSE
			ls_dept = ls_dept + '%'
		END IF
		
		IF IsNull(ls_swlgubun) OR ls_swlgubun = '' THEN
			ls_swlgubun = '%'
		ELSE
			ls_swlgubun = ls_swlgubun + '%'
		END IF
		
		IF IsNull(ls_swvgubun) OR ls_swvgubun = '' THEN
			ls_swvgubun = '%'
		ELSE
			ls_swvgubun = ls_swvgubun + '%'
		END IF
		
		idw_61.Reset()
		idw_62.Reset()

		IF idw_61.Retrieve(ls_xplant,ls_div,ls_dept,ls_swlgubun,ls_swvgubun) > 0 THEN
			uo_status.st_message.text = f_message("I010")
			wf_icon_onoff(true,false,false,false,false,false,false,true,false)
		ELSE
			uo_status.st_message.text = f_message("I020")
			wf_icon_onoff(true,false,false,false,false,false,false,true,false)
		END IF	
	///////////////////////////////////////////////////////////////////////
	//////�����ڵ� ����.
	CASE 7
		idw_70.AcceptText()
		
		idw_70.SetItemStatus(1,0,Primary!,DataModified!)
		IF f_mandantory_chk(idw_70) = -1 THEN Return
		
		IF idw_70.AcceptText() = -1 THEN
			messagebox('Ȯ��','�������� ������ ��ȸ�ϼ���!',Exclamation!)
			Return
		END IF
		
		ls_cogubun      = trim(idw_70.object.cogubun[1])  
		
		idw_71.Reset()
		idw_72.Reset()
//		idw_72.InsertRow(0)
		
		IF idw_71.Retrieve(ls_cogubun) > 0 THEN
			uo_status.st_message.text = f_message("I010")
			wf_icon_onoff(true,true,false,false,false,true,false,true,false)
		ELSE
			uo_status.st_message.text = f_message("I020")
			wf_icon_onoff(true,false,false,false,false,false,false,true,false)
		END IF
		
	//Report
	CASE 8
		//Report ���� ����///////////////////////////////////////
		IF IsNull(ii_index2) OR ii_index2 = 0 THEN
			MessageBox("Ȯ��", "Report �׸��� �����Ͻÿ�.")
			RETURN
		END IF
		
		if ii_index2	<>	8	then
			idw_80.AcceptText()
			idw_80.SetItemStatus(1,0,Primary!,DataModified!)
			IF f_mandantory_chk(idw_80) = -1 THEN Return
			IF idw_80.AcceptText() = -1 THEN
				messagebox('Ȯ��','�������� ������ ��ȸ�ϼ���!',Exclamation!)
				Return
			END IF
		
			ls_stcd        = trim(idw_80.object.stcd[1])  
			ls_devicegubun = trim(idw_80.object.devicegubun[1])  
			
			IF IsNull(ls_stcd) OR ls_stcd = '' THEN
				ls_stcd = '%'
			ELSE
				ls_stcd = ls_stcd + '%'
			END IF
			
			IF IsNull(ls_devicegubun) OR ls_devicegubun = '' THEN
				ls_devicegubun = '%'
			ELSE
				ls_devicegubun = ls_devicegubun + '%'
			END IF
			
			idw_81.Reset()
			
			IF idw_81.Retrieve(ls_stcd, ls_devicegubun) > 0 THEN
				uo_status.st_message.text = string(idw_81.rowcount()) + " ���� ������ " + f_message("I010")
				wf_icon_onoff(true,false,false,false,false,true,false,true,false)
			ELSE
				uo_status.st_message.text = f_message("I020")
				wf_icon_onoff(true,false,false,false,false,false,false,true,false)
			END IF
		else
			idw_80_dept.AcceptText()
			idw_80_dept.SetItemStatus(1,0,Primary!,DataModified!)
			IF f_mandantory_chk(idw_80_dept) = -1 THEN Return
			IF idw_80_dept.AcceptText() = -1 THEN
				messagebox('Ȯ��','�������� ������ ��ȸ�ϼ���!',Exclamation!)
				Return
			END IF
		
			ls_stcd        = trim(idw_80_dept.object.stcd[1])  
			ls_devicegubun = trim(idw_80_dept.object.devicegubun[1])  
			ls_dept			= trim(idw_80_dept.object.dept[1])  
			
			IF IsNull(ls_stcd) OR ls_stcd = '' THEN
				ls_stcd = '%'
			ELSE
				ls_stcd = ls_stcd + '%'
			END IF
			
			IF IsNull(ls_devicegubun) OR ls_devicegubun = '' THEN
				ls_devicegubun = '%'
			ELSE
				ls_devicegubun = ls_devicegubun + '%'
			END IF
			
			IF IsNull(ls_dept) OR ls_dept = '' THEN
				ls_dept = '%'
			ELSE
				ls_dept = ls_dept + '%'
			END IF
			
			idw_81.Reset()
			idw_81_print.Reset()
			
			IF idw_81.Retrieve(ls_stcd, ls_devicegubun, ls_dept) > 0 THEN
				uo_status.st_message.text = string(idw_81.rowcount()) + " ���� ������ " + f_message("I010")
				wf_icon_onoff(true,false,false,false,false,true,false,true,false)
				tab_1.tabpage_8.pb_print.visible	= true
				tab_1.tabpage_8.pb_print.enabled	= true
				tab_1.tabpage_8.pb_excel.visible	= true
				tab_1.tabpage_8.pb_excel.enabled	= true
				idw_81_print.Retrieve(ls_stcd, ls_devicegubun, ls_dept)
			ELSE
				uo_status.st_message.text = f_message("I020")
				wf_icon_onoff(true,false,false,false,false,false,false,true,false)
				tab_1.tabpage_8.pb_print.visible	= false
				tab_1.tabpage_8.pb_print.enabled	= false
				tab_1.tabpage_8.pb_excel.visible	= false
				tab_1.tabpage_8.pb_excel.enabled	= false
			END IF
			
		end if
		
	////////////////////////////////////////////////////////////////////////
	//Notes DB����
	CASE 9
		
		idw_91.Reset()
		
		IF idw_91.Retrieve() > 0 THEN
			uo_status.st_message.text = f_message("I010")
			wf_icon_onoff(true,false,true,false,false,false,false,true,false)
		ELSE
			uo_status.st_message.text = f_message("I020")
			wf_icon_onoff(true,false,false,false,false,false,false,true,false)
		END IF
		
	////////////////////////////////////////////////////////////////////////	
	CASE 10
		
		idw_ip.Reset()
		
		IF g_s_empno = 'ADMIN' THEN
			ls_dept = '%'
		ELSE
			SELECT PEDEPT
			INTO :ls_dept
			FROM PBCOMMON.DAC003
			WHERE PEEMPNO = :g_s_empno ;
		
			
			IF SQLCA.SQLCode <> 0 THEN
				messageBox("Ȯ��","�μ��� �������� �ʴ� ����Դϴ�. ")
				Return
			END IF
			
			SELECT "PBCOMMON"."DAC002"."COITNAME"  
			INTO :ls_deptName
			FROM "PBCOMMON"."DAC002"  
			WHERE ( "PBCOMMON"."DAC002"."COMLTD" = '01' ) AND  
					( "PBCOMMON"."DAC002"."COGUBUN" = 'DAC150' ) AND
					( "PBCOMMON"."DAC002"."COCODE" = :ls_dept ) ;
			
			IF SQLCA.SQLCode <> 0 THEN
				messageBox("Ȯ��","�μ��̸��� �����ü� �����ϴ�.")
				Return
			END IF 
			
			ls_dept = Mid(ls_dept,1,2) + '%'
			
		END IF
		
		IF idw_ip.Retrieve(ls_dept) > 0 THEN
			uo_status.st_message.text = f_message("I010")
			wf_icon_onoff(true,false,true,false,false,true,false,true,false)
		ELSE
			uo_status.st_message.text = f_message("I020")
			wf_icon_onoff(true,false,false,false,false,false,false,true,false)
		END IF
	CASE 11
		
		idw_111.Reset()
		
		IF idw_111.Retrieve() > 0 THEN
			uo_status.st_message.text = f_message("I010")
			wf_icon_onoff(true,false,true,false,false,false,false,true,false)
		ELSE
			uo_status.st_message.text = f_message("I020")
			wf_icon_onoff(true,false,false,false,false,false,false,true,false)
		END IF		
END CHOOSE
setpointer(Arrow!)

end event

event ue_save;call super::ue_save;SetPointer(hourglass!)

String   ls_chgdt, ls_chgdt_bef, ls_chid, ls_asid, ls_asdt,ls_empno, &
			ls_xplant, ls_div, ls_dept, ls_devicegubun, ls_specgubun, &
		   ls_modelnm, ls_memory, ls_disk, ls_cdrwexist, ls_monitorsize, &
			ls_monitorgubun, ls_os, ls_empgubun, ls_empnm, ls_stcd, ls_comment, &
			ls_xplant_bef, ls_div_bef, ls_dept_bef, ls_cogubun, &
			ls_swlgubun, ls_swvgubun, ls_serialkey, ls_purdt, ls_swnm, ls_swkey, &
			ls_swkey_serl, ls_yy, ls_mm, ls_usbexist, ls_swnm_bef, ls_chid_bef, &
			ls_usingip
Long     ll_row, ll_rcnt, ll_row_cnt
Integer  li_rtn, ii, li_cnt, ii_temp

CHOOSE CASE ii_tabindex
	//UPLOAD	
	CASE 1
		idw_11.AcceptText()
		
		IF idw_11.DataObject = 'd_aut322u_11' THEN
			/*
			IF f_mandantory_chk(idw_10) = -1 THEN Return  
			
			ls_chgdt = trim(idw_10.object.chgdt[1])
			
			//����� ����.
			DELETE FROM PBCOMMON.COMM810 
			WHERE COMLTD = '01' AND
					CHGDT  = :ls_chgdt ;
			
			IF SQLCA.SQLCode <> 0 THEN
				MessageBox("Ȯ��(COMM810)", &
				           "������ �����͸� ������ ���߽��ϴ�.~r" + &
							  "���ε� �۾��� �Ͻ� �� �����ϴ�!!!")
				Return
			END IF
			
			DELETE FROM PBCOMMON.COMM811 
			WHERE COMLTD = '01' and
					CHGDT  = :ls_chgdt ;
			
			IF SQLCA.SQLCode <> 0 THEN
				MessageBox("Ȯ��(COMM811)", &
				           "������ �����͸� ������ ���߽��ϴ�.~r" + &
							  "���ε� �۾��� �Ͻ� �� �����ϴ�!!!")
				Return
			END IF
			////////////////////////////////////////////
			*/
			FOR ii = 1 TO idw_11.RowCount()
				
				ls_chid    = idw_11.object.chid[ii]
				ls_chgdt   = idw_11.object.chgdt[ii]
				ls_xplant  = idw_11.object.xplant[ii]
				ls_div     = idw_11.object.div[ii]
				ls_dept    = idw_11.object.dept[ii]
				ls_comment = idw_11.object.comment[ii]
				
				SELECT CHID
				INTO   :ls_chid
				FROM PBCOMMON.COMM810
				WHERE COMLTD = '01' AND
						CHID   = :ls_chid ;
				
				//�ش� ����ȣ�� �����Ƿ� �ٽ�Ȯ���ؼ� ���ε�.		
				IF SQLCA.SQLCode = 0 THEN
					MessageBox("Ȯ��","���ε� �ڷ��� ����ȣ:" + &
								  ls_chid + " �� �̹� �����մϴ�.~r" + &
								  "�ش� ������ ������ �ٽ� �۾��Ͻʽÿ�.")
					Return
				END IF
				//�� �÷��� �ڸ����� üũ�ؾ� ������...���ŷο���...
				
				//History �� ���������� Setting
				idw_12.InsertRow(ii)
				idw_12.object.comltd[ii]   = '01'
				idw_12.object.chid[ii]     = ls_chid
				idw_12.object.chgdt[ii]    = ls_chgdt
				idw_12.object.fxplant[ii]  = ls_xplant
				idw_12.object.fdiv[ii]     = ls_div
				idw_12.object.fdept[ii]    = ls_dept
				idw_12.object.txplant[ii]  = ls_xplant
				idw_12.object.tdiv[ii]     = ls_div
				idw_12.object.tdept[ii]    = ls_dept
				idw_12.object.comment[ii]  = ls_comment
				idw_12.object.inptid[ii]   = g_s_empno
				idw_12.object.inptdt[ii]   = g_s_date
				idw_12.object.updtid[ii]   = ''
				idw_12.object.updtdt[ii]   = ''
				idw_12.object.ipaddr[ii]   = ''
				idw_12.object.macaddr[ii]  = ''
				
			NEXT
			uo_status.st_message.text = "�������Դϴ�..."
			IF idw_11.RowCount() > 0 THEN
			
				f_null_chk(idw_11)
				f_inptid(idw_11)
				f_null_chk(idw_12)
				f_inptid(idw_12)
				
				li_rtn = idw_11.Update()                            
		
				IF li_rtn = 1 THEN
					
					//History�� �����ؾ� �Ѵ�.
					idw_12.Update()
					COMMIT USING SQLCA;
					uo_status.st_message.text = f_message('U010')    //����Ǿ����ϴ�.
				ELSE
					ROLLBACK USING SQLCA;
					uo_status.st_message.text = f_message("U020")	// [�������] �����ý��������� �����ٶ��ϴ�. 
				END IF	
			ELSE
				MessageBox("Ȯ��","Upload �� �ڷᰡ �����ϴ�.",Exclamation!)
				Return
			END IF
			
		ELSEIF idw_11.DataObject = 'd_aut322u_12' THEN
			/*
			IF f_mandantory_chk(idw_10) = -1 THEN Return  
			
			ls_chgdt = trim(idw_10.object.chgdt[1])
			
			//����� ����.
			DELETE FROM PBCOMMON.COMM812 
			WHERE COMLTD = '01' AND
					CHGDT  = :ls_chgdt;
			
			IF SQLCA.SQLCode <> 0 THEN
				MessageBox("Ȯ��(COMM812)", &
				           "������ �����͸� ������ ���߽��ϴ�.~r" + &
							  "���ε� �۾��� �Ͻ� �� �����ϴ�!!!")
				Return
			END IF
			/////////////////////////////////////////////////////
			*/
			
			ls_yy = Mid(g_s_date,4,1)
			ls_mm = Mid(g_s_date,5,2)
			IF uf_com000_swkey(ls_yy, ls_mm, ls_swkey_serl) = -1 THEN RETURN 
			FOR ii = 1 TO idw_11.RowCount()
				//Setting 
				idw_11.SetItem(ii,"swkey",ls_yy + ls_mm + String((DEC(ls_swkey_serl) + ii - 1),"000000"))
			NEXT
			
			uo_status.st_message.text = "�������Դϴ�..."
			
			IF idw_11.RowCount() > 0 THEN
			
				f_null_chk(idw_11)
				f_inptid(idw_11)
				
				li_rtn = idw_11.Update()                            
		
				IF li_rtn = 1 THEN
					COMMIT USING SQLCA;
					uo_status.st_message.text = f_message('U010')    //����Ǿ����ϴ�.
				ELSE
					ROLLBACK USING SQLCA;
					uo_status.st_message.text = f_message("U020")	// [�������] �����ý��������� �����ٶ��ϴ�. 
				END IF	
			ELSE
				MessageBox("Ȯ��","Upload �� �ڷᰡ �����ϴ�.",Exclamation!)
				Return
			END IF
		ELSEIF idw_11.DataObject = 'd_aut322u_13' THEN
			
			/*
			IF f_mandantory_chk(idw_10) = -1 THEN Return  
			
			ls_chgdt = trim(idw_10.object.chgdt[1])
			//����� ����.
			DELETE FROM PBCOMMON.COMM815 ;
			
			IF SQLCA.SQLCode <> 0 THEN
				MessageBox("Ȯ��(COMM815)", &
				           "������ �����͸� ������ ���߽��ϴ�.~r" + &
							  "���ε� �۾��� �Ͻ� �� �����ϴ�!!!")
				Return
			END IF
			/////////////////////////////////////////////////////
			*/
			uo_status.st_message.text = "�������Դϴ�..."
			IF idw_11.RowCount() > 0 THEN
			
				f_null_chk(idw_11)
				f_inptid(idw_11)
				
				li_rtn = idw_11.Update()                            
		
				IF li_rtn = 1 THEN
					COMMIT USING SQLCA;
					uo_status.st_message.text = f_message('U010')    //����Ǿ����ϴ�.
				ELSE
					ROLLBACK USING SQLCA;
					uo_status.st_message.text = f_message("U020")	// [�������] �����ý��������� �����ٶ��ϴ�. 
				END IF	
			ELSE
				MessageBox("Ȯ��","Upload �� �ڷᰡ �����ϴ�.",Exclamation!)
				Return
			END IF
		ELSEIF idw_11.DataObject = 'd_aut322u_14' THEN
			/*
			//���������� ����� ���� �Ѵ�.
			IF f_mandantory_chk(idw_10) = -1 THEN Return  
			
			ls_cogubun = trim(idw_10.object.cogubun[1])
			
			DELETE FROM PBCOMMON.DAC002 
			WHERE COMLTD  = '01' AND
					COGUBUN = :ls_cogubun ;
			
			IF SQLCA.SQLCode <> 0 THEN
				MessageBox("Ȯ��(DAC002:"+ls_cogubun+")", &
				           "������ �����͸� ������ ���߽��ϴ�.~r" + &
							  "���ε� �۾��� �Ͻ� �� �����ϴ�!!!")
				Return
			END IF
			/////////////////////////////////////////////////////
			*/
			uo_status.st_message.text = "�������Դϴ�..."
			
			IF idw_11.RowCount() > 0 THEN
			
				f_null_chk(idw_11)
				f_inptid(idw_11)
				
				li_rtn = idw_11.Update()                            
		
				IF li_rtn = 1 THEN
					COMMIT USING SQLCA;
					uo_status.st_message.text = f_message('U010')    //����Ǿ����ϴ�.
					wf_icon_onoff(true,false,true,false,false,false,false,true,false)	
				ELSE
					ROLLBACK USING SQLCA;
					uo_status.st_message.text = f_message("U020")	// [�������] �����ý��������� �����ٶ��ϴ�. 
					wf_icon_onoff(true,false,false,false,false,false,false,true,false)	
				END IF	
			ELSE
				MessageBox("Ȯ��","Upload �� �ڷᰡ �����ϴ�.",Exclamation!)
				Return
			END IF
		ELSE
			MessageBox("Ȯ��","���ε��� ������ �����찡 �߸� ���õǾ����ϴ�.")
			Return
		END IF
		
	///////////////////////////////////////////////////////////////////////////	
	//HW ���
	CASE 2
		IF idw_22.accepttext() = -1 THEN
			messagebox('Ȯ��','�������� ������ �����ϼ���!',Exclamation!)
			Return
		END IF
		
		IF idw_22.Modifiedcount() = 0 THEN
			messagebox('Ȯ��','����� ������ �����ϴ�!',Exclamation!)
			Return
		END IF
		
		IF f_mandantory_chk(idw_22) = -1 THEN Return        
		
		ls_chid         = trim(idw_22.object.chid[1])
		ls_chgdt        = trim(idw_22.object.chgdt[1])
		ls_asid         = trim(idw_22.object.asid[1])
		ls_asdt         = trim(idw_22.object.asdt[1])
		ls_xplant       = trim(idw_22.object.xplant[1])
		ls_div          = trim(idw_22.object.div[1])
		ls_dept         = trim(idw_22.object.dept[1])
		ls_devicegubun  = trim(idw_22.object.devicegubun[1])
		ls_specgubun    = trim(idw_22.object.specgubun[1])
		ls_modelnm      = trim(idw_22.object.modelnm[1])
		ls_memory       = trim(idw_22.object.memory[1])
		ls_disk         = trim(idw_22.object.disk[1])
		ls_cdrwexist    = trim(idw_22.object.cdrwexist[1])
		ls_monitorsize  = trim(idw_22.object.monitorsize[1])
		ls_monitorgubun = trim(idw_22.object.monitorgubun[1])
		ls_os           = trim(idw_22.object.os[1])
		ls_empgubun     = trim(idw_22.object.empgubun[1])
		ls_empno        = trim(idw_22.object.empno[1])
		ls_empnm        = trim(idw_22.object.empnm[1])
		ls_stcd         = trim(idw_22.object.stcd[1])
		ls_comment      = trim(idw_22.object.comment[1])
		
		ls_chgdt_bef    = idw_22.GetItemString(1,"chgdt", Primary!, True)
		ls_xplant_bef   = idw_22.GetItemString(1,"xplant", Primary!, True)
		ls_div_bef      = idw_22.GetItemString(1,"div", Primary!, True)
		ls_dept_bef     = idw_22.GetItemString(1,"dept", Primary!, True)
		
		//0, null, �Է��� Setting
		f_null_chk(idw_22)
		f_inptid(idw_22)
	
		IF idw_22.GetItemStatus(1,0,Primary!) = NewModified! THEN
			//�ߺ�üũ
			SELECT count(*) 
			INTO :ll_rcnt
			FROM  PBCOMMON.COMM810
			WHERE COMLTD = '01'
			AND   CHID   = :ls_chid ;
			
			IF ll_rcnt > 0 THEN
				MessageBox('Ȯ��','�Էµ� ����Դϴ�.',Exclamation!)
				Return
			END IF
			
			uo_status.st_message.text	= '�������Դϴ�...'
	
			IF idw_22.Update(true,false) = 1 THEN
			
				//History DB�� ���ο� ���� �ԷµǸ� ���� INSERT.
				INSERT INTO PBCOMMON.COMM811
				(SELECT COMLTD,CHID,CHGDT,XPLANT,DIV,DEPT,XPLANT,DIV,DEPT,
						  COMMENT,INPTID,INPTDT,UPDTID,UPDTDT,IPADDR,MACADDR
				FROM PBCOMMON.COMM810
				WHERE COMLTD = '01'      AND
						CHID   = :ls_chid ) ;
						
				IF SQLCA.SQLCode <> 0 THEN
					MessageBox("Database Error", &
								  "SQLCA.SQLErrText")
					Return	  
				END IF
				
				idw_22.resetupdate()
				COMMIT USING SQLCA;
				uo_status.st_message.text	=  f_message("U010")	// �ԷµǾ����ϴ�. 
			ELSE
				ROLLBACK USING SQLCA;
				uo_status.st_message.text	=  f_message("U020") // [�������] �����ý��������� �����ٶ��ϴ�.
			END IF
	//		triggerEvent("ue_retrieve")
			idw_21.Reset()
			idw_22.Reset()
			idw_23.Reset()
			idw_24.Reset()
			///�Է�,��ȸ,����
		ELSE
			//�������� ���� �������� ���� �ϸ� �ߺ��� �߻� �� �� �ִ�.
			IF ls_chgdt < ls_chgdt_bef THEN
				MessageBox("Ȯ��","�ٲ� �������� ���������� ���� Ŀ�� �մϴ�")
				Return
			END IF
			
			IF idw_22.update(true,false) = 1 THEN
			
				IF ls_chgdt <> ls_chgdt_bef THEN
					
					//��¥�� �����ϸ� INSERT.
					//History DB�� ���ο� ���� �ԷµǸ� ���� INSERT.
					INSERT INTO PBCOMMON.COMM811
					(SELECT COMLTD,CHID,CHGDT,:ls_xplant_bef,:ls_div_bef,
							  :ls_dept_bef,XPLANT,DIV,DEPT,
							  COMMENT,INPTID,INPTDT,UPDTID,UPDTDT,IPADDR,MACADDR
					FROM PBCOMMON.COMM810
					WHERE COMLTD = '01'      AND
							CHID   = :ls_chid ) ;
							
				ELSE			
					//��Ÿ������ �����ϸ� UPDATE		
					UPDATE PBCOMMON.COMM811
					SET FXPLANT  = :ls_xplant,
						 FDIV     = :ls_div,
						 FDEPT    = :ls_dept,
						 TXPLANT  = :ls_xplant,
						 TDIV     = :ls_div,
						 TDEPT    = :ls_dept,
						 COMMENT  = :ls_comment
					WHERE COMLTD = '01'          AND
							CHID   = :ls_chid      AND
							CHGDT  = :ls_chgdt_bef ;
					
				END IF
				
				IF SQLCA.SQLCode <> 0 THEN
					MessageBox("Database Error", &
								  SQLCA.SQLErrText)
					Return	  
				END IF
				
				////PBCOMMON.COMM812�� ����ڵ� ��ġ�ϴ� ���� ����/����/�μ� ����� ����
				UPDATE PBCOMMON.COMM812
				SET XPLANT  = :ls_xplant,
					 DIV     = :ls_div,
					 DEPT    = :ls_dept
				WHERE COMLTD = '01'          AND
						CHID   = :ls_chid      ;
				
				IF SQLCA.SQLCode <> 0 THEN
					IF SQLCA.SQLCode = 100 THEN
						MessageBox("Ȯ��", &
									  "�ش� ��� ��ġ�� SW�� ���" + & 
									  "SW DB�� ������Ʈ ���� �ʾҽ��ϴ�.")
					ELSE
						MessageBox("Database Error", &
									  SQLCA.SQLErrText)
						Return
					END IF
				END IF
				
				idw_22.resetupdate()
				commit using sqlca;
				uo_status.st_message.text	=  f_message("U010")	// �ԷµǾ����ϴ�. 
			ELSE
				rollback using sqlca;
				uo_status.st_message.text	=  f_message("U020") // [�������] �����ý��������� �����ٶ��ϴ�.
			END IF
	//		triggerEvent("ue_retrieve")
			idw_21.Reset()
			idw_22.Reset()
			idw_23.Reset()
			idw_24.Reset()
		END IF
		wf_icon_onoff(true, true, false, false, false, false, false, false, false)   
		
	///////////////////////////////////////////////////////////////////////////	
	//HW�����ͼ���
	CASE 3
		IF idw_32.accepttext() = -1 THEN
			messagebox('Ȯ��','�������� ������ �����ϼ���!',Exclamation!)
			Return
		END IF
		
		IF idw_32.Modifiedcount() = 0 THEN
			messagebox('Ȯ��','����� ������ �����ϴ�!',Exclamation!)
			Return
		END IF
		
		IF f_mandantory_chk(idw_32) = -1 THEN Return        
		
		ls_chid         = trim(idw_32.object.chid[1])
		ls_chgdt        = idw_32.GetItemString(1,"chgdt")
		ls_chgdt_bef    = idw_32.GetItemString(1,"chgdt", Primary!, True)
		ls_asid         = trim(idw_32.object.asid[1])
		ls_asdt         = trim(idw_32.object.asdt[1])
		ls_xplant       = trim(idw_32.object.xplant[1])
		ls_xplant_bef   = idw_32.GetItemString(1,"xplant", Primary!, True)
		ls_div          = trim(idw_32.object.div[1])
		ls_div_bef      = idw_32.GetItemString(1,"div", Primary!, True)
		ls_dept         = trim(idw_32.object.dept[1])
		ls_dept_bef     = idw_32.GetItemString(1,"dept", Primary!, True)
		ls_devicegubun  = trim(idw_32.object.devicegubun[1])
		ls_specgubun    = trim(idw_32.object.specgubun[1])
		ls_modelnm      = trim(idw_32.object.modelnm[1])
		ls_memory       = trim(idw_32.object.memory[1])
		ls_disk         = trim(idw_32.object.disk[1])
		ls_cdrwexist    = trim(idw_32.object.cdrwexist[1])
		ls_monitorsize  = trim(idw_32.object.monitorsize[1])
		ls_monitorgubun = trim(idw_32.object.monitorgubun[1])
		ls_os           = trim(idw_32.object.os[1])
		ls_empgubun     = trim(idw_32.object.empgubun[1])
		ls_empnm        = trim(idw_32.object.empnm[1])
		ls_stcd         = trim(idw_32.object.stcd[1])
		ls_comment      = trim(idw_32.object.comment[1])
			
		uo_status.st_message.text	= '�������Դϴ�...'
		
		//0, null, �Է��� Setting
		f_null_chk(idw_32)
		f_inptid(idw_32)
		
		//�������� ���� �������� ���� �ϸ� �ߺ��� �߻� �� �� �ִ�.
		IF ls_chgdt < ls_chgdt_bef THEN
			MessageBox("Ȯ��","�ٲ� �������� ���������� ���� Ŀ�� �մϴ�")
			Return
		END IF
		
		IF idw_32.update(true,false) = 1 THEN
		
			IF ls_chgdt <> ls_chgdt_bef THEN
				
				//��¥�� �����ϸ� INSERT.
				//History DB�� ���ο� ���� �ԷµǸ� ���� INSERT.
				INSERT INTO PBCOMMON.COMM811
				(SELECT COMLTD,CHID,CHGDT,:ls_xplant_bef,:ls_div_bef,
					     :ls_dept_bef,XPLANT,DIV,DEPT,
						  COMMENT,INPTID,INPTDT,UPDTID,UPDTDT,IPADDR,MACADDR
				FROM PBCOMMON.COMM810
				WHERE COMLTD = '01'      AND
						CHID   = :ls_chid ) ;
						
			ELSE			
				//��Ÿ������ �����ϸ� UPDATE		
				UPDATE PBCOMMON.COMM811
				SET FXPLANT  = :ls_xplant,
					 FDIV     = :ls_div,
					 FDEPT    = :ls_dept,
					 TXPLANT  = :ls_xplant,
					 TDIV     = :ls_div,
					 TDEPT    = :ls_dept,
					 COMMENT  = :ls_comment
				WHERE COMLTD = '01'          AND
						CHID   = :ls_chid      AND
						CHGDT  = :ls_chgdt_bef ;
				
			END IF
			
			IF SQLCA.SQLCode <> 0 THEN
				MessageBox("Database Error", &
							  SQLCA.SQLErrText)
				Return	  
			END IF
			
			////PBCOMMON.COMM812�� ����ڵ� ��ġ�ϴ� ���� ����/����/�μ� ����� ����
			UPDATE PBCOMMON.COMM812
			SET XPLANT  = :ls_xplant,
				 DIV     = :ls_div,
				 DEPT    = :ls_dept
			WHERE COMLTD = '01'          AND
					CHID   = :ls_chid      ;
			
			IF SQLCA.SQLCode <> 0 THEN
				IF SQLCA.SQLCode = 100 THEN
					MessageBox("Ȯ��", &
								  "�ش� ��� ��ġ�� SW�� ���" + & 
								  "SW DB�� ������Ʈ ���� �ʾҽ��ϴ�.")
				ELSE
					MessageBox("Database Error", &
								  SQLCA.SQLErrText)
					Return
				END IF
			END IF
			
			idw_32.resetupdate()
			commit using sqlca;
			uo_status.st_message.text	=  f_message("U010")	// �ԷµǾ����ϴ�. 
		ELSE
			rollback using sqlca;
			uo_status.st_message.text	=  f_message("U020") // [�������] �����ý��������� �����ٶ��ϴ�.
		END IF
//		triggerEvent("ue_retrieve")
		idw_31.Reset()
		idw_32.Reset()
		idw_33.Reset()
		///�Է�,��ȸ,����
		wf_icon_onoff(true, false, false, false, false,false, false, false, false)   
	///////////////////////////////////////////////////////////////////////////	
	//SW ���
	CASE 4
		IF idw_42.accepttext() = -1 THEN
			messagebox('Ȯ��','�������� ������ �����ϼ���!',Exclamation!)
			Return
		END IF
		
		IF idw_42.Modifiedcount() = 0 THEN
			messagebox('Ȯ��','����� ������ �����ϴ�!',Exclamation!)
			Return
		END IF
		
		IF f_mandantory_chk(idw_42) = -1 THEN Return        
		
		uo_status.st_message.text	= '�������Դϴ�...'
		
		//0, null, �Է��� Setting
		f_null_chk(idw_42)
		f_inptid(idw_42)
		
		IF idw_42.Update(true,false) = 1 THEN

			idw_42.resetupdate()
			COMMIT USING SQLCA;
			uo_status.st_message.text	=  f_message("U010")	// �ԷµǾ����ϴ�. 
		ELSE
			ROLLBACK USING SQLCA;
			uo_status.st_message.text	=  f_message("U020") // [�������] �����ý��������� �����ٶ��ϴ�.
		END IF
//		triggerEvent("ue_retrieve")
		idw_41.Reset()
		idw_42.Reset()
		idw_43.Reset()
		///�Է�,��ȸ,����
		wf_icon_onoff(true, true, true, true, false, false, false, false, false)   
	CASE 5
		MessageBox("Ȯ��","���� �� �� ���� ���Դϴ�.")
		Return
	///////////////////////////////////////////////////////////////////////////	
	//////SW ��������	
	CASE 6
		IF idw_62.accepttext() = -1 THEN
			messagebox('Ȯ��','�������� ������ �����ϼ���!',Exclamation!)
			Return
		END IF
		
		IF idw_62.Modifiedcount() = 0 THEN
			messagebox('Ȯ��','����� ������ �����ϴ�!',Exclamation!)
			Return
		END IF
		
		IF f_mandantory_chk(idw_62) = -1 THEN Return        
		
		uo_status.st_message.text	= '�������Դϴ�...'
		
		//0, null, �Է��� Setting
		f_null_chk(idw_62)
		f_inptid(idw_62)
		
		IF idw_62.Update(true,false) = 1 THEN
			idw_62.resetupdate()
			COMMIT USING SQLCA;
			uo_status.st_message.text	=  f_message("U010")	// �ԷµǾ����ϴ�. 
		ELSE
			ROLLBACK USING SQLCA;
			uo_status.st_message.text	=  f_message("U020") // [�������] �����ý��������� �����ٶ��ϴ�.
		END IF
//		triggerEvent("ue_retrieve")
		idw_61.Reset()
		idw_62.Reset()
		///�Է�,��ȸ,����
		wf_icon_onoff(true, true, false, false, false, false, false, false, false)   
		
	///////////////////////////////////////////////////////////////////////////	
	//////�����ڵ����	
	CASE 7
		IF idw_72.accepttext() = -1 THEN
			messagebox('Ȯ��','�������� ������ �����ϼ���!',Exclamation!)
			Return
		END IF
		
		IF idw_72.Modifiedcount() = 0 THEN
			messagebox('Ȯ��','����� ������ �����ϴ�!',Exclamation!)
			Return
		END IF
		
		IF f_mandantory_chk(idw_72) = -1 THEN Return        
		
		uo_status.st_message.text	= '�������Դϴ�...'
		
		//0, null, �Է��� Setting
		f_null_chk(idw_72)
		f_inptid(idw_72)
		
		IF idw_72.Update(true,false) = 1 THEN
			idw_72.resetupdate()
			COMMIT USING SQLCA;
			uo_status.st_message.text	=  f_message("U010")	// �ԷµǾ����ϴ�. 
		ELSE
			ROLLBACK USING SQLCA;
			uo_status.st_message.text	=  f_message("U020") // [�������] �����ý��������� �����ٶ��ϴ�.
		END IF
//		triggerEvent("ue_retrieve")
		idw_71.Reset()
		idw_72.Reset()
		///�Է�,��ȸ,����
		wf_icon_onoff(true, true, false, false, false, false, false, false, false)   
		
	CASE 9
		//TEMP DB�� ������ ����� ����.
		DELETE FROM PBCOMMON.COMM816 ;
		
		IF SQLCA.SQLCode <> 0 THEN
			MessageBox("Ȯ��","Temp Table ������ ������ ������ �߻��߽��ϴ�.")
			Return
		END IF
		
		Tab_1.TabPage_9.hpb_1.Position = 0
		ll_row_cnt = idw_91.RowCount()
		
		uo_status.st_message.text	= 'DB �������Դϴ�...'
		
		FOR ii = 1 TO idw_91.RowCount()
//			idw_91.selectRow(ii)
			//COMM810,COMM812 join�ؼ� ���� �����´�.
			ls_swkey        = trim(idw_91.object.swkey[ii])
			ls_chid         = trim(idw_91.object.chid[ii])
			ls_xplant       = trim(idw_91.object.xplant[ii])
			ls_div          = trim(idw_91.object.div[ii])
			ls_dept         = trim(idw_91.object.dept[ii])
			
			ls_asid         = trim(idw_91.object.asid[ii])
			ls_asdt         = trim(idw_91.object.asdt[ii])
			ls_devicegubun  = trim(idw_91.object.devicegubun[ii])
			ls_modelnm      = trim(idw_91.object.modelnm[ii])
			ls_memory       = trim(idw_91.object.memory[ii])
			ls_disk         = trim(idw_91.object.disk[ii])
			ls_cdrwexist    = trim(idw_91.object.cdrwexist[ii])
			ls_usbexist     = trim(idw_91.object.usbexist[ii])
			ls_monitorsize  = trim(idw_91.object.monitorsize[ii])
			ls_monitorgubun = trim(idw_91.object.monitorgubun[ii])
			ls_os           = trim(idw_91.object.os[ii])
			ls_empnm        = trim(idw_91.object.empnm[ii])
			ls_swnm         = trim(idw_91.object.swnm[ii])
			ls_stcd         = trim(idw_91.object.stcd[ii])
			ls_empgubun     = trim(idw_91.object.empgubun[ii])
			ls_usingip      = trim(idw_91.object.usingip[ii])
			ls_empno	       = trim(idw_91.object.empno[ii])
			
			//�� �������� ����ȣ�� ���ٸ� SWNM�� ��Ī�� ��� ���δ�.
			//�̷��� �ϴ� ������ �������� ����ϱ� ���ϰ� �ϱ� ���ؼ�.
			IF ii >= 2 THEN
				ii_temp         = ii - 1
				ls_chid_bef     = trim(idw_91.object.chid[ii_temp])
			END IF
			//������ ���簡 �ٸ��ٴ� ���� ���ο� ����ȣ�̴�.
			//�������� : ����,����,�μ�,����ȣ,SW��Ī �����̴�.
			//���� ����ȣ�� ������ ����/����/�μ��� �ٸ������Ͱ� �ִٸ�.
			//������ �����̴�.
			IF ls_chid <> ls_chid_bef THEN
				//������̱⶧���� ������ �Էµȴ�.
				idw_92.InsertRow(ii)
				idw_92.object.swkey[ii]        = ls_swkey
				idw_92.object.chid[ii]         = ls_chid
				idw_92.object.asid[ii]         = ls_asid
				idw_92.object.asdt[ii]         = ls_asdt
				idw_92.object.xplant[ii]       = ls_xplant
				idw_92.object.div[ii]          = ls_div
				idw_92.object.dept[ii]         = ls_dept
				idw_92.object.devicegubun[ii]  = ls_devicegubun
				idw_92.object.modelnm[ii]      = ls_modelnm
				idw_92.object.memory[ii]       = ls_memory
				idw_92.object.disk[ii]         = ls_disk
				idw_92.object.cdrwexist[ii]    = ls_cdrwexist
				idw_92.object.usbexist[ii]     = ls_usbexist
				idw_92.object.monitorsize[ii]  = ls_monitorsize
				idw_92.object.monitorgubun[ii] = ls_monitorgubun
				idw_92.object.os[ii]           = ls_os
				idw_92.object.empnm[ii]        = ls_empnm
				idw_92.object.swnmtemp[ii]     = ls_swnm
				idw_92.object.empgubun[ii]     = ls_empgubun
				idw_92.object.usingip[ii]      = ls_usingip
				idw_92.object.empno[ii]        = ls_empno				
			ELSE
				ls_swnm_bef     = trim(idw_92.object.swnmtemp[ii_temp])
				//������ �ִ°Ŵϱ�. �������� �����.
				idw_92.DeleteRow(ii_temp)
				//�ٽ� InsertRow�ؼ� SWNM�� ���� ������ �ٿ���.
				idw_92.InsertRow(ii)
				idw_92.object.swkey[ii]        = ls_swkey
				idw_92.object.chid[ii]         = ls_chid
				idw_92.object.asid[ii]         = ls_asid
				idw_92.object.asdt[ii]         = ls_asdt
				idw_92.object.xplant[ii]       = ls_xplant
				idw_92.object.div[ii]          = ls_div
				idw_92.object.dept[ii]         = ls_dept
				idw_92.object.devicegubun[ii]  = ls_devicegubun
				idw_92.object.modelnm[ii]      = ls_modelnm
				idw_92.object.memory[ii]       = ls_memory
				idw_92.object.disk[ii]         = ls_disk
				idw_92.object.cdrwexist[ii]    = ls_cdrwexist
				idw_92.object.usbexist[ii]     = ls_usbexist
				idw_92.object.monitorsize[ii]  = ls_monitorsize
				idw_92.object.monitorgubun[ii] = ls_monitorgubun
				idw_92.object.os[ii]           = ls_os
				idw_92.object.empnm[ii]        = ls_empnm
				idw_92.object.swnmtemp[ii]     = ls_swnm_bef + "," + ls_swnm
				idw_92.object.empgubun[ii]     = ls_empgubun
				idw_92.object.usingip[ii]      = ls_usingip
				idw_92.object.empno[ii]        = ls_empno								
			END IF
			idw_91.SelectRow(ii,true)
			idw_91.ScrollToRow(ii)
			Tab_1.TabPage_9.hpb_1.Position = (ii / ll_row_cnt) * 100
		NEXT
		
		f_null_chk(idw_92)
		IF idw_92.Update(true,false) = 1 THEN
			idw_92.resetupdate()
			COMMIT USING SQLCA;
			uo_status.st_message.text	=  f_message("U010")	// �ԷµǾ����ϴ�. 
			wf_icon_onoff(true, false, true, false, false, true, false, false, false)   
		ELSE
			ROLLBACK USING SQLCA;
			uo_status.st_message.text	=  f_message("U020") // [�������] �����ý��������� �����ٶ��ϴ�.
			wf_icon_onoff(true, false, true, false, false, false, false, false, false)   
		END IF
		
	CASE 10
		idw_ip.AcceptText()
		
		/*
		IF idw_ip.Modifiedcount() = 0 THEN
			messagebox('Ȯ��','����� ������ �����ϴ�!',Exclamation!)
			Return
		END IF
		*/ 
		Int	jj
		
		//����
		String 	ls_ip[], data
		Long		ll_ip[], ll_pos, ll_length, ll_temp_pos[]
		
		FOR jj = 1 To idw_ip.RowCount()
		
			IF idw_ip.GetItemStatus(ii,0,Primary!) = DataModified! THEN 
				
				data = Trim(idw_ip.GetItemString(jj,'usingip'))
				
				//�ʱ�ȭ.
				li_cnt = 0 
				ll_pos = 0
				
				////////////////////üũ �Ϲ�////////////////////////////////
				//���� üũ
				IF Len(data) >= 1 AND Len(data) < 7 THEN
					MessageBox("Error", "IP �ּҰ� �߸��Ǿ����ϴ� : " + &
									"IP�� �ּ� ���̴� 7 ���� Ů�ϴ�.( ex: 1.0.1.1 )")
					Return 1
				END IF
				
				IF Len(data) > 15 THEN
					MessageBox("Error", "IP �ּҰ� �߸��Ǿ����ϴ� : " + &
									"�� IP���̰� 15 ���� Ŭ ���� �����ϴ�.")
					Return 1
				END IF
				
				//.�� ���� ���´ٰ� ����...
				FOR ii = 1 TO 4
					
					ll_pos = Pos(data, ".", ll_pos + 1)
					
					IF ll_pos <> 0 THEN
						li_cnt++
						
					END IF
				NEXT
				
				IF li_cnt <> 3 THEN
					MessageBox("Error", "IP �ּҰ� �߸��Ǿ����ϴ� : " + & 
									"������ '.' �� ���� �־�� �ùٸ� IP �Դϴ�.")
					Return 1
				END IF
				//////////////////////////////////////////////////////////////
				
				ll_pos = 0
				
				FOR ii = 1 TO 4
					ll_pos = Pos(data, ".", ll_pos + 1)
					
					ll_temp_pos[ii] = ll_pos
					
					IF ll_pos <> 0 THEN
						
						IF ii = 1 THEN
							ls_ip[ii] = Mid(data,ii,(ll_temp_pos[ii] - 1))
						ELSEIF ii = 2 THEN
							ls_ip[ii] = Mid(data,(ll_temp_pos[ii - 1] + 1), (ll_temp_pos[ii] - ll_temp_pos[ii - 1] - 1))
						ELSEIF ii = 3 THEN
							ls_ip[ii] = Mid(data,(ll_temp_pos[ii - 1] + 1), (ll_temp_pos[ii] - ll_temp_pos[ii - 1] - 1))	
						
						ELSE
							EXIT
						END IF
					ELSE
						IF ii = 4 THEN
							ls_ip[ii] = MId(data,(ll_temp_pos[ii - 1] + 1), (Len(data) - ll_temp_pos[ii - 1] )) 
						ELSE
							EXIT
						END IF
					END IF
					
					//MessageBox("Ȯ��",String(ll_pos) + " : " +ls_ip[ii] + " : " + String(Len(data)))
					
					IF Len(ls_ip[ii]) <= 0 THEN
						MessageBox("Error", "IP �ּҰ� �߸��Ǿ����ϴ� : " + & 
										".������ ������ ���̴� 0 ���� Ŀ�� �մϴ�.")
						Return 1	
					END IF	
					
					IF Len(ls_ip[ii]) > 3 THEN
						MessageBox("Error", "IP �ּҰ� �߸��Ǿ����ϴ� : " + &  
										".������ ������ ���̴� 3 ���� �۾ƾ� �մϴ�.")
						Return 1	
					END IF
					
					IF Len(ls_ip[ii]) = 2 THEN
						IF Mid(ls_ip[ii],1,1) = '0' THEN
							MessageBox("Error", "IP �ּҰ� �߸��Ǿ����ϴ� : " + & 
											"ù��° �ڸ��� ���ڴ� 0 �� �� �����ϴ�.")
							Return 1	
						END IF
					END IF
					
					IF Len(ls_ip[ii]) = 3 THEN
						
						IF Mid(ls_ip[ii],1,1) = '0' THEN
		
							MessageBox("Error", "IP �ּҰ� �߸��Ǿ����ϴ� : " + &
											"ù��° �ڸ��� ���ڴ� 0 �� �� �����ϴ�.")
							Return 1	
						END IF
					END IF	
					
					
					IF isNumber(ls_ip[ii]) = FALSE THEN
						MessageBox("Error", "IP �ּҰ� �߸��Ǿ����ϴ� : " + & 
										"IP�� �����̾�� �մϴ�.")
						Return 1
					ELSE
						ll_ip[ii] = Long(ls_ip[ii])
						
						IF ll_ip[ii] > 255 OR ll_ip[ii] < 0 THEN
							MessageBox("Error", "IP �ּҰ� �߸��Ǿ����ϴ� : " + & 
										"IP�� 0 �� 255 ������ ���̾�� �մϴ�.")
							Return 1
						END IF
					END IF
					
				NEXT
			ELSE
				//messageBox("","not datamodified")
			END IF	
			
		NEXT
		
		//IF f_mandantory_chk(idw_ip) = -1 THEN Return
		
		//0, null, �Է��� Setting
		f_null_chk(idw_ip)
		f_inptid(idw_ip)
		
		uo_status.st_message.text	= '�������Դϴ�...'
	
		IF idw_ip.Update(true,false) = 1 THEN
			
			idw_ip.resetupdate()
			COMMIT USING SQLCA;
			triggerEvent("ue_retrieve")
			uo_status.st_message.text	=  f_message("U010")	// �ԷµǾ����ϴ�. 
		ELSE
			ROLLBACK USING SQLCA;
			uo_status.st_message.text	=  f_message("U020") // [�������] �����ý��������� �����ٶ��ϴ�.
		END IF
		
		//triggerEvent("ue_retrieve")
		
		wf_icon_onoff(true, false, true, false, false, false, false, false, false)  
		
	///////////////////////////////////////////////////////////////////////////
	CASE 11
		f_sysdate()
		ii = 0
		ll_row_cnt 	= 0 
		ll_row_cnt	= idw_111.rowcount()
		for	ii	=	1	to	ll_row_cnt
			ls_chid        = trim(idw_111.object.chid[ii])
			ls_chgdt       = trim(idw_111.object.chgdt[ii])
			ls_dept        = trim(idw_111.object.dept[ii])
			ls_dept_bef    = trim(idw_111.object.pedept[ii])

			update PBCOMMON.COMM810
			set chgdt 	=	:g_s_date,	dept		=	:ls_dept_bef,
 				 updtid 	=	:g_s_empno,	updtdt	=	:g_s_datetime,
				 ipaddr	=	:g_s_ipaddr,macaddr	=	:g_s_macaddr
			where COMLTD = '01'          AND
					CHID   = :ls_chid      
			using sqlca ;
			if sqlca.sqlnrows <> 1 then
				continue
			end if
			
			IF ls_chgdt <> g_s_date THEN
				INSERT INTO PBCOMMON.COMM811
				(SELECT COMLTD,CHID,CHGDT,XPLANT,DIV,
						  :ls_dept,XPLANT,DIV,:ls_dept_bef,
						  COMMENT,UPDTID,UPDTDT,UPDTID,UPDTDT,IPADDR,MACADDR
				FROM PBCOMMON.COMM810
				WHERE COMLTD = '01'      AND
						CHID   = :ls_chid ) ;
			ELSE			
				//��Ÿ������ �����ϸ� UPDATE		
				UPDATE PBCOMMON.COMM811
				SET 	TDEPT    = 	:ls_dept_bef,
 				 		updtid 	=	:g_s_empno,	updtdt	=	:g_s_datetime,
				 		ipaddr	=	:g_s_ipaddr,macaddr	=	:g_s_macaddr
				WHERE COMLTD = '01'          AND
						CHID   = :ls_chid      AND
						CHGDT  = :ls_chgdt ;
				
			END IF
			////PBCOMMON.COMM812�� ����ڵ� ��ġ�ϴ� ���� ����/����/�μ� ����� ����
			UPDATE PBCOMMON.COMM812
			SET 	DEPT    	= 	:ls_dept_bef,
 				 	updtid 	=	:g_s_empno,	updtdt	=	:g_s_datetime,
				 	ipaddr	=	:g_s_ipaddr,macaddr	=	:g_s_macaddr
			WHERE COMLTD = '01'          AND
					CHID   = :ls_chid    
			USING SQLCA ;
		next	
		triggerEvent("ue_retrieve")
		uo_status.st_message.text	=  "�μ������� �Ϸ�Ǿ����ϴ�"
		wf_icon_onoff(true, true, false, false, false, false, false, false, false)  
END CHOOSE		

end event

event ue_insert;call super::ue_insert;string 	ls_gubun, ls_coitname, ls_cogubun, ls_swnm, ls_yy, ls_mm, ls_swkey_serl, &
       	ls_xplant, ls_div, ls_dept, ls_devicegubun, ls_specgubun, ls_empgubun, &
		 	ls_stcd, ls_fchgdt, ls_tchgdt
long		ln_rows

CHOOSE CASE ii_tabindex
	//UPLOAD	
	CASE 1
		MessageBox("Ȯ��","�Է��Ͻ� �� ���� ���Դϴ�.")
		Return
	//HW ���	
	CASE 2
		////
		idw_20.Object.fchgdt.Background.Color = 15780518         //�ʼ�, �ϴû�
		idw_20.Object.tchgdt.Background.Color = 15780518         //�ʼ�, �ϴû�

		idw_20.AcceptText()
		
		idw_20.SetItemStatus(1,0,Primary!,DataModified!)
		IF f_mandantory_chk(idw_20) = -1 THEN Return
		
		IF idw_20.AcceptText() = -1 THEN
			messagebox('Ȯ��','�������� ������ ��ȸ�ϼ���!',Exclamation!)
			Return
		END IF
		idw_21.Reset()
		idw_22.Reset()
		idw_23.Reset()
		idw_24.Reset()
		//Setting : �ڻ��ȣ �Է��ϸ� �ڻ� ����� ��������->ItemChanged��...
		ls_fchgdt      = trim(idw_20.object.fchgdt[1])
		ls_tchgdt      = trim(idw_20.object.tchgdt[1])
		ls_xplant      = trim(idw_20.object.xplant[1])
		ls_div         = trim(idw_20.object.div[1])
		ls_dept        = trim(idw_20.object.dept[1])
		ls_devicegubun = trim(idw_20.object.devicegubun[1])
		ls_specgubun   = trim(idw_20.object.specgubun[1])
		ls_empgubun    = trim(idw_20.object.empgubun[1])
		ls_stcd        = trim(idw_20.object.stcd[1])
		IF IsNull(ls_dept) OR ls_dept = '' THEN
			ls_dept = '%'
		ELSE
			ls_dept = ls_dept + '%'
		END IF
		
		IF IsNull(ls_fchgdt) OR ls_fchgdt = '' THEN
			ls_fchgdt = '19000101'
		END IF
		
		IF IsNull(ls_tchgdt) OR ls_tchgdt = '' THEN
			ls_tchgdt = '99991231'
		END IF
		
		idw_21.Retrieve(g_s_date,g_s_date,'%','%', &
		                '%','%','%','%','%','%','%')
		idw_24.Retrieve(ls_fchgdt,ls_tchgdt,ls_dept)
				
		ln_rows	=	idw_22.InsertRow(0)
		idw_22.object.comltd[ln_rows]       = '01'
		idw_22.object.chgdt[ln_rows]        = g_s_date
		idw_22.object.devicegubun[ln_rows]  = 'D'
		
		idw_22.GetChild('specgubun',idwc_2)
		idwc_2.SetTransObject( SQLCA )
		idwc_2.retrieve('D')
		
		idw_22.object.specgubun[ln_rows]    	= 'D004'
		idw_22.object.memory[ln_rows]       		= '1024'
		idw_22.object.disk[ln_rows]         		= '250'
		idw_22.object.monitorsize[ln_rows]  	= '17'
		idw_22.object.monitorgubun[ln_rows] 	= 'L'
		idw_22.object.cdrwexist[ln_rows]    		= 'N'
		idw_22.object.usbexist[ln_rows]     		= 'N'
		idw_22.object.os[ln_rows]           		= 'WXP'
		idw_22.object.empgubun[ln_rows]     	= '2'
		idw_22.object.stcd[ln_rows]         		= 'I'
		idw_22.object.modelnm[ln_rows]         	= 'HP DX7300MT'
		
/* Setting �� �ʿ� ����. *****************************		
//		idw_22.object.xplant[1]      = ls_xplant
//		idw_22.object.div[1]         = ls_div
//		idw_22.object.dept[1]        = ls_dept
//		idw_22.GetChild('div',idwc_1)
//		idwc_1.SetTransObject( SQLCA )
//		idwc_1.retrieve(ls_xplant)
//		idw_22.object.devicegubun[1] = ls_devicegubun
//		idw_22.object.specgubun[1]   = ls_specgubun
//		idw_22.object.empgubun[1]    = ls_empgubun
//		idw_22.object.stcd[1]        = ls_stcd
******************************************************/		
		
		idw_22.SetItemStatus(ln_rows, 0,Primary!, New!)
		uo_status.st_message.text	=  "�ش������� �Է��ϼ���!"
		wf_icon_onoff(true,true,true,false,false,false,false,true,false)
	////////////////////////////////////////////////////////////////////
	//HW ����
	CASE 3
		MessageBox("Ȯ��","�Է��Ͻ� �� ���� ���Դϴ�.")
		Return
	////////////////////////////////////////////////////////////////////	
	//SW ���	
	CASE 4
		idw_40.Object.fchgdt.Background.Color = 15780518         //�ʼ�, �ϴû�
		idw_40.Object.tchgdt.Background.Color = 15780518         //�ʼ�, �ϴû�
		
		idw_40.AcceptText()
		
		idw_40.SetItemStatus(1,0,Primary!,DataModified!)
		IF f_mandantory_chk(idw_40) = -1 THEN Return
		
		IF idw_40.AcceptText() = -1 THEN
			messagebox('Ȯ��','�������� ������ ��ȸ�ϼ���!',Exclamation!)
			Return
		END IF
		
		idw_41.Reset()
		idw_42.Reset()
		idw_42.insertrow(0)
		
		//Setting : �ڻ��ȣ �Է��ϸ� �ڻ� ����� ��������->ItemChanged��...
		ls_fchgdt      = trim(idw_40.object.fchgdt[1])
		ls_tchgdt      = trim(idw_40.object.tchgdt[1])
		ls_dept        = trim(idw_40.object.dept[1])
		
		IF IsNull(ls_dept) OR ls_dept = '' THEN
			ls_dept = '%'
		ELSE
			ls_dept = ls_dept + '%'
		END IF
		
		IF IsNull(ls_fchgdt) OR ls_fchgdt = '' THEN
			ls_fchgdt = '19000101'
		END IF
		
		IF IsNull(ls_tchgdt) OR ls_tchgdt = '' THEN
			ls_tchgdt = '99991231'
		END IF
		
		idw_41.Retrieve(g_s_date,g_s_date,'%','%', &
		                '%','%','%','%','%','%')
		idw_43.Retrieve(ls_fchgdt,ls_tchgdt,ls_dept)
		
		idw_42.object.comltd[1]      = '01'
		idw_42.object.chgdt[1]       = g_s_date
		ls_yy = Mid(g_s_date,4,1)
		ls_mm = Mid(g_s_date,5,2)
		
		IF uf_com000_swkey(ls_yy, ls_mm, ls_swkey_serl) = -1 THEN RETURN  //�����ȣ
		idw_42.SetItem(1,"swkey",ls_yy + ls_mm + String(DEC(ls_swkey_serl),"000000"))

		idw_42.SetItemStatus(1, 0,Primary!, New!)
		uo_status.st_message.text	=  "�ش������� �Է��ϼ���!"
		wf_icon_onoff(true,true,true,false,false,false,false,true,false)
	////////////////////////////////////////////////////////////////////
	//SW ��ȸ
	CASE 5
		MessageBox("Ȯ��","�Է��Ͻ� �� ���� ���Դϴ�.")
		Return
	////////////////////////////////////////////////////////////////////
	//SW ��������
	CASE 6	
		idw_60.AcceptText()
		
		idw_60.SetItemStatus(1,0,Primary!,DataModified!)
		IF f_mandantory_chk(idw_60) = -1 THEN Return
		
		IF idw_60.AcceptText() = -1 THEN
			messagebox('Ȯ��','�������� ������ ��ȸ�ϼ���!',Exclamation!)
			Return
		END IF
		
		idw_62.Reset()
		idw_62.insertrow(0)
		
		idw_62.object.comltd[1]  = '01'
		
		idw_62.SetItemStatus(1, 0,Primary!, New!)
		uo_status.st_message.text	=  "�ش������� �Է��ϼ���!"
		wf_icon_onoff(true,true,true,false,false,false,false,true,false)	
	////////////////////////////////////////////////////////////////////
	//���� �ڵ� ����
	CASE 7
		idw_70.AcceptText()
		
		idw_70.SetItemStatus(1,0,Primary!,DataModified!)
		IF f_mandantory_chk(idw_70) = -1 THEN Return
		
		IF idw_70.AcceptText() = -1 THEN
			messagebox('Ȯ��','�������� ������ ��ȸ�ϼ���!',Exclamation!)
			Return
		END IF
		
		ls_cogubun      = trim(idw_70.object.cogubun[1])
		
		////���->Device �տ� ù�ڸ��� ���� ����
//		IF ls_cogubun = 'COMMAD' THEN
//			MessageBox("Ȯ��","��籸���� ��񱸺��� ù°�ڸ��� �̿��ؼ� �����Ͻÿ�")
//		END IF
//		
//		////SW Version SW������ �ڵ� ����. (AUT001)
//		IF ls_cogubun = 'COMMAL' THEN
//			MessageBox("Ȯ��","SW���������� SW������ ����°�ڸ��� �̿��ؼ� �����Ͻÿ�")	
//		END IF
		
		idw_72.Reset()
		idw_72.insertrow(0)
		
		idw_72.object.comltd[1]  = '01'
		idw_72.object.cogubun[1] = ls_cogubun
		
		idw_72.SetItemStatus(1, 0,Primary!, New!)
		uo_status.st_message.text	=  "�ش������� �Է��ϼ���!"
		wf_icon_onoff(true,true,true,false,false,false,false,true,false)
	
END CHOOSE


end event

event ue_delete;call super::ue_delete;Long    ll_row, ll_rcnt, ll_delrow
Integer li_ok,  li_err, li_cnt
String  ls_chid, ls_chgdt, ls_swkey

CHOOSE CASE ii_tabindex
	//UPLOAD	
	CASE 1
		MessageBox("Ȯ��","�����Ͻ� �� ���� ���Դϴ�.")
		Return
	////////////////////////////////////////////////////////////////////////
	//HW ���
	CASE 2 
		IF idw_22.rowcount() = 0 or idw_22.getitemstatus(1,0,primary!) = Newmodified! then
			MessageBox('Ȯ��','������ �ڷḦ �����ϼ���!',Exclamation!)
			Return
		END IF
		
		ls_chid  = trim(idw_22.object.chid[1])
		ls_chgdt = trim(idw_22.object.chgdt[1])
		
		SELECT VALUE(COUNT(*),0) 
		INTO   :li_cnt
		FROM PBCOMMON.COMM811
		WHERE COMLTD = '01' AND
				CHID   = :ls_chid ;
				
		IF SQLCA.SQLCode <> 0 THEN		
			MessageBox("Ȯ��","History ������ �������� ����:" + SQLCA.SQLErrText)
			Return
		END IF
		
		IF ls_chgdt <> g_s_date then
			MessageBox('Ȯ��','������ �������ڰ� ������ ��쿡 ���������մϴ�!',Exclamation!)
			Return
		END IF
		
		////�������ڰ� ���� �̴��� History �� �� �� �̻��̸� ���� �Ұ�
		////������ ���Ͽ� �Էµ� �����͸� ���� �� �� �ִ�.
		IF (li_cnt > 2 AND ls_chgdt = g_s_date) THEN
			MessageBox("Ȯ��", &
						  "�����ϰ� ������ ������ History�� 2�� �̻��̸� ���� �� �� �����ϴ�.")
			Return
		END IF
		
		li_ok = MessageBox("����Ȯ��", "������" + string(ls_chgdt) + " �ڷ� �����˴ϴ�. Ȯ��Ű�� ��������!", &
		Exclamation!, OKCancel!, 2)
		
		IF li_ok <> 1 THEN
		  	 // Process CANCEL.
			 rollback using sqlca;
			 uo_status.st_message.text = f_message("D030")	//������ ��ҵǾ����ϴ�.
			 Return
		END IF
		
		idw_22.Deleterow(0)
		IF idw_22.Update(True,False) = 1 THEN  // ã�� : DataWindow controls:DBError event
		
			//History ������ ����.
			DELETE FROM PBCOMMON.COMM811
			WHERE COMLTD = '01' AND
					CHID   = :ls_chid ;
					
			IF SQLCA.SQLCode <> 0 THEN
				MessageBox("Database Error",&
							  "��۴ܰ� History�� ���� ���� �ʾҽ��ϴ�.~r" + &
							  "����ڿ��� �����Ͽ� �����ǵ��� �Ͻʽÿ�.")
				Return
			END IF
			Commit Using sqlca;
			idw_22.ResetUpdate()
//			this.triggerevent('ue_retrieve')
			uo_status.st_message.text = f_message("D010") //����
			idw_21.Reset()
			idw_22.Reset()
			idw_23.Reset()
			idw_24.Reset()
		ELSE
			Rollback Using sqlca;
			uo_status.st_message.text = f_message("D020") //�������
		END IF
	////////////////////////////////////////////////////////////////////////
	//HW ����
	CASE 3	
		MessageBox("Ȯ��","�����Ͻ� �� ���� ���Դϴ�.")
		Return
	////////////////////////////////////////////////////////////////////////	
	//SW ���
	CASE 4
		IF idw_42.rowcount() = 0 or idw_42.getitemstatus(1,0,primary!) = Newmodified! then
			MessageBox('Ȯ��','������ �ڷḦ �����ϼ���!',Exclamation!)
			Return
		END IF
		
		ls_swkey  = trim(idw_42.object.swkey[1])
		
		li_ok = MessageBox("����Ȯ��", "�ڷᰡ �����˴ϴ�. Ȯ��Ű�� ��������!", &
								 Exclamation!, OKCancel!, 2)
		
		IF li_ok <> 1 THEN
		  	 // Process CANCEL.
			 rollback using sqlca;
			 uo_status.st_message.text = f_message("D030")	//������ ��ҵǾ����ϴ�.
			 Return
		END IF
		
		/*
		//////������� : swkey�θ� history���� �ȵ�///////////////////////////
		//////����ߴٰ� �������Ŀ� ��ٷ� ��� -> �׸��� ���Ŀ� �Ǵٽ� ����//
		//////->�̷��� �Ǹ� history�� Duplicate key �߻��Ѵ�./////////////////
		
		//////SW���� History�� �Է��� ���� �Ϸ�ȴ�.//////////////////////////
		INSERT INTO PBCOMMON.COMM813
		SELECT COMLTD,SWKEY,CHGDT,ASID,ASDT,CHID,XPLANT,DIV,DEPT,SWLGUBUN,
				  SWVGUBUN,SWNM,SERIALKEY,PURDT,COMMENT,INPTID,INPTDT,
				  :g_s_empno,:g_s_date,:g_s_ipaddr,:g_s_macaddr
		FROM PBCOMMON.COMM812
		WHERE COMLTD = '01' AND
				SWKEY  = :ls_swkey  ;
				
		IF SQLCA.SQLCode <> 0 THEN
			MessageBox("Ȯ��","���� History�� �����͸� �������� ���߽��ϴ�.")
			Return
		END IF
		//////////////////////////////////////////////
		*/
		
		idw_42.Deleterow(0)
		
		IF idw_42.Update(True,False) = 1 THEN  // ã�� : DataWindow controls:DBError event
			Commit Using sqlca;
			idw_42.ResetUpdate()
//			this.triggerevent('ue_retrieve')
			uo_status.st_message.text = f_message("D010") //����
			idw_41.Reset()
			idw_42.Reset()
			idw_43.Reset()
			
		ELSE
			Rollback Using sqlca;
			uo_status.st_message.text = f_message("D020") //�������
		END IF	
	////////////////////////////////////////////////////////////////////////	
	//SW ��ȸ
	CASE 5
		MessageBox("Ȯ��","�����Ͻ� �� ���� ���Դϴ�.")
		Return
	////////////////////////////////////////////////////////////////////////
	//SW ���� ����
	CASE 6
		IF idw_62.rowcount() = 0 or idw_62.getitemstatus(1,0,primary!) = Newmodified! then
			MessageBox('Ȯ��','������ �ڷḦ �����ϼ���!',Exclamation!)
			Return
		END IF
		
		li_ok = MessageBox("����Ȯ��", "�ش��ڷᰡ �����˴ϴ�. Ȯ��Ű�� ��������!", &
		Exclamation!, OKCancel!, 2)
		
		IF li_ok <> 1 THEN
		  	 // Process CANCEL.
			 rollback using sqlca;
			 uo_status.st_message.text = f_message("D030")	//������ ��ҵǾ����ϴ�.
			 Return
		END IF
		
		idw_62.Deleterow(0)
		IF idw_62.Update(True,False) = 1 THEN  // ã�� : DataWindow controls:DBError event
			Commit Using sqlca;
			idw_62.ResetUpdate()
			this.triggerevent('ue_retrieve')
			uo_status.st_message.text = f_message("D010") //����
		ELSE
			Rollback Using sqlca;
			uo_status.st_message.text = f_message("D020") //�������
		END IF	
	////////////////////////////////////////////////////////////////////////	
	//���� �ڵ� ����
	CASE 7
		IF idw_72.rowcount() = 0 or idw_72.getitemstatus(1,0,primary!) = Newmodified! then
			MessageBox('Ȯ��','������ �ڷḦ �����ϼ���!',Exclamation!)
			Return
		END IF
		
		li_ok = MessageBox("����Ȯ��", "�ش��ڷᰡ �����˴ϴ�. Ȯ��Ű�� ��������!", &
		Exclamation!, OKCancel!, 2)
		
		IF li_ok <> 1 THEN
		  	 // Process CANCEL.
			 rollback using sqlca;
			 uo_status.st_message.text = f_message("D030")	//������ ��ҵǾ����ϴ�.
			 Return
		END IF
		
		idw_72.Deleterow(0)
		IF idw_72.Update(True,False) = 1 THEN  // ã�� : DataWindow controls:DBError event
			Commit Using sqlca;
			idw_72.ResetUpdate()
			this.triggerevent('ue_retrieve')
			uo_status.st_message.text = f_message("D010") //����
		ELSE
			Rollback Using sqlca;
			uo_status.st_message.text = f_message("D020") //�������
		END IF	
		
END CHOOSE

end event

event ue_bcreate;call super::ue_bcreate;CHOOSE CASE ii_tabindex
	
	CASE 2
		IF idw_21.rowcount() > 0 THEN
			uo_status.st_message.text	=	'�ڷ�������Դϴ�.��ø� ��ٸ�����'
			f_save_to_excel(idw_21)
			uo_status.st_message.text	=	' '
		ELSE
			uo_status.st_message.text	=	'������ �ڷᰡ �����ϴ�'
		END IF
	CASE 4
		IF idw_41.RowCount() > 0 THEN
			uo_status.st_message.text	=	'�ڷ�������Դϴ�.��ø� ��ٸ�����'
			f_save_to_excel(idw_41)
			uo_status.st_message.text	=	' '
		ELSE
			uo_status.st_message.text	=	'������ �ڷᰡ �����ϴ�'
		END IF
	CASE 5
		IF idw_51.RowCount() > 0 THEN
			uo_status.st_message.text	=	'�ڷ�������Դϴ�.��ø� ��ٸ�����'
			f_save_to_excel(idw_51)
			uo_status.st_message.text	=	' '
		ELSE
			uo_status.st_message.text	=	'������ �ڷᰡ �����ϴ�'
		END IF
	CASE 7
		IF idw_71.RowCount() > 0 THEN
			uo_status.st_message.text	=	'�ڷ�������Դϴ�.��ø� ��ٸ�����'
			f_save_to_excel(idw_71)
			uo_status.st_message.text	=	' '
		ELSE
			uo_status.st_message.text	=	'������ �ڷᰡ �����ϴ�'
		END IF	
	CASE 8
		IF idw_81.RowCount() > 0 THEN
			uo_status.st_message.text	=	'�ڷ�������Դϴ�.��ø� ��ٸ�����'
			f_save_to_excel(idw_81)
			uo_status.st_message.text	=	' '
		ELSE
			uo_status.st_message.text	=	'������ �ڷᰡ �����ϴ�'
		END IF
	CASE 9
		idw_93.Reset()
		//idw_92�� �����͸� ����ϸ� �߰��� blank�� ���ܼ� ��¿�� ����...
		IF idw_93.Retrieve() > 0 THEN
			uo_status.st_message.text	=	'�ڷ�������Դϴ�.��ø� ��ٸ�����'
			f_save_to_excel(idw_93)
			uo_status.st_message.text	=	' '
		ELSE
			uo_status.st_message.text	=	'������ �ڷᰡ �����ϴ�'
		END IF
	CASE 10
		
		IF idw_ip.RowCount() > 0 THEN
			uo_status.st_message.text	=	'�ڷ�������Դϴ�.��ø� ��ٸ�����'
			f_save_to_excel(idw_ip)
			uo_status.st_message.text	=	' '
		ELSE
			uo_status.st_message.text	=	'������ �ڷᰡ �����ϴ�'
		END IF	
	CASE 1,3,6
		MessageBox("Ȯ��","���Ϲޱ� �Ͻ� �� ���� ���Դϴ�.")
		Return
END CHOOSE
end event

type uo_status from w_origin_sheet09`uo_status within w_comm901u
integer y = 2476
end type

type tab_1 from tab within w_comm901u
integer x = 32
integer y = 28
integer width = 4567
integer height = 2440
integer taborder = 10
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long backcolor = 12632256
boolean raggedright = true
boolean focusonbuttondown = true
boolean boldselectedtext = true
integer selectedtab = 2
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
tabpage_4 tabpage_4
tabpage_5 tabpage_5
tabpage_6 tabpage_6
tabpage_7 tabpage_7
tabpage_8 tabpage_8
tabpage_9 tabpage_9
tabpage_10 tabpage_10
tabpage_11 tabpage_11
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.tabpage_3=create tabpage_3
this.tabpage_4=create tabpage_4
this.tabpage_5=create tabpage_5
this.tabpage_6=create tabpage_6
this.tabpage_7=create tabpage_7
this.tabpage_8=create tabpage_8
this.tabpage_9=create tabpage_9
this.tabpage_10=create tabpage_10
this.tabpage_11=create tabpage_11
this.Control[]={this.tabpage_1,&
this.tabpage_2,&
this.tabpage_3,&
this.tabpage_4,&
this.tabpage_5,&
this.tabpage_6,&
this.tabpage_7,&
this.tabpage_8,&
this.tabpage_9,&
this.tabpage_10,&
this.tabpage_11}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
destroy(this.tabpage_3)
destroy(this.tabpage_4)
destroy(this.tabpage_5)
destroy(this.tabpage_6)
destroy(this.tabpage_7)
destroy(this.tabpage_8)
destroy(this.tabpage_9)
destroy(this.tabpage_10)
destroy(this.tabpage_11)
end on

event selectionchanged;ii_tabindex = newindex
g_n_tabno = newindex
uo_status.st_message.text	=  ' '

idw_11.AcceptText()
idw_21.AcceptText()
idw_31.AcceptText()
idw_41.AcceptText()
idw_51.AcceptText()
idw_61.AcceptText()
idw_71.AcceptText()
idw_81.AcceptText()
idw_91.AcceptText()
idw_ip.AcceptText()

CHOOSE CASE ii_tabindex
	CASE 1
		IF idw_11.rowcount() > 0 then
			wf_icon_onoff(true,false,true,false,false,false,false,true,false) //I,A,U,D,P
		ELSE
			wf_icon_onoff(true,false,false,false,false,false,false,true,false)
		END IF
	CASE 2
		IF idw_21.rowcount() > 0 then
			wf_icon_onoff(true,true,true,true,false,true,false,true,false) //I,A,U,D,P
		ELSE
			wf_icon_onoff(true,true,false,false,false,false,false,true,false)
		END IF
	CASE 3
		IF idw_31.rowcount() > 0 then
			wf_icon_onoff(true,false,true,false,false,true,false,true,false)
		ELSE
			wf_icon_onoff(true,false,false,false,false,false,false,true,false)
		END IF
	CASE 4
		IF idw_41.rowcount() > 0 then
			wf_icon_onoff(true,true,true,true,false,true,false,true,false)
		ELSE
			wf_icon_onoff(true,true,false,false,false,false,false,true,false)
		END IF	
	CASE 5
		IF idw_51.rowcount() > 0 then
			wf_icon_onoff(true,false,false,false,false,true,false,true,false)
		ELSE
			wf_icon_onoff(true,false,false,false,false,false,false,true,false)
		END IF
	CASE 6
		IF idw_61.rowcount() > 0 then
			wf_icon_onoff(true,true,true,false,false,true,false,true,false)
		ELSE
			wf_icon_onoff(true,true,false,false,false,false,false,true,false)
		END IF
		
	CASE 7
		IF idw_71.rowcount() > 0 then
			wf_icon_onoff(true,true,true,false,false,true,false,true,false)
		ELSE
			wf_icon_onoff(true,true,false,false,false,false,false,true,false)
		END IF
	CASE 8
		IF idw_81.rowcount() > 0 then
			wf_icon_onoff(true,false,false,false,false,true,false,true,false) //I,A,U,D,P
		ELSE
			wf_icon_onoff(true,false,false,false,false,false,false,true,false)
		END IF
	CASE 9
		IF idw_91.rowcount() > 0 then
			wf_icon_onoff(true,false,true,false,false,true,false,true,false) //I,A,U,D,P
		ELSE
			wf_icon_onoff(true,false,false,false,false,false,false,true,false)
		END IF
	CASE 10
		IF idw_ip.rowcount() > 0 then
			wf_icon_onoff(true,false,true,false,false,true,false,true,false) //I,A,U,D,P
		ELSE
			wf_icon_onoff(true,false,false,false,false,false,false,true,false)
		END IF	
END CHOOSE
end event

type tabpage_1 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 4530
integer height = 2324
long backcolor = 12632256
string text = "���ε�"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
dw_12 dw_12
st_1 st_1
ddlb_1 ddlb_1
dw_11 dw_11
dw_10 dw_10
end type

on tabpage_1.create
this.dw_12=create dw_12
this.st_1=create st_1
this.ddlb_1=create ddlb_1
this.dw_11=create dw_11
this.dw_10=create dw_10
this.Control[]={this.dw_12,&
this.st_1,&
this.ddlb_1,&
this.dw_11,&
this.dw_10}
end on

on tabpage_1.destroy
destroy(this.dw_12)
destroy(this.st_1)
destroy(this.ddlb_1)
destroy(this.dw_11)
destroy(this.dw_10)
end on

type dw_12 from datawindow within tabpage_1
boolean visible = false
integer x = 2866
integer y = 16
integer width = 1627
integer height = 428
integer taborder = 20
string title = "none"
string dataobject = "d_aut322u_11_1"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;This.SetTransObject(sqlca)
idw_12 = this
end event

type st_1 from statictext within tabpage_1
integer x = 23
integer y = 28
integer width = 507
integer height = 68
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 33554432
long backcolor = 12632256
string text = "���ε�����"
boolean focusrectangle = false
end type

type ddlb_1 from dropdownlistbox within tabpage_1
integer x = 544
integer y = 20
integer width = 1083
integer height = 348
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 33554432
long backcolor = 15780518
boolean autohscroll = true
boolean hscrollbar = true
boolean vscrollbar = true
string item[] = {"1:H/W ������ ���ε�","2:S/W ������ ���ε�","3:S/W ���� ���ε�","4:�����ڵ� ���ε�"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;String          ls_gubun
Datawindowchild cdw_1

ii_index = index

idw_10.Reset()
CHOOSE CASE index
	//HW����
	CASE 1
		idw_10.Visible = False
		idw_10.Enabled = False
		idw_10.DataObject = "d_aut322u_10"  
   
		idw_10.SetTransObject(SQLCA)
		////div�� ������ �����ϸ� �ٲ��.
		idw_10.GetChild('div',idwc_1)
		idwc_1.SetTransObject( SQLCA )
		idwc_1.retrieve('X')

		idw_11.DataObject = "d_aut322u_11"  
      idw_11.SetTransObject(sqlca)
		
	//SW����
	CASE 2
		idw_10.Visible = False
		idw_10.Enabled = False
		idw_10.DataObject = "d_aut322u_10"  
   
		idw_10.SetTransObject(SQLCA)
		////div�� ������ �����ϸ� �ٲ��.
		idw_10.GetChild('div',idwc_1)
		idwc_1.SetTransObject( SQLCA )
		idwc_1.retrieve('X')

		idw_11.DataObject = "d_aut322u_12"  
      idw_11.SetTransObject(sqlca)
		
	//SW����
	CASE 3
		idw_10.Visible = False
		idw_10.Enabled = False
		idw_10.DataObject = "d_aut322u_10"  
   
		idw_10.SetTransObject(SQLCA)
		////div�� ������ �����ϸ� �ٲ��.
		idw_10.GetChild('div',idwc_1)
		idwc_1.SetTransObject( SQLCA )
		idwc_1.retrieve('X')

		idw_11.DataObject = "d_aut322u_13"  
      idw_11.SetTransObject(sqlca)	
		
	//�����ڵ�
	CASE 4
		idw_10.Visible = False
		idw_10.Enabled = False
		idw_10.DataObject = "d_aut322u_70"  
   
		idw_10.SetTransObject(SQLCA)
		////div�� ������ �����ϸ� �ٲ��.
		idw_10.GetChild('div',idwc_1)
		idwc_1.SetTransObject( SQLCA )
		idwc_1.retrieve('X')

		idw_11.DataObject = "d_aut322u_14"  
      idw_11.SetTransObject(sqlca)		
	
END CHOOSE
idw_10.InsertRow(0)
idw_10.SetFocus()

end event

type dw_11 from datawindow within tabpage_1
integer x = 9
integer y = 128
integer width = 4507
integer height = 2184
integer taborder = 20
string title = "none"
string dataobject = "d_aut322u_11"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;This.SetTransObject(sqlca)
idw_11 = this
end event

event clicked;This.SelectRow(0,False)
This.SelectRow(row,True)
//f_pur040_mselect(this, row)  //reference 'this'���Ұ�,����������

//�ڷ���� �κ� Ŭ���� ���� ����
IF dwo.name = "datawindow" Then
	This.SelectRow(0,false)
End IF
this.SetRedraw(False)
IF row < 1 THEN
   IF f_pur040_getobjph(this,is_colnm) = 1 THEN
		this.setsort(is_colnm)
      this.sort()
	 END IF
	 this.SetRedraw(True)
	 RETURN
END IF
this.SetRedraw(True)
end event

event retrieveend;int i
string ls_empno,ls_penamek,ls_pedept,ls_chid

for i = 1 to rowcount
	ls_empno	=	trim(this.object.empno[i])
	ls_chid	=	trim(this.object.chid[i])
	if f_spacechk(ls_empno) <> -1 then
		SELECT penamek,pedept 
		into :ls_penamek,:ls_pedept 
		from pbcommon.dac003
		where peempno = :ls_empno ;
		IF SQLCA.SQLCode <> 0 THEN
			MessageBox("Ȯ��",string(i) + " ��° ���� " + "����ȣ(" + ls_chid + ")" + "~r~n�� �Է��Ͻ� ��� " + ls_empno + " �� �������� �ʴ� ����Դϴ�.~r~n����� Ȯ�� �� �� ���ε�")
			Return 1
		END IF
		This.SetItem(i,'empnm',ls_penamek)		
		This.SetItem(i,'dept' ,ls_pedept)		
	end if
next
end event

type dw_10 from datawindow within tabpage_1
event ue_dwnkey pbm_dwnkey
boolean visible = false
integer x = 1650
integer y = 24
integer width = 1454
integer height = 100
integer taborder = 20
boolean enabled = false
string title = "none"
string dataobject = "d_aut322u_10"
boolean border = false
boolean livescroll = true
end type

event ue_dwnkey;if key = keyenter! then
	iw_sheet.triggerevent('ue_retrieve')
end if
end event

event constructor;This.SetTransObject(sqlca)
idw_10 = this

////div�� ������ �����ϸ� �ٲ��.
This.GetChild('div',idwc_1)
idwc_1.SetTransObject( SQLCA )
idwc_1.retrieve('X')

This.InsertRow(0)
end event

event itemchanged;CHOOSE CASE dwo.name
	CASE 'xplant'
		This.SetItem(1,'div','')
		IF isnull(data) THEN
			data = ''
		END IF
		
		This.GetChild('div', idwc_1 )
		idwc_1.SetTransObject( SQLCA )
		idwc_1.Retrieve(data)
		
END CHOOSE
end event

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 4530
integer height = 2324
long backcolor = 12632256
string text = "H/W ���/����/����"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
st_4 st_4
st_3 st_3
dw_24 dw_24
dw_23 dw_23
dw_22 dw_22
dw_21 dw_21
dw_20 dw_20
end type

on tabpage_2.create
this.st_4=create st_4
this.st_3=create st_3
this.dw_24=create dw_24
this.dw_23=create dw_23
this.dw_22=create dw_22
this.dw_21=create dw_21
this.dw_20=create dw_20
this.Control[]={this.st_4,&
this.st_3,&
this.dw_24,&
this.dw_23,&
this.dw_22,&
this.dw_21,&
this.dw_20}
end on

on tabpage_2.destroy
destroy(this.st_4)
destroy(this.st_3)
destroy(this.dw_24)
destroy(this.dw_23)
destroy(this.dw_22)
destroy(this.dw_21)
destroy(this.dw_20)
end on

type st_4 from statictext within tabpage_2
integer x = 2619
integer y = 224
integer width = 457
integer height = 52
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 33554432
long backcolor = 12632256
string text = "�����ڻ� DB"
boolean focusrectangle = false
end type

type st_3 from statictext within tabpage_2
integer x = 37
integer y = 220
integer width = 457
integer height = 52
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 33554432
long backcolor = 12632256
string text = "PC ���� DB"
boolean focusrectangle = false
end type

type dw_24 from datawindow within tabpage_2
integer x = 2619
integer y = 288
integer width = 1893
integer height = 1024
integer taborder = 50
string title = "none"
string dataobject = "d_aut322u_24"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;This.SetTransObject(sqlca)
idw_24 = this
end event

event clicked;String ls_dept, ls_ficode, ls_fimodel, ls_fibudt

This.SelectRow(0,False)
This.SelectRow(row,True)
//f_pur040_mselect(this, row)  //reference 'this'���Ұ�,����������

//�ڷ���� �κ� Ŭ���� ���� ����
IF dwo.name = "datawindow" Then
	This.SelectRow(0,false)
End IF
this.SetRedraw(False)
IF row < 1 THEN
   IF f_pur040_getobjph(this,is_colnm) = 1 THEN
		this.setsort(is_colnm)
      this.sort()
	 END IF
	 this.SetRedraw(True)
	 RETURN
END IF
this.SetRedraw(True)

ls_dept    = This.GetItemString(row,'fiusdept')
ls_ficode  = This.GetItemString(row,'ficode')
ls_fimodel = This.GetItemString(row,'fimodel')
////����ȣ Setting �ÿ� '-' �� ������ �����ֱ�.
ls_fimodel = f_replace(ls_fimodel,'-','')
ls_fibudt  = This.GetItemString(row,'fibudt')

////HW��Ͽ����� ��ȸ�ؼ� �����Ҽ� ������... Ȯ���ϰ� �ϱ� ���ؼ�.
IF idw_22.GetItemStatus(1,0,Primary!) = NewModified! THEN
	idw_22.object.dept[1]        = ls_dept
	idw_22.object.chid[1]        = ls_fimodel
	idw_22.object.asdt[1]        = ls_fibudt
	idw_22.object.asid[1]        = ls_ficode
END IF



end event

type dw_23 from datawindow within tabpage_2
integer x = 2619
integer y = 1352
integer width = 1883
integer height = 956
integer taborder = 40
string title = "none"
string dataobject = "d_aut322u_23"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;This.SetTransObject(sqlca)
idw_23 = this
end event

event clicked;This.SelectRow(0,False)
This.SelectRow(row,True)
//f_pur040_mselect(this, row)  //reference 'this'���Ұ�,����������

//�ڷ���� �κ� Ŭ���� ���� ����
IF dwo.name = "datawindow" Then
	This.SelectRow(0,false)
End IF
this.SetRedraw(False)
IF row < 1 THEN
   IF f_pur040_getobjph(this,is_colnm) = 1 THEN
		this.setsort(is_colnm)
      this.sort()
	 END IF
	 this.SetRedraw(True)
	 RETURN
END IF
this.SetRedraw(True)
end event

type dw_22 from datawindow within tabpage_2
integer x = 18
integer y = 1352
integer width = 2578
integer height = 956
integer taborder = 30
string title = "none"
string dataobject = "d_aut322u_22"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;This.SetTransObject(sqlca)
idw_22 = this

//div�� ������ �����ϸ� �ٲ��.
This.GetChild('div',idwc_1)
idwc_1.SetTransObject( SQLCA )
idwc_1.retrieve('X')

This.GetChild('specgubun',idwc_2)
idwc_2.SetTransObject( SQLCA )
idwc_2.retrieve('X')

//This.InsertRow(0)
end event

event itemchanged;String ls_fibudt,ls_penamek,ls_pedept

CHOOSE CASE dwo.name
	CASE 'asid'
		
		SELECT FIBUDT
		INTO   :ls_fibudt
		FROM PBFIA.FIA030 
		WHERE  FICODE = :data ;
		
		IF SQLCA.SQLCode = -1 THEN
			MessageBox("Ȯ��","�ڻ������ �����߻�:" + SQLCA.SQLErrText)
			Return 1
		END IF
		
		IF SQLCA.SQLCode = 100 THEN
			MessageBox("Ȯ��",&
						  "�ڻ��ڵ带 Ȯ���غ�����.~r")
		END IF
		
		This.SetItem(1,'asdt',ls_fibudt)
		
		
	CASE 'xplant'
		idw_22.SetItem(1,'div','')
		IF isnull(data) THEN
			data = ''
		END IF
		
		This.GetChild('div', idwc_1 )
		idwc_1.SetTransObject( SQLCA )
		idwc_1.Retrieve(data)
		
		
	CASE 'devicegubun'
		idw_22.SetItem(1,'specgubun','')
		IF isnull(data) THEN
			data = ''
		END IF
		
		IF data = 'D' THEN
			idw_22.SetItem(1,'modelnm','HP DX7300MT')
			idw_22.SetItem(1,'os','WXP')
			idw_22.SetItem(1,'memory','1024')
			idw_22.SetItem(1,'disk','250')
			idw_22.SetItem(1,'monitorsize','17')		
			idw_22.SetItem(1,'monitorgubun','L')		
			idw_22.SetItem(1,'cdrwexist','N')		
			idw_22.SetItem(1,'usbexist','N')	
		END IF
		
		////����ũž�� ��Ʈ���� ��籸���� �����ؼ� ����.
		IF data = 'N' THEN
			data = 'D'
			idw_22.SetItem(1,'modelnm','')
			idw_22.SetItem(1,'os','WXP')
			idw_22.SetItem(1,'memory','1024')
			idw_22.SetItem(1,'disk','100')
			idw_22.SetItem(1,'monitorsize','')		
			idw_22.SetItem(1,'monitorgubun','T')		
			idw_22.SetItem(1,'cdrwexist','N')		
			idw_22.SetItem(1,'usbexist','N')	
		END IF
		This.GetChild('specgubun', idwc_2 )
		idwc_2.SetTransObject( SQLCA )
		idwc_2.Retrieve(data)
		if	data	=	'P'	then
			idw_22.SetItem(1,'modelnm','')
			idw_22.SetItem(1,'os','')
			idw_22.SetItem(1,'memory','')
			idw_22.SetItem(1,'disk','')
			idw_22.SetItem(1,'monitorsize','')		
			idw_22.SetItem(1,'monitorgubun','')		
			idw_22.SetItem(1,'cdrwexist','')		
			idw_22.SetItem(1,'usbexist','')		
		end if

	CASE 'empno'
		if f_spacechk(data) <> -1 then
			SELECT penamek,pedept 
			into :ls_penamek,:ls_pedept 
			from pbcommon.dac003
			where peempno = :data ;
			IF SQLCA.SQLCode <> 0 THEN
				MessageBox("Ȯ��","�Է��Ͻ� ����� �������� �ʴ� ����Դϴ�")
				Return 1
			END IF
			This.SetItem(1,'empnm',ls_penamek)		
			This.SetItem(1,'dept' ,mid(ls_pedept,1,2) + '00')		
			this.object.empnm.protect 	= true
			this.object.dept.protect 	= true
			this.object.empnm.background.color	= rgb(192,192,192)
			this.object.dept.background.color	= rgb(192,192,192)
		else
			this.object.empnm.protect 	= false
			this.object.dept.protect 	= false
			this.object.empnm.background.color	= rgb(255,255,255)
			this.object.dept.background.color	= 15780518
		end if
	CASE ELSE	
		
END CHOOSE
end event

event getfocus;//String ls_colName
//
//ls_colName = This.GetColumnName( )
//MessageBox("Ȯ��",ls_colName)
//
//CHOOSE CASE ls_colName
//	CASE 'modelnm'
//		f_toggle_sle(handle(this),'ENG')
//		
//	CASE 'empnm'
//		f_toggle_sle(handle(this),'KOR')
//		
//	CASE 'comment'
//		f_toggle_sle(handle(this),'KOR')
//		
//	CASE 'etc'
//		f_toggle_sle(handle(this),'ENG')
//		
//	CASE ELSE
//		f_toggle_sle(handle(this),'ENG')
//		
//END CHOOSE
//f_toggle_sle(handle(this),'ENG')

end event

event itemfocuschanged;This.AcceptText()

//CHOOSE CASE dwo.name
//	CASE 'dept'
//		f_toggle_sle(handle(this),'KOR')
//		
//	CASE 'modelnm'
//		f_toggle_sle(handle(this),'ENG')
//
//	CASE 'empnm'
//		f_toggle_sle(handle(this),'KOR')
//
//	CASE 'comment'
//		f_toggle_sle(handle(this),'KOR')
//
//	CASE 'etc'
//		f_toggle_sle(handle(this),'ENG')
//
//	CASE ELSE
//		f_toggle_sle(handle(this),'ENG')
//
//END CHOOSE
end event

type dw_21 from datawindow within tabpage_2
integer x = 18
integer y = 288
integer width = 2578
integer height = 1024
integer taborder = 20
string title = "none"
string dataobject = "d_aut322u_21"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;This.SetTransObject(sqlca)
idw_21 = this
end event

event clicked;This.SelectRow(0,False)
This.SelectRow(row,True)
//f_pur040_mselect(this, row)  //reference 'this'���Ұ�,����������

//�ڷ���� �κ� Ŭ���� ���� ����
IF dwo.name = "datawindow" Then
	This.SelectRow(0,false)
End IF
this.SetRedraw(False)
IF row < 1 THEN
   IF f_pur040_getobjph(this,is_colnm) = 1 THEN
		this.setsort(is_colnm)
      this.sort()
	 END IF
	 this.SetRedraw(True)
	 RETURN
END IF
this.SetRedraw(True)
wf_icon_onoff(true,true,true,true,false,true,false,true,false)

string ls_chid, ls_xplant, ls_devicegubun
ls_chid         = trim(This.object.chid[row])
ls_xplant       = trim(This.object.xplant[row])
ls_devicegubun  = trim(This.object.devicegubun[row])
if ls_devicegubun	=	'N'	then
	ls_devicegubun	=	'D'
end if
idw_22.Reset()
idw_23.Reset()
idw_22.Retrieve(ls_chid)
idw_23.Retrieve(ls_chid)

idw_22.GetChild('div',idwc_1)
idwc_1.SetTransObject( SQLCA )
idwc_1.retrieve(ls_xplant)

idw_22.GetChild('specgubun',idwc_2)
idwc_2.SetTransObject( SQLCA )
idwc_2.retrieve(ls_devicegubun)



end event

type dw_20 from datawindow within tabpage_2
event ue_dwnkey pbm_dwnkey
integer x = 14
integer y = 16
integer width = 4462
integer height = 200
integer taborder = 10
string title = "none"
string dataobject = "d_aut322u_20"
boolean border = false
boolean livescroll = true
end type

event ue_dwnkey;if key = keyenter! then
	iw_sheet.triggerevent('ue_retrieve')
end if
end event

event constructor;This.SetTransObject(sqlca)
idw_20 = this

////div�� ������ �����ϸ� �ٲ��.
This.GetChild('div',idwc_1)
idwc_1.SetTransObject( SQLCA )
idwc_1.retrieve('X')

This.GetChild('specgubun',idwc_2)
idwc_2.SetTransObject( SQLCA )
idwc_2.retrieve('X')

This.InsertRow(0)



end event

event itemchanged;CHOOSE CASE dwo.name
	CASE 'xplant'
		This.SetItem(1,'div','')
		IF isnull(data) THEN
			data = ''
		END IF
		
		This.GetChild('div', idwc_1 )
		idwc_1.SetTransObject( SQLCA )
		idwc_1.Retrieve(data)
		
		
	CASE 'devicegubun'
		This.SetItem(1,'specgubun','')
		IF isnull(data) THEN
			data = ''
		END IF
		
		////����ũž�� ��Ʈ���� ��籸���� �����ؼ� ����.
		IF data = 'N' THEN
			data = 'D'
		END IF
		This.GetChild('specgubun', idwc_2 )
		idwc_2.SetTransObject( SQLCA )
		
		idwc_2.Retrieve(data)
		
END CHOOSE
end event

type tabpage_3 from userobject within tab_1
boolean visible = false
integer x = 18
integer y = 100
integer width = 4530
integer height = 2324
boolean enabled = false
long backcolor = 12632256
string text = "H/W ����"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
dw_33 dw_33
dw_32 dw_32
dw_31 dw_31
dw_30 dw_30
end type

on tabpage_3.create
this.dw_33=create dw_33
this.dw_32=create dw_32
this.dw_31=create dw_31
this.dw_30=create dw_30
this.Control[]={this.dw_33,&
this.dw_32,&
this.dw_31,&
this.dw_30}
end on

on tabpage_3.destroy
destroy(this.dw_33)
destroy(this.dw_32)
destroy(this.dw_31)
destroy(this.dw_30)
end on

type dw_33 from datawindow within tabpage_3
integer x = 2688
integer y = 1356
integer width = 1815
integer height = 948
integer taborder = 60
string title = "none"
string dataobject = "d_aut322u_23"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;This.SetTransObject(sqlca)
idw_33 = this
end event

event clicked;This.SelectRow(0,False)
This.SelectRow(row,True)
//f_pur040_mselect(this, row)  //reference 'this'���Ұ�,����������

//�ڷ���� �κ� Ŭ���� ���� ����
IF dwo.name = "datawindow" Then
	This.SelectRow(0,false)
End IF
this.SetRedraw(False)
IF row < 1 THEN
   IF f_pur040_getobjph(this,is_colnm) = 1 THEN
		this.setsort(is_colnm)
      this.sort()
	 END IF
	 this.SetRedraw(True)
	 RETURN
END IF
this.SetRedraw(True)
end event

type dw_32 from datawindow within tabpage_3
integer x = 18
integer y = 1352
integer width = 2642
integer height = 960
integer taborder = 50
string title = "none"
string dataobject = "d_aut322u_32"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;This.SetTransObject(sqlca)
idw_32 = this

//div�� ������ �����ϸ� �ٲ��.
This.GetChild('div',idwc_1)
idwc_1.SetTransObject( SQLCA )
idwc_1.retrieve('X')

This.GetChild('specgubun',idwc_2)
idwc_2.SetTransObject( SQLCA )
idwc_2.retrieve('X')

//This.InsertRow(0)
end event

event itemchanged;String ls_fibudt

CHOOSE CASE dwo.name
	CASE 'asid'
		
		SELECT FIBUDT
		INTO   :ls_fibudt
		FROM PBFIA.FIA030 
		WHERE  FICODE = :data ;
		
		IF SQLCA.SQLCode = -1 THEN
			MessageBox("Ȯ��","�ڻ������ �����߻�:" + SQLCA.SQLErrText)
			Return 1
		END IF
		
		IF SQLCA.SQLCode = 100 THEN
			MessageBox("Ȯ��",&
						  "�ڻ��ڵ带 Ȯ���غ�����.~r")
		END IF
		
		This.SetItem(1,'asdt',ls_fibudt)
		
	CASE 'xplant'
		idw_32.SetItem(1,'div','')
		IF isnull(data) THEN
			data = ''
		END IF
		
		This.GetChild('div', idwc_1 )
		idwc_1.SetTransObject( SQLCA )
		idwc_1.Retrieve(data)
		
		
	CASE 'devicegubun'
		idw_32.SetItem(1,'specgubun','')
		IF isnull(data) THEN
			data = ''
		END IF
		
		////����ũž�� ��Ʈ���� ��籸���� �����ؼ� ����.
		IF data = 'N' THEN
			data = 'D'
		END IF
		This.GetChild('specgubun', idwc_2 )
		idwc_2.SetTransObject( SQLCA )
		idwc_2.Retrieve(data)
		
END CHOOSE
end event

type dw_31 from datawindow within tabpage_3
integer x = 18
integer y = 212
integer width = 4489
integer height = 1120
integer taborder = 40
string title = "none"
string dataobject = "d_aut322u_31"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;This.SetTransObject(sqlca)
idw_31 = this
end event

event clicked;This.SelectRow(0,False)
This.SelectRow(row,True)
//f_pur040_mselect(this, row)  //reference 'this'���Ұ�,����������

//�ڷ���� �κ� Ŭ���� ���� ����
IF dwo.name = "datawindow" Then
	This.SelectRow(0,false)
End IF
this.SetRedraw(False)
IF row < 1 THEN
   IF f_pur040_getobjph(this,is_colnm) = 1 THEN
		this.setsort(is_colnm)
      this.sort()
	 END IF
	 this.SetRedraw(True)
	 RETURN
END IF
this.SetRedraw(True)

string ls_chid, ls_xplant, ls_devicegubun

ls_chid         = trim(This.object.chid[row])
ls_xplant       = trim(This.object.xplant[row])
ls_devicegubun  = trim(This.object.devicegubun[row])

idw_32.Reset()
idw_33.Reset()
idw_32.Retrieve(ls_chid)
idw_33.Retrieve(ls_chid)

idw_32.GetChild('div',idwc_1)
idwc_1.SetTransObject( SQLCA )
idwc_1.retrieve(ls_xplant)

idw_32.GetChild('specgubun',idwc_2)
idwc_2.SetTransObject( SQLCA )
idwc_2.retrieve(ls_devicegubun)

wf_icon_onoff(true,false,true,false,false,false,false,true,false)
end event

type dw_30 from datawindow within tabpage_3
event ue_dwnkey pbm_dwnkey
integer x = 14
integer y = 16
integer width = 4494
integer height = 176
integer taborder = 20
string title = "none"
string dataobject = "d_aut322u_20"
boolean border = false
boolean livescroll = true
end type

event ue_dwnkey;if key = keyenter! then
	iw_sheet.triggerevent('ue_retrieve')
end if
end event

event constructor;This.SetTransObject(sqlca)
idw_30 = this

//This.GetChild('xplant',idwc_1)
//idwc_1.SetTransObject( SQLCA )
//idwc_1.Retrieve()

////div�� ������ �����ϸ� �ٲ��.
This.GetChild('div',idwc_1)
idwc_1.SetTransObject( SQLCA )
idwc_1.retrieve('X')

This.GetChild('specgubun',idwc_2)
idwc_2.SetTransObject( SQLCA )
idwc_2.retrieve('X')

This.InsertRow(0)
end event

event itemchanged;CHOOSE CASE dwo.name
	CASE 'xplant'
		This.SetItem(1,'div','')
		IF isnull(data) THEN
			data = ''
		END IF
		
		This.GetChild('div', idwc_1 )
		idwc_1.SetTransObject( SQLCA )
		idwc_1.Retrieve(data)
		
		
	CASE 'devicegubun'
		This.SetItem(1,'specgubun','')
		IF isnull(data) THEN
			data = ''
		END IF
		
		////����ũž�� ��Ʈ���� ��籸���� �����ؼ� ����.
		IF data = 'N' THEN
			data = 'D'
		END IF
		This.GetChild('specgubun', idwc_2 )
		idwc_2.SetTransObject( SQLCA )
		
		idwc_2.Retrieve(data)
		
END CHOOSE
end event

type tabpage_4 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 4530
integer height = 2324
long backcolor = 12632256
string text = "S/W ���/����/����"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
dw_43 dw_43
dw_42 dw_42
dw_41 dw_41
dw_40 dw_40
end type

on tabpage_4.create
this.dw_43=create dw_43
this.dw_42=create dw_42
this.dw_41=create dw_41
this.dw_40=create dw_40
this.Control[]={this.dw_43,&
this.dw_42,&
this.dw_41,&
this.dw_40}
end on

on tabpage_4.destroy
destroy(this.dw_43)
destroy(this.dw_42)
destroy(this.dw_41)
destroy(this.dw_40)
end on

type dw_43 from datawindow within tabpage_4
integer x = 2807
integer y = 224
integer width = 1710
integer height = 1440
integer taborder = 50
string title = "none"
string dataobject = "d_aut322u_43"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;This.SetTransObject(sqlca)
idw_43 = this
end event

event clicked;String ls_dept, ls_ficode, ls_fimodel, ls_fibudt

This.SelectRow(0,False)
This.SelectRow(row,True)
//f_pur040_mselect(this, row)  //reference 'this'���Ұ�,����������

//�ڷ���� �κ� Ŭ���� ���� ����
IF dwo.name = "datawindow" Then
	This.SelectRow(0,false)
End IF
this.SetRedraw(False)
IF row < 1 THEN
   IF f_pur040_getobjph(this,is_colnm) = 1 THEN
		this.setsort(is_colnm)
      this.sort()
	 END IF
	 this.SetRedraw(True)
	 RETURN
END IF
this.SetRedraw(True)

ls_dept    = This.GetItemString(row,'fiusdept')
ls_ficode  = This.GetItemString(row,'ficode')
ls_fimodel = This.GetItemString(row,'fimodel')
ls_fibudt  = This.GetItemString(row,'fibudt')

////HW��Ͽ����� ��ȸ�ؼ� �����Ҽ� ������... Ȯ���ϰ� �ϱ� ���ؼ�.
IF idw_42.GetItemStatus(1,0,Primary!) = NewModified! THEN
	idw_42.object.dept[1]        = ls_dept
	idw_42.object.chid[1]        = ls_fimodel
	idw_42.object.asdt[1]        = ls_fibudt
	idw_42.object.asid[1]        = ls_ficode
END IF



end event

type dw_42 from datawindow within tabpage_4
integer y = 1708
integer width = 3803
integer height = 600
integer taborder = 50
string title = "none"
string dataobject = "d_aut322u_42"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;This.SetTransObject(sqlca)
idw_42 = this

////div�� ������ �����ϸ� �ٲ��.
This.GetChild('div',idwc_1)
idwc_1.SetTransObject( SQLCA )
idwc_1.retrieve('X')

This.GetChild('swvgubun',idwc_2)
idwc_2.SetTransObject( SQLCA )
idwc_2.retrieve('X')

//This.InsertRow(0)
end event

event itemchanged;String ls_swnm, ls_asid, ls_asdt, ls_xplant, ls_div, ls_dept, ls_fibudt
CHOOSE CASE dwo.name
	CASE 'chid'
		//HW������ �ִ� ����ȣ�� ��ġ�Ǵ� ������ �����ͼ� Setting
		
		This.SetItem(1,'xplant','')
		This.SetItem(1,'div','')
		This.SetItem(1,'dept','')
		IF isnull(data) THEN
			data = ''
		END IF
		
		SELECT ASID,ASDT,XPLANT,DIV,DEPT 
		INTO   :ls_asid,:ls_asdt,:ls_xplant,:ls_div,:ls_dept
		FROM PBCOMMON.COMM810
		WHERE COMLTD  = '01' AND
				CHID    = :data ;
				
		IF SQLCA.SQLCode <> 0 THEN
			MessageBox("Ȯ��","�⺻ �����͸� ���� �� �� �����ϴ�.~r" + &
						  "�ʿ��� �����͸� ���� �Է��ϸ� �˴ϴ�.")
		END IF
		
		This.SetItem(1,'xplant',ls_xplant)
		
		This.GetChild('div', idwc_1 )
		idwc_1.SetTransObject( SQLCA )
		idwc_1.Retrieve(ls_xplant)
		
		This.SetItem(1,'div',ls_div)	
		This.SetItem(1,'dept',ls_dept)
	CASE 'asid'	
		SELECT FIBUDT
		INTO   :ls_fibudt
		FROM PBFIA.FIA030 
		WHERE  FICODE = :data ;
		
		IF SQLCA.SQLCode = -1 THEN
			MessageBox("Ȯ��","�ڻ������ �����߻�:" + SQLCA.SQLErrText)
			Return 1
		END IF
		
		IF SQLCA.SQLCode = 100 THEN
			MessageBox("Ȯ��",&
						  "�ڻ��ڵ带 Ȯ���غ�����.~r")
		END IF
		
		This.SetItem(1,'asdt',ls_fibudt)
	CASE 'xplant'
		This.SetItem(1,'div','')
		IF isnull(data) THEN
			data = ''
		END IF
		
		This.GetChild('div', idwc_1 )
		idwc_1.SetTransObject( SQLCA )
		idwc_1.Retrieve(data)
		
	CASE 'swlgubun'
		This.SetItem(1,'swvgubun','')
		IF isnull(data) THEN
			data = ''
		END IF
		
		////����ũž�� ��Ʈ���� ��籸���� �����ؼ� ����.
		IF data = 'N' THEN
			data = 'D'
		END IF
		This.GetChild('swvgubun', idwc_2 )
		idwc_2.SetTransObject( SQLCA )
		
		idwc_2.Retrieve(data)	
			
	CASE 'swvgubun'
		This.SetItem(1,'swnm','')
		IF isnull(data) THEN
			data = ''
		END IF
		
		SELECT COITNAME 
		INTO   :ls_swnm
		FROM PBCOMMON.DAC002
		WHERE COMLTD  = '01' AND
				COGUBUN = 'COMMAL' AND
				COCODE  = :data ;
				
		IF SQLCA.SQLCode <> 0 THEN
			MessageBox("Ȯ��","SW��Ī�� ���� �� �� �����ϴ�.")
			Return
		END IF
		
		This.SetItem(1,'swnm',ls_swnm)		
END CHOOSE
end event

type dw_41 from datawindow within tabpage_4
integer x = -14
integer y = 224
integer width = 2779
integer height = 1440
integer taborder = 40
string title = "none"
string dataobject = "d_aut322u_41"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;This.SetTransObject(sqlca)
idw_41 = this
end event

event clicked;This.SelectRow(0,False)
This.SelectRow(row,True)
//f_pur040_mselect(this, row)  //reference 'this'���Ұ�,����������

//�ڷ���� �κ� Ŭ���� ���� ����
IF dwo.name = "datawindow" Then
	This.SelectRow(0,false)
End IF
this.SetRedraw(False)
IF row < 1 THEN
   IF f_pur040_getobjph(this,is_colnm) = 1 THEN
		this.setsort(is_colnm)
      this.sort()
	 END IF
	 this.SetRedraw(True)
	 RETURN
END IF
this.SetRedraw(True)

string ls_swkey, ls_xplant, ls_swlgubun

ls_swkey         = trim(This.object.swkey[row])
ls_xplant        = trim(This.object.xplant[row])
ls_swlgubun      = trim(This.object.swlgubun[row])

idw_42.Reset()

idw_42.Retrieve(ls_swkey)

idw_42.GetChild('div',idwc_1)
idwc_1.SetTransObject( SQLCA )
idwc_1.Retrieve(ls_xplant)

idw_42.GetChild('swvgubun',idwc_2)
idwc_2.SetTransObject( SQLCA )
idwc_2.Retrieve(ls_swlgubun)

wf_icon_onoff(true,true,true,true,false,true,false,true,false)
end event

type dw_40 from datawindow within tabpage_4
event ue_dwnkey pbm_dwnkey
integer x = 14
integer y = 16
integer width = 4498
integer height = 200
integer taborder = 30
string title = "none"
string dataobject = "d_aut322u_40"
boolean border = false
boolean livescroll = true
end type

event ue_dwnkey;if key = keyenter! then
	iw_sheet.triggerevent('ue_retrieve')
end if
end event

event constructor;This.SetTransObject(sqlca)
idw_40 = this

//This.GetChild('xplant',idwc_1)
//idwc_1.SetTransObject( SQLCA )
//idwc_1.Retrieve()

////div�� ������ �����ϸ� �ٲ��.
This.GetChild('div',idwc_1)
idwc_1.SetTransObject( SQLCA )
idwc_1.retrieve('X')

This.GetChild('swvgubun',idwc_2)
idwc_2.SetTransObject( SQLCA )
idwc_2.retrieve('X')


This.InsertRow(0)
end event

event itemchanged;CHOOSE CASE dwo.name
	CASE 'xplant'
		This.SetItem(1,'div','')
		IF isnull(data) THEN
			data = ''
		END IF
		
		This.GetChild('div', idwc_1 )
		idwc_1.SetTransObject( SQLCA )
		idwc_1.Retrieve(data)
		
	CASE 'swlgubun'
		This.SetItem(1,'swvgubun','')
		IF isnull(data) THEN
			data = ''
		END IF
		
		////����ũž�� ��Ʈ���� ��籸���� �����ؼ� ����.
		IF data = 'N' THEN
			data = 'D'
		END IF
		This.GetChild('swvgubun', idwc_2 )
		idwc_2.SetTransObject( SQLCA )
		
		idwc_2.Retrieve(data)	
			
END CHOOSE
end event

type tabpage_5 from userobject within tab_1
boolean visible = false
integer x = 18
integer y = 100
integer width = 4530
integer height = 2324
boolean enabled = false
long backcolor = 12632256
string text = "S/W��ȸ"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
dw_51 dw_51
dw_50 dw_50
end type

on tabpage_5.create
this.dw_51=create dw_51
this.dw_50=create dw_50
this.Control[]={this.dw_51,&
this.dw_50}
end on

on tabpage_5.destroy
destroy(this.dw_51)
destroy(this.dw_50)
end on

type dw_51 from datawindow within tabpage_5
integer x = 23
integer y = 208
integer width = 4489
integer height = 2104
integer taborder = 50
string title = "none"
string dataobject = "d_aut322u_51"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;This.SetTransObject(sqlca)
idw_51 = this
end event

event clicked;This.SelectRow(0,False)
This.SelectRow(row,True)
//f_pur040_mselect(this, row)  //reference 'this'���Ұ�,����������

//�ڷ���� �κ� Ŭ���� ���� ����
IF dwo.name = "datawindow" Then
	This.SelectRow(0,false)
End IF
this.SetRedraw(False)
IF row < 1 THEN
   IF f_pur040_getobjph(this,is_colnm) = 1 THEN
		this.setsort(is_colnm)
      this.sort()
	 END IF
	 this.SetRedraw(True)
	 RETURN
END IF
this.SetRedraw(True)

//string ls_xplant, ls_div, ls_dept, ls_swlgubun, ls_swvgubun
//
//ls_xplant      = trim(This.object.xplant[row])
//ls_div         = trim(This.object.div[row])
//ls_dept        = trim(This.object.dept[row])
//ls_swlgubun    = trim(This.object.swlgubun[row])
//ls_swvgubun    = trim(This.object.swvgubun[row])
//
//idw_62.Reset()
//idw_62.Retrieve(ls_xplant, ls_div, ls_dept, ls_swlgubun, ls_swvgubun)
//
//wf_icon_onoff(true,true,true,true,false,false,false,true,false)
end event

type dw_50 from datawindow within tabpage_5
event ue_dwnkey pbm_dwnkey
integer x = 23
integer y = 12
integer width = 4489
integer height = 200
integer taborder = 20
string title = "none"
string dataobject = "d_aut322u_50"
boolean border = false
boolean livescroll = true
end type

event ue_dwnkey;if key = keyenter! then
	iw_sheet.triggerevent('ue_retrieve')
end if
end event

event constructor;This.SetTransObject(sqlca)
idw_50 = this

////div�� ������ �����ϸ� �ٲ��.
This.GetChild('div',idwc_1)
idwc_1.SetTransObject( SQLCA )
idwc_1.retrieve('X')

This.GetChild('swvgubun',idwc_2)
idwc_2.SetTransObject( SQLCA )
idwc_2.retrieve('X')


This.InsertRow(0)
end event

event itemchanged;CHOOSE CASE dwo.name
	CASE 'xplant'
		This.SetItem(1,'div','')
		IF isnull(data) THEN
			data = ''
		END IF
		
		This.GetChild('div', idwc_1 )
		idwc_1.SetTransObject( SQLCA )
		idwc_1.Retrieve(data)
		
	CASE 'swlgubun'
		This.SetItem(1,'swvgubun','')
		IF isnull(data) THEN
			data = ''
		END IF
		
		////����ũž�� ��Ʈ���� ��籸���� �����ؼ� ����.
		IF data = 'N' THEN
			data = 'D'
		END IF
		This.GetChild('swvgubun', idwc_2 )
		idwc_2.SetTransObject( SQLCA )
		
		idwc_2.Retrieve(data)	
			
END CHOOSE
end event

type tabpage_6 from userobject within tab_1
boolean visible = false
integer x = 18
integer y = 100
integer width = 4530
integer height = 2324
boolean enabled = false
long backcolor = 12632256
string text = "S/W ��������"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
dw_62 dw_62
dw_61 dw_61
dw_60 dw_60
end type

on tabpage_6.create
this.dw_62=create dw_62
this.dw_61=create dw_61
this.dw_60=create dw_60
this.Control[]={this.dw_62,&
this.dw_61,&
this.dw_60}
end on

on tabpage_6.destroy
destroy(this.dw_62)
destroy(this.dw_61)
destroy(this.dw_60)
end on

type dw_62 from datawindow within tabpage_6
integer x = 18
integer y = 1944
integer width = 4485
integer height = 368
integer taborder = 90
string title = "none"
string dataobject = "d_aut322u_62"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;String  ls_swnm
CHOOSE CASE dwo.name
	CASE 'xplant'
		This.SetItem(1,'div','')
		IF isnull(data) THEN
			data = ''
		END IF
		
		This.GetChild('div', idwc_1 )
		idwc_1.SetTransObject( SQLCA )
		idwc_1.Retrieve(data)
		
	CASE 'swlgubun'
		This.SetItem(1,'swvgubun','')
		IF isnull(data) THEN
			data = ''
		END IF
		
		This.GetChild('swvgubun', idwc_2 )
		idwc_2.SetTransObject( SQLCA )
		
		idwc_2.Retrieve(data)
	CASE 'swvgubun'
		This.SetItem(1,'swnm','')
		IF isnull(data) THEN
			data = ''
		END IF
		
		SELECT COITNAME 
		INTO   :ls_swnm
		FROM PBCOMMON.DAC002
		WHERE COMLTD  = '01' AND
				COGUBUN = 'COMMAL' AND
				COCODE  = :data ;
				
		IF SQLCA.SQLCode <> 0 THEN
			MessageBox("Ȯ��","SW��Ī�� ���� �� �� �����ϴ�.")
			Return
		END IF
		
		This.SetItem(1,'swnm',ls_swnm)
			
END CHOOSE
end event

event constructor;This.SetTransObject(sqlca)
idw_62 = this

////div�� ������ �����ϸ� �ٲ��.
This.GetChild('div',idwc_1)
idwc_1.SetTransObject( SQLCA )
idwc_1.retrieve('X')

This.GetChild('swvgubun',idwc_2)
idwc_2.SetTransObject( SQLCA )
idwc_2.retrieve('X')


//This.InsertRow(0)
end event

type dw_61 from datawindow within tabpage_6
integer x = 18
integer y = 216
integer width = 4485
integer height = 1704
integer taborder = 60
string title = "none"
string dataobject = "d_aut322u_61"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;This.SetTransObject(sqlca)
idw_61 = this
end event

event clicked;This.SelectRow(0,False)
This.SelectRow(row,True)
//f_pur040_mselect(this, row)  //reference 'this'���Ұ�,����������

//�ڷ���� �κ� Ŭ���� ���� ����
IF dwo.name = "datawindow" Then
	This.SelectRow(0,false)
End IF
this.SetRedraw(False)
IF row < 1 THEN
   IF f_pur040_getobjph(this,is_colnm) = 1 THEN
		this.setsort(is_colnm)
      this.sort()
	 END IF
	 this.SetRedraw(True)
	 RETURN
END IF
this.SetRedraw(True)

string ls_xplant, ls_div, ls_dept, ls_swlgubun, ls_swvgubun

ls_xplant      = trim(This.object.xplant[row])
ls_div         = trim(This.object.div[row])
ls_dept        = trim(This.object.dept[row])
ls_swlgubun    = trim(This.object.swlgubun[row])
ls_swvgubun    = trim(This.object.swvgubun[row])

idw_62.Reset()
idw_62.Retrieve(ls_xplant, ls_div, ls_dept, ls_swlgubun, ls_swvgubun)

wf_icon_onoff(true,true,true,true,false,false,false,true,false)
end event

type dw_60 from datawindow within tabpage_6
event ue_dwnkey pbm_dwnkey
integer x = 23
integer y = 20
integer width = 4489
integer height = 200
integer taborder = 20
string title = "none"
string dataobject = "d_aut322u_60"
boolean border = false
boolean livescroll = true
end type

event ue_dwnkey;if key = keyenter! then
	iw_sheet.triggerevent('ue_retrieve')
end if
end event

event constructor;This.SetTransObject(sqlca)
idw_60 = this

////div�� ������ �����ϸ� �ٲ��.
This.GetChild('div',idwc_1)
idwc_1.SetTransObject( SQLCA )
idwc_1.retrieve('X')

This.GetChild('swvgubun',idwc_2)
idwc_2.SetTransObject( SQLCA )
idwc_2.retrieve('X')


This.InsertRow(0)
end event

event itemchanged;CHOOSE CASE dwo.name
	CASE 'xplant'
		This.SetItem(1,'div','')
		IF isnull(data) THEN
			data = ''
		END IF
		
		This.GetChild('div', idwc_1 )
		idwc_1.SetTransObject( SQLCA )
		idwc_1.Retrieve(data)
		
	CASE 'swlgubun'
		This.SetItem(1,'swvgubun','')
		IF isnull(data) THEN
			data = ''
		END IF
		
		This.GetChild('swvgubun', idwc_2 )
		idwc_2.SetTransObject( SQLCA )
		
		idwc_2.Retrieve(data)	
			
END CHOOSE
end event

type tabpage_7 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 4530
integer height = 2324
long backcolor = 12632256
string text = "�����ڵ����"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
dw_72 dw_72
dw_71 dw_71
dw_70 dw_70
end type

on tabpage_7.create
this.dw_72=create dw_72
this.dw_71=create dw_71
this.dw_70=create dw_70
this.Control[]={this.dw_72,&
this.dw_71,&
this.dw_70}
end on

on tabpage_7.destroy
destroy(this.dw_72)
destroy(this.dw_71)
destroy(this.dw_70)
end on

type dw_72 from datawindow within tabpage_7
integer x = 9
integer y = 1896
integer width = 4503
integer height = 412
integer taborder = 80
string title = "none"
string dataobject = "d_aut322u_72"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;This.SetTransObject(sqlca)
idw_72 = this
end event

type dw_71 from datawindow within tabpage_7
integer x = 9
integer y = 124
integer width = 4503
integer height = 1752
integer taborder = 70
string title = "none"
string dataobject = "d_aut322u_71"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;This.SetTransObject(sqlca)
idw_71 = this
end event

event clicked;This.SelectRow(0,False)
This.SelectRow(row,True)
//f_pur040_mselect(this, row)  //reference 'this'���Ұ�,����������

//�ڷ���� �κ� Ŭ���� ���� ����
IF dwo.name = "datawindow" Then
	This.SelectRow(0,false)
End IF
this.SetRedraw(False)
IF row < 1 THEN
   IF f_pur040_getobjph(this,is_colnm) = 1 THEN
		this.setsort(is_colnm)
      this.sort()
	 END IF
	 this.SetRedraw(True)
	 RETURN
END IF
this.SetRedraw(True)

string ls_cogubun, ls_cocode

ls_cogubun      = trim(This.object.cogubun[row])
ls_cocode       = trim(This.object.cocode[row])

idw_72.Reset()
idw_72.Retrieve(ls_cogubun, ls_cocode)

wf_icon_onoff(true,true,true,true,false,true,false,true,false)
end event

type dw_70 from datawindow within tabpage_7
event ue_dwnkey pbm_dwnkey
integer x = 14
integer y = 16
integer width = 4498
integer height = 108
integer taborder = 30
string title = "none"
string dataobject = "d_aut322u_70"
boolean border = false
boolean livescroll = true
end type

event ue_dwnkey;if key = keyenter! then
	iw_sheet.triggerevent('ue_retrieve')
end if
end event

event constructor;This.SetTransObject(sqlca)
idw_70 = this
This.InsertRow(0)
end event

type tabpage_8 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 4530
integer height = 2324
long backcolor = 12632256
string text = "Report"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
dw_81_print dw_81_print
pb_excel pb_excel
pb_print pb_print
ddlb_2 ddlb_2
st_2 st_2
dw_81 dw_81
dw_80 dw_80
dw_80_dept dw_80_dept
end type

on tabpage_8.create
this.dw_81_print=create dw_81_print
this.pb_excel=create pb_excel
this.pb_print=create pb_print
this.ddlb_2=create ddlb_2
this.st_2=create st_2
this.dw_81=create dw_81
this.dw_80=create dw_80
this.dw_80_dept=create dw_80_dept
this.Control[]={this.dw_81_print,&
this.pb_excel,&
this.pb_print,&
this.ddlb_2,&
this.st_2,&
this.dw_81,&
this.dw_80,&
this.dw_80_dept}
end on

on tabpage_8.destroy
destroy(this.dw_81_print)
destroy(this.pb_excel)
destroy(this.pb_print)
destroy(this.ddlb_2)
destroy(this.st_2)
destroy(this.dw_81)
destroy(this.dw_80)
destroy(this.dw_80_dept)
end on

type dw_81_print from datawindow within tabpage_8
boolean visible = false
integer x = 3461
integer y = 512
integer width = 686
integer height = 400
integer taborder = 80
boolean enabled = false
string dataobject = "d_aut322u_81_8_print"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;This.SetTransObject(sqlca)
idw_81_print = this
end event

type pb_excel from picturebutton within tabpage_8
boolean visible = false
integer x = 4338
integer y = 12
integer width = 155
integer height = 132
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
boolean enabled = false
string picturename = "C:\KDAC\bmp\Excel.bmp"
alignment htextalign = left!
end type

event clicked;f_save_to_excel(idw_81)
end event

type pb_print from picturebutton within tabpage_8
boolean visible = false
integer x = 4155
integer y = 12
integer width = 155
integer height = 132
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
boolean enabled = false
string picturename = "Print!"
alignment htextalign = left!
end type

event clicked;idw_81_print.print()
end event

type ddlb_2 from dropdownlistbox within tabpage_8
integer x = 242
integer y = 20
integer width = 1061
integer height = 544
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 33554432
long backcolor = 15780518
boolean autohscroll = true
boolean hscrollbar = true
boolean vscrollbar = true
string item[] = {"1:������ PC ������Ȳ","2:�μ��� PC ������Ȳ","3:�뵵�� PC ������Ȳ","4:������ S/W Liscence ������Ȳ","5:�μ��� S/W Liscence ������Ȳ","6:������/�뵵�� PC������Ȳ(����������)","7:������/��� PC������Ȳ(����������)","8.PC ������Ȳ(�ǻ����)"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;String          ls_gubun
Datawindowchild cdw_1

ii_index2 = index

idw_10.Reset()
CHOOSE CASE index
	////������ PC ������Ȳ
	CASE 1
		idw_80.Visible = True
		idw_80.Enabled = True
		idw_80_dept.Visible = False
		idw_80_dept.Enabled = False
		idw_81.DataObject = "d_aut322u_81_1"  
      idw_81.SetTransObject(sqlca)
		
	////������/�μ��� PC ������Ȳ
	CASE 2
		idw_80.Visible = True
		idw_80.Enabled = True
		idw_80_dept.Visible = False
		idw_80_dept.Enabled = False
		idw_81.DataObject = "d_aut322u_81_2"  
      idw_81.SetTransObject(sqlca)
	
	////�뵵�� H/W ������Ȳ
	CASE 3
		idw_80.Visible = True
		idw_80.Enabled = True
		idw_80_dept.Visible = False
		idw_80_dept.Enabled = False
		idw_81.DataObject = "d_aut322u_81_3"  
      idw_81.SetTransObject(sqlca)
	
	////������ S/W ������Ȳ
	CASE 4
		idw_80.Visible = False
		idw_80.Enabled = False
		idw_80_dept.Visible = False
		idw_80_dept.Enabled = False
		idw_81.DataObject = "d_aut322u_81_4"  
      idw_81.SetTransObject(sqlca)
		
	////������/�μ��� S/W ������Ȳ
	CASE 5
		idw_80.Visible = False
		idw_80.Enabled = False
		idw_80_dept.Visible = False
		idw_80_dept.Enabled = False
		idw_81.DataObject = "d_aut322u_81_5"  
      idw_81.SetTransObject(sqlca)
		
	////������/�뵵�� PC ������Ȳ
	CASE 6
		idw_80.Visible = True
		idw_80.Enabled = True
		idw_80_dept.Visible = False
		idw_80_dept.Enabled = False
		idw_81.DataObject = "d_aut322u_81_6"  
      idw_81.SetTransObject(sqlca)	
	
	////������/��� PC ������Ȳ
	CASE 7
		idw_80.Visible = True
		idw_80.Enabled = True
		idw_80_dept.Visible = False
		idw_80_dept.Enabled = False
		idw_81.DataObject = "d_aut322u_81_7"  
      idw_81.SetTransObject(sqlca)	
	CASE 8
		idw_80.Visible = False
		idw_80.Enabled = False
		idw_80_dept.Visible = True
		idw_80_dept.Enabled = True
		idw_81.DataObject = "d_aut322u_81_8"  
      idw_81.SetTransObject(sqlca)		
END CHOOSE

idw_80.InsertRow(0)
idw_80.SetFocus()

end event

type st_2 from statictext within tabpage_8
integer x = 23
integer y = 32
integer width = 219
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 33554432
long backcolor = 12632256
string text = "Report"
boolean focusrectangle = false
end type

type dw_81 from datawindow within tabpage_8
integer x = -14
integer y = 160
integer width = 4498
integer height = 2144
integer taborder = 70
string title = "none"
string dataobject = "d_aut322u_81_1"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;This.SetTransObject(sqlca)
idw_81 = this
end event

event clicked;This.SelectRow(0,False)
This.SelectRow(row,True)
//f_pur040_mselect(this, row)  //reference 'this'���Ұ�,����������

//�ڷ���� �κ� Ŭ���� ���� ����
IF dwo.name = "datawindow" Then
	This.SelectRow(0,false)
End IF
this.SetRedraw(False)
IF row < 1 THEN
   IF f_pur040_getobjph(this,is_colnm) = 1 THEN
		this.setsort(is_colnm)
      this.sort()
	 END IF
	 this.SetRedraw(True)
	 RETURN
END IF
this.SetRedraw(True)
end event

type dw_80 from datawindow within tabpage_8
integer x = 1339
integer y = 20
integer width = 1792
integer height = 104
integer taborder = 20
string title = "none"
string dataobject = "d_aut322u_80"
boolean border = false
boolean livescroll = true
end type

event constructor;This.SetTransObject(sqlca)
idw_80 = this

////div�� ������ �����ϸ� �ٲ��.
//This.GetChild('div',idwc_1)
//idwc_1.SetTransObject( SQLCA )
//idwc_1.retrieve('X')
//
This.InsertRow(0)

end event

type dw_80_dept from datawindow within tabpage_8
boolean visible = false
integer x = 1339
integer y = 20
integer width = 2551
integer height = 104
integer taborder = 30
string title = "none"
string dataobject = "d_aut322u_80_dept"
boolean border = false
boolean livescroll = true
end type

event constructor;This.SetTransObject(sqlca)
idw_80_dept = this
This.InsertRow(0)
end event

type tabpage_9 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 4530
integer height = 2324
long backcolor = 12632256
string text = "Notes DB����"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
dw_93 dw_93
hpb_1 hpb_1
dw_92 dw_92
dw_91 dw_91
st_5 st_5
end type

on tabpage_9.create
this.dw_93=create dw_93
this.hpb_1=create hpb_1
this.dw_92=create dw_92
this.dw_91=create dw_91
this.st_5=create st_5
this.Control[]={this.dw_93,&
this.hpb_1,&
this.dw_92,&
this.dw_91,&
this.st_5}
end on

on tabpage_9.destroy
destroy(this.dw_93)
destroy(this.hpb_1)
destroy(this.dw_92)
destroy(this.dw_91)
destroy(this.st_5)
end on

type dw_93 from datawindow within tabpage_9
boolean visible = false
integer x = 3625
integer y = 44
integer width = 686
integer height = 400
integer taborder = 30
boolean enabled = false
string title = "none"
string dataobject = "d_aut322u_92"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;This.SetTransObject(sqlca)
idw_93 = this
end event

type hpb_1 from hprogressbar within tabpage_9
integer x = 14
integer y = 2212
integer width = 4498
integer height = 100
unsignedinteger maxposition = 100
integer setstep = 10
boolean smoothscroll = true
end type

type dw_92 from datawindow within tabpage_9
integer x = 2267
integer y = 128
integer width = 2245
integer height = 2068
integer taborder = 40
string title = "none"
string dataobject = "d_aut322u_92"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;This.SetTransObject(sqlca)
idw_92 = this
end event

event clicked;This.SelectRow(0,False)
This.SelectRow(row,True)
//f_pur040_mselect(this, row)  //reference 'this'���Ұ�,����������

//�ڷ���� �κ� Ŭ���� ���� ����
IF dwo.name = "datawindow" Then
	This.SelectRow(0,false)
End IF
this.SetRedraw(False)
IF row < 1 THEN
   IF f_pur040_getobjph(this,is_colnm) = 1 THEN
		this.setsort(is_colnm)
      this.sort()
	 END IF
	 this.SetRedraw(True)
	 RETURN
END IF
this.SetRedraw(True)
end event

type dw_91 from datawindow within tabpage_9
integer x = 14
integer y = 128
integer width = 2231
integer height = 2068
integer taborder = 30
string title = "none"
string dataobject = "d_aut322u_91"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;This.SetTransObject(sqlca)
idw_91 = this
end event

type st_5 from statictext within tabpage_9
integer x = 32
integer y = 40
integer width = 581
integer height = 52
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 33554432
long backcolor = 12632256
string text = "���S/W��Ȳ"
boolean focusrectangle = false
end type

type tabpage_10 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 4530
integer height = 2324
long backcolor = 12632256
string text = "��� vs IP"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
st_6 st_6
dw_ip dw_ip
end type

on tabpage_10.create
this.st_6=create st_6
this.dw_ip=create dw_ip
this.Control[]={this.st_6,&
this.dw_ip}
end on

on tabpage_10.destroy
destroy(this.st_6)
destroy(this.dw_ip)
end on

type st_6 from statictext within tabpage_10
integer x = 27
integer y = 40
integer width = 2016
integer height = 48
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 134217856
long backcolor = 12632256
string text = "��� ���� ����ϰ� �ִ� ����� IP�� �Է����ּ���!"
boolean focusrectangle = false
end type

type dw_ip from datawindow within tabpage_10
event ue_up_and_down pbm_dwnkey
integer x = 9
integer y = 128
integer width = 4512
integer height = 2188
integer taborder = 80
string title = "none"
string dataobject = "d_aut322u_ip"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_up_and_down;If Not (Key = KeyUpArrow! Or Key = KeyDownArrow!) Then
	Return 0
End If

Long	ll_Row

ll_Row = This.GetRow( )

Choose Case Key
	Case KeyDownArrow!	
		
		If ll_Row <> This.RowCount( ) Then 
			ll_Row ++			
				
			This.ScrollToRow( ll_Row )
			f_Multi_Select_Row( This, ll_Row, 0 )			
			il_PreRow = ll_Row
			
			//wf_Click_Retrieve( ll_Row, idw_11, idw_12 )
			Return 1		
		End If
		 
	Case KeyUpArrow!
		
		If ll_Row <> 1 Then
			ll_Row --
					
			This.ScrollToRow( ll_Row )
			f_Multi_Select_Row( This, ll_Row, 0 )			
			il_PreRow = ll_Row
			
			//wf_Click_Retrieve( ll_Row, idw_11, idw_12 )
			Return 1
		End If
		
End Choose
end event

event constructor;This.SetTransObject(sqlca)
idw_ip = this
end event

event clicked;This.SelectRow(0,False)
This.SelectRow(row,True)
//f_pur040_mselect(this, row)  //reference 'this'���Ұ�,����������

//�ڷ���� �κ� Ŭ���� ���� ����
IF dwo.name = "datawindow" Then
	This.SelectRow(0,false)
End IF
this.SetRedraw(False)
IF row < 1 THEN
   IF f_pur040_getobjph(this,is_colnm) = 1 THEN
		this.setsort(is_colnm)
      this.sort()
	 END IF
	 this.SetRedraw(True)
	 RETURN
END IF
this.SetRedraw(True)
end event

event itemchanged;

CHOOSE CASE dwo.name
	CASE 'usingip'
		
		data = Trim(data)
		
		//����
		String 	ls_ip[]
		Long		ll_ip[], ll_pos, ll_length, ll_temp_pos[]
		Int		ii, li_cnt
		
		//�ʱ�ȭ.
		li_cnt = 0 
		ll_pos = 0
		
		////////////////////üũ �Ϲ�////////////////////////////////
		//���� üũ
		IF Len(data) = 0 THEN
			Return
		END IF
		
		IF Len(data) >= 1 AND Len(data) < 7 THEN
			MessageBox("Error", "IP �ּҰ� �߸��Ǿ����ϴ� : " + &
							"IP�� �ּ� ���̴� 7 ���� Ů�ϴ�.( ex: 1.0.1.1 )")
			Return 1
			
		END IF
		
		IF Len(data) > 15 THEN
			MessageBox("Error", "IP �ּҰ� �߸��Ǿ����ϴ� : " + &
							"�� IP���̰� 15 ���� Ŭ ���� �����ϴ�.")
			Return 1
		END IF
		
		//.�� ���� ���´ٰ� ����...
		FOR ii = 1 TO 4
			
			ll_pos = Pos(data, ".", ll_pos + 1)
			
			IF ll_pos <> 0 THEN
				li_cnt++
				
			ELSE
				EXIT
			END IF
		NEXT
		
		IF li_cnt <> 3 THEN
			MessageBox("Error", String(li_cnt) + "IP �ּҰ� �߸��Ǿ����ϴ� : " + & 
							"������ '.' �� ���� �־�� �ùٸ� IP �Դϴ�.")
			Return 1
		END IF
		//////////////////////////////////////////////////////////////
		
		ll_pos = 0
		
		FOR ii = 1 TO 4
			ll_pos = Pos(data, ".", ll_pos + 1)
			
			ll_temp_pos[ii] = ll_pos
			
			IF ll_pos <> 0 THEN
				
				IF ii = 1 THEN
					ls_ip[ii] = Mid(data,ii,(ll_temp_pos[ii] - 1))
				ELSEIF ii = 2 THEN
					ls_ip[ii] = Mid(data,(ll_temp_pos[ii - 1] + 1), (ll_temp_pos[ii] - ll_temp_pos[ii - 1] - 1))
				ELSEIF ii = 3 THEN
					ls_ip[ii] = Mid(data,(ll_temp_pos[ii - 1] + 1), (ll_temp_pos[ii] - ll_temp_pos[ii - 1] - 1))	
				
				ELSE
					EXIT
				END IF
			ELSE
				IF ii = 4 THEN
					ls_ip[ii] = MId(data,(ll_temp_pos[ii - 1] + 1), (Len(data) - ll_temp_pos[ii - 1] )) 
				ELSE
					EXIT
				END IF
			END IF
			
			//MessageBox("Ȯ��",String(ll_pos) + " : " +ls_ip[ii] + " : " + String(Len(data)))
			
			IF Len(ls_ip[ii]) <= 0 THEN
				MessageBox("Error", "IP �ּҰ� �߸��Ǿ����ϴ� : " + & 
								".������ ������ ���̴� 0 ���� Ŀ�� �մϴ�.")
				Return 1	
			END IF	
			
			IF Len(ls_ip[ii]) > 3 THEN
				MessageBox("Error", "IP �ּҰ� �߸��Ǿ����ϴ� : " + &  
								".������ ������ ���̴� 3 ���� �۾ƾ� �մϴ�.")
				Return 1	
			END IF
			
			IF Len(ls_ip[ii]) = 2 THEN
				IF Mid(ls_ip[ii],1,1) = '0' THEN
					MessageBox("Error", "IP �ּҰ� �߸��Ǿ����ϴ� : " + & 
									"ù��° �ڸ��� ���ڴ� 0 �� �� �����ϴ�.")
					Return 1	
				END IF
			END IF
			
			IF Len(ls_ip[ii]) = 3 THEN
				
				IF Mid(ls_ip[ii],1,1) = '0' THEN
//					IF Mid(ls_ip[ii],2,1) = '0' THEN
//						MessageBox("Error", "IP �ּҰ� �߸��Ǿ����ϴ�. : " + &
//										"ù��° �ڸ��� ���ڴ� 0 �� �� �����ϴ�.")
//						Return 1	
//					END IF
					MessageBox("Error", "IP �ּҰ� �߸��Ǿ����ϴ� : " + &
									"ù��° �ڸ��� ���ڴ� 0 �� �� �����ϴ�.")
					Return 1	
				END IF
			END IF	
			
			
			IF isNumber(ls_ip[ii]) = FALSE THEN
				MessageBox("Error", "IP �ּҰ� �߸��Ǿ����ϴ� : " + & 
								"IP�� �����̾�� �մϴ�.")
				Return 1
			ELSE
				ll_ip[ii] = Long(ls_ip[ii])
				
				IF ll_ip[ii] > 255 OR ll_ip[ii] < 0 THEN
					MessageBox("Error", "IP �ּҰ� �߸��Ǿ����ϴ� : " + & 
								"IP�� 0 �� 255 ������ ���̾�� �մϴ�.")
					Return 1
				END IF
			END IF
			
		NEXT
		/*
		//�׹�°�� üũ ���ϳ�...
		ls_ip[4] = MId(data,(ll_temp_pos[3] + 1), (Len(data) - ll_temp_pos[3] )) 
		
		IF Len(ls_ip[4]) <= 0 THEN
			MessageBox("Error", "IP �ּҰ� �߸��Ǿ����ϴ� : " + & 
							".������ ������ ���̴� 0 ���� Ŀ�� �մϴ�.")
			Return 1	
		END IF	
		
		IF Len(ls_ip[4]) > 3 THEN
			MessageBox("Error", "IP �ּҰ� �߸��Ǿ����ϴ� : " + &  
							".������ ������ ���̴� 3 ���� �۾ƾ� �մϴ�.")
			Return 1	
		END IF
		
		IF Len(ls_ip[4]) = 2 THEN
			IF Mid(ls_ip[4],1,1) = '0' THEN
				MessageBox("Error", "IP �ּҰ� �߸��Ǿ����ϴ� : " + & 
								"ù��° �ڸ��� ���ڴ� 0 �� �� �����ϴ�.")
				Return 1	
			END IF
		END IF
	
		IF Len(ls_ip[4]) = 3 THEN
			
			IF Mid(ls_ip[4],1,1) = '0' THEN
//					IF Mid(ls_ip[ii],2,1) = '0' THEN
//						MessageBox("Error", "IP �ּҰ� �߸��Ǿ����ϴ�. : " + &
//										"ù��° �ڸ��� ���ڴ� 0 �� �� �����ϴ�.")
//						Return 1	
//					END IF
				MessageBox("Error", "IP �ּҰ� �߸��Ǿ����ϴ� : " + &
								"ù��° �ڸ��� ���ڴ� 0 �� �� �����ϴ�.")
				Return 1	
			END IF
		END IF	
		
		IF isNumber(ls_ip[4]) = FALSE THEN
			MessageBox("Error", "IP �ּҰ� �߸��Ǿ����ϴ� : " + & 
							"IP�� �����̾�� �մϴ�.")
			Return 1
		ELSE
			ll_ip[4] = Long(ls_ip[4])
			
			IF ll_ip[4] > 255 OR ll_ip[4] < 0 THEN
				MessageBox("Error", "IP �ּҰ� �߸��Ǿ����ϴ� : " + & 
							"IP�� 0 �� 255 ������ ���̾�� �մϴ�.")
				Return 1
			END IF
		END IF
	*/
END CHOOSE
end event

event itemerror;This.setFocus()
Return 1
end event

type tabpage_11 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 4530
integer height = 2324
long backcolor = 12632256
string text = "�μ��ϰ�����"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
dw_111 dw_111
st_7 st_7
end type

on tabpage_11.create
this.dw_111=create dw_111
this.st_7=create st_7
this.Control[]={this.dw_111,&
this.st_7}
end on

on tabpage_11.destroy
destroy(this.dw_111)
destroy(this.st_7)
end on

type dw_111 from datawindow within tabpage_11
integer x = 23
integer y = 96
integer width = 4498
integer height = 2176
integer taborder = 40
string title = "none"
string dataobject = "d_aut322u_111"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;This.SetTransObject(sqlca)
idw_111 = this
end event

type st_7 from statictext within tabpage_11
integer x = 23
integer y = 20
integer width = 3209
integer height = 84
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 134217856
long backcolor = 12632256
string text = "���� �λ��ڷ��� ���κ� �μ������� H/W ������ ��ϵ� ����� �μ������� Ʋ�� ����������� ����"
boolean focusrectangle = false
end type

