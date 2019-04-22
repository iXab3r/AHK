#NoEnv  
#InstallKeybdHook
SendMode Input  ; Recommended for new scripts due to its superior 
SetTitleMatchMode, 1

;SoundSet, 1, Microphone, mute  ; mute the microphone

*LAlt::
ControlSend , , {LAlt}, Ventrilo
;SoundSet, 0, Microphone, mute  ; mute the microphone
;ControlSend , Button18, {Space} , Streaming Live
return

*LAlt UP::
ControlSend , , {LAlt UP}, Ventrilo
;SoundSet, 1, Microphone, mute 
;ControlSend , Button18, {Space} , Streaming Live
return