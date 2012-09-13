$PBExportHeader$n_capture.sru
$PBExportComments$화면캡쳐 NVO
forward
global type n_capture from nonvisualobject
end type
end forward

global type n_capture from nonvisualobject
end type
global n_capture n_capture

type prototypes
FUNCTION boolean GetWindowRect(ulong handle, ref rectangle RectStruct) LIBRARY "User32.dll"
FUNCTION ulong GetActiveWindow( ) LIBRARY "User32.dll"
FUNCTION ulong GetDesktopWindow( ) LIBRARY "User32.dll"
FUNCTION ulong GetDC(ulong handle) LIBRARY "User32.dll"
FUNCTION integer GetClipboardFormatName( UINT  uFormat,string lpszFormatName, integer  cchFormatName)  LIBRARY "User32.dll"
subroutine CopyBitmap( blob b, ulong s, long l ) alias for RtlMoveMemory library "kernel32.dll"
subroutine CopyBitmapFileHeader( ref blob b, str_bitmapheader b, long l ) alias for RtlMoveMemory library "kernel32.dll"
subroutine CopyBitmapInfoHeader( ref blob b, str_bitmapinfoheader b, long l ) alias for RtlMoveMemory library "kernel32.dll"
subroutine CopyBitmapInfo( ref blob b, str_bitmapinfo b, long l ) alias for RtlMoveMemory library "kernel32.dll"
function long GetDIBits(ulong hdc, ulong bitmap, ulong start, ulong lines, ref blob bits, ref str_bitmapinfo i, ulong pallete ) library "gdi32.dll"
function long GetDIBits(ulong hdc, ulong bitmap, ulong start, ulong lines, long bits, ref str_bitmapinfo i, ulong pallete ) library "gdi32.dll"


function ulong CopyWindowToDIB(ulong hWnd, int fPrintArea) library 'dibapi.dll'
function int DestroyDIB(ulong hDib) library 'dibapi.dll'
function int SaveDIB(ulong hDib, string lpFileName) library 'dibapi.dll'
end prototypes

type variables
Blob ib_Data
end variables

forward prototypes
public function integer of_screen_capture (ref blob ab_data)
end prototypes

public function integer of_screen_capture (ref blob ab_data);//Long ll_DeskHwnd, ll_Hdc, ll_HdcMem, ll_HBitmap
//Long ll_FLeft, ll_FTop, ll_Fwidth, ll_Fheight
//Long ll_Return
//
//Window	lw_Sheet
//
//lw_Sheet = w_frame.GetActiveSheet( )
//
//ll_DeskHwnd = Handle( lw_Sheet )
//		// 현 활성화된 윈도우의 핸들을 가져온다.
//		
//ll_Fleft = UnitsToPixels( lw_Sheet.X, XUnitsToPixels! )
//ll_FTop = UnitsToPixels( lw_Sheet.Y, YUnitsToPixels! )
//ll_Fwidth = UnitsToPixels( lw_Sheet.Width, XUnitsToPixels! )
//ll_Fheight = UnitsToPixels( lw_Sheet.Height, YUnitsToPixels! )
//		// 현 화면의 위치정보를 파워빌더 단위로 바꾼다.
//
//ll_Hdc = GetDC( ll_DeskHwnd )
//		// Device의 시스템정보를 가져온다.
//ll_HdcMem = CreateCompatibleDC( ll_Hdc )
//		// Device의 크기만큼 메모리를 생성한다.
//ll_HBitmap = CreateCompatibleBitmap( ll_Hdc, ll_Fwidth, ll_Fheight )
//		// 현 화면의 정보를 할당할 메모리를 생성한다.
//
//If ll_hBitmap <> 0 Then
//	ll_Return = SelectObject( ll_hdcMem, ll_hBitmap )
//
//ll_Return = BitBlt( ll_HdcMem, 0, 0, ll_Fwidth, ll_Fheight, ll_Hdc, ll_Fleft, ll_FTop, 13369376 )
//		// 현 화면의 정보를 할당한 메모리에 Copy 한다.
//
//ll_

return 1
end function

on n_capture.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_capture.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

