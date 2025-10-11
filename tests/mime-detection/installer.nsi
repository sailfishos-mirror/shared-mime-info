!include "nsDialogs.nsh"
!include "winmessages.nsh"
!include "logiclib.nsh"
OutFile "test.exe"
 
Page Custom pre
 
var dialog
var hwnd
var button
 
Function pre
	nsDialogs::Create 1018
	Pop $dialog
	${NSD_CreateCheckbox} 0 0 50% 6% "Enable button below"
		Pop $hwnd
		${NSD_OnClick} $hwnd EnDisableButton
 
	${NSD_CreateButton} 25% 25% 50% 50% "Hello World"
		Pop $button
		EnableWindow $button 0 # start out disabled
 
	nsDialogs::Show
FunctionEnd
 
Function EnDisableButton
	Pop $hwnd
	${NSD_GetState} $hwnd $0
	${If} $0 == 1
		EnableWindow $button 1
	${Else}
		EnableWindow $button 0
	${EndIf}
FunctionEnd
 
Section ""
SectionEnd