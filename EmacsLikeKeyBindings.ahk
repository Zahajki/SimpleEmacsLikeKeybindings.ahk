#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

; I don't know why but cmd.exe or ConEmu with Clink cannot receive Ctrl
; with #If or #IfWinActive directive.
F13::Ctrl

; So I use #If directive here.
#If     Not WinActive("ahk_class ConsoleWindowClass")
    And Not WinActive("ahk_class VirtualConsoleClass")

; ==============================================================
; Mark Region
; ==============================================================
marked := 0
mark() {
    global marked
    marked := 1
    Return
}
unmark() {
    global marked
    marked := 0
    Return
}
toggleMark() {
    global marked
    If marked
        marked := 0
    Else
        marked := 1
    Return
}
isMarked() {
    global marked
    If marked
        Return true
    Else
        Return false
}

; ==============================================================
; Actions
; ==============================================================
stop() {
    unmark()
    Send, {Esc}
    Return
}

; --------------
; Navigation
; --------------
moveAhead() {
    If isMarked()
        Send, +{Home}
    Else
        Send, {Home}
    Return
}
moveEnd() {
    If isMarked()
        Send, +{End}
    Else
        Send, {End}
    Return
}
moveForward() {
    If isMarked()
        Send, +{Right}
    Else
        Send, {Right}
    Return
}
moveBackward() {
    If isMarked()
        Send, +{Left}
    Else
        Send, {Left}
    Return
}
moveForwardWord() {
    If isMarked()
        Send, +^{Right}
    Else
        Send, ^{Right}
    Return
}
moveBackwardWord() {
    If isMarked()
        Send, +^{Left}
    Else
        Send, ^{Left}
    Return
}
movePrevious() {
    If isMarked()
        Send, +{Up}
    Else
        Send, {Up}
    Return
}
moveNext() {
    If isMarked()
        Send, +{Down}
    Else
        Send, {Down}
    Return
}
scrollUp() {
    Send, ^{Up}
    Return
}
scrollDown() {
    Send, ^{Down}
    Return
}
scrollUpInPlace() {
    Send, ^{Up}{Up}
    Return
}
scrollDownInPlace() {
    Send, ^{Down}{Down}
    Return
}
pageup() {
    If isMarked()
        Send, +{PgUp}
    Else
        Send, {PgUp}
    Return
}
pagedown() {
    If isMarked()
        Send, +{PgDn}
    Else
        Send, {PgDn}
    Return
}

; --------------
; Edit
; --------------
newline() {
    unmark()
    Send, {Enter}
    Return
}
openline() {
    unmark()
    Send, {End}{Enter}{Up}
    Return
}
transpose() {
    unmark()
    clipSaved := ClipboardAll
    Clipboard =
    Send, +{Left}^c{Right}
    ClipWait, 1
    leftChar := Clipboard
    Clipboard =
    Send, +{Right}^c{Left}
    ClipWait, 1
    rightChar := Clipboard
    Clipboard := rightChar . leftChar
    ClipWait, 1
    Send, {Left}{ShiftDown}{Right}{Right}{ShiftUp}^v{Left}
    Sleep, 1
    Clipboard := clipSaved
    clipSaved =
    Return
}
deleteBackward() {
    unmark()
    Send, {Backspace}
    Return
}
deleteForward() {
    unmark()
    Send, {Delete}
    Return
}

; --------------
; Clipboard
; --------------
killLine() {
    unmark()
    Send, {ShiftDown}{End}{ShiftUp}^x
    Return
}
paste() {
    unmark()
    Send, ^v
    Return
}
cut() {
    unmark()
    Send, ^x
    Return
}
copy() {
    unmark()
    Send, ^c
    Return
}

; --------------
; Defaults
; --------------
save() {
    unmark()
    Send, ^s
    Return
}
undo() {
    unmark()
    Send, ^z
    Return
}

; ==============================================================
; Shortcuts
; ==============================================================
F13 & Space:: toggleMark()
F13 & vk20sc039:: toggleMark()
F13 & @:: toggleMark()
~Esc:: unmark()
F13 & g:: stop()

F13 & a:: moveAhead()
F13 & e:: moveEnd()
F13 & f:: moveForward()
F13 & b:: moveBackward()
F13 & p:: movePrevious()
F13 & n:: moveNext()
vk1Dsc07B & f:: moveForwardWord()
vk1Dsc07B & b:: moveBackwardWord()
vk1Dsc07B & p:: scrollUpInPlace()    ;pageup()
vk1Dsc07B & n:: scrollDownInPlace()  ;pagedown()

F13 & m:: newline()
F13 & o:: openline()
F13 & t:: transpose()
F13 & h:: deleteBackward()
F13 & d:: deleteForward()

F13 & k:: killLine()
F13 & y:: paste()   ; This shortcut may confuse with C-z (Undo)
F13 & w:: cut()
vk1Dsc07B & w:: copy()

; --------------
; Defaults
; --------------
F13 & s:: save()
F13 & v:: paste()
F13 & c:: copy()
F13 & x:: cut()
F13 & z:: undo()    ; This shortcut may confuse with C-y (Yank)

; --------------
; Disabled
; --------------
F13 & i::
F13 & j::
F13 & l::
F13 & q::
F13 & r::
F13 & u::
vk1Dsc07B & a::
vk1Dsc07B & c::
vk1Dsc07B & d::
vk1Dsc07B & e::
vk1Dsc07B & g::
vk1Dsc07B & h::
vk1Dsc07B & i::
vk1Dsc07B & j::
vk1Dsc07B & k::
vk1Dsc07B & l::
vk1Dsc07B & m::
vk1Dsc07B & o::
vk1Dsc07B & q::
vk1Dsc07B & r::
vk1Dsc07B & s::
vk1Dsc07B & t::
vk1Dsc07B & u::
vk1Dsc07B & x::
vk1Dsc07B & y::
vk1Dsc07B & z::
    Return
