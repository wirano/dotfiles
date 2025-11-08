" Vim syntax file
" Language: ASL (ACPI source language)
" Author: Mika Westerberg

" Quit when a (custom) syntax file was already loaded
if exists("b:current_syntax")
  finish
endif

syn case ignore

" Comments
syn keyword aslTodo contained TODO FIXME XXX NOTE
syn match aslLineComment "\/\/.*" contains=aslTodo
syn region aslComment start="/\*" end="\*/" contains=aslTodo

syn region aslString start=+"+ skip=+\\\\\|\\"+ end=+"\|$+

syn match aslNumber "\<[0-9_]\+\>"
syn match aslNumber "\<0x[0-9a-fA-F_]\+\>"

syn match aslVariables "\<Arg[0-9]\>"
syn match aslVariables "\<Local[0-9]\>"

" Predefined Names (beginning with underscore)
syn match aslPredefined "\<_[A-Z][A-Z0-9]\{2,3}\>"
syn match aslPredefined "\<_T_[0-9]\>"

syn keyword aslOperators AccessAs Acquire Add Alias And BankField Break BreakPoint Buffer
syn keyword aslOperators Case Concatenate ConcatenateResTemplate CondRefOf Connection Continue
syn keyword aslOperators CopyObject CreateBitField CreateByteField CreateDWordField CreateField
syn keyword aslOperators CreateQWordField CreateWordField DataTableRegion Debug Decrement Default
syn keyword aslOperators DefinitionBlock DeRefOf Device Divide Eisaid Else ElseIf Event Fatal Field
syn keyword asloperators FindSetLeftBit FindSetRightBit FromBcd Function If Increment Index IndexField
syn keyword aslOperators LAnd LEqual LGreater LGreaterEqual LLess LLessEqual LNot LNotEqual Load LoadTable
syn keyword aslOperators LOr Match Method Mid Mod Multiply Mutex Name NAnd Noop NOr Not Notify ObjectType
syn keyword aslOperators Offset One Ones OperationRegion Or Package PowerResource Processor RefOf Release
syn keyword aslOperators Reset Return Revision Scope ShiftLeft ShiftRight Signal SizeOf Sleep Stall Store
syn keyword aslOperators Subtract Switch ThermalZone Timer ToBcd ToBuffer ToDecimalString ToHexString
syn keyword aslOperators ToInteger ToString ToUuid Unicode Unload Wait While XOr Zero

syn keyword aslKeywords External

syn keyword aslResources ResourceTemplate RawDataBuffer DMA DWordIO DWordMemory DWordSpace EndDependentFn
syn keyword aslResources ExtendedIO ExtendedMemory ExtendedSpace FixedDma FixedIO GpioInt GpioIo I2cSerialBus
syn keyword aslResources I2cSerialBusV2 Interrupt IO IRQ IRQNoFlags Memory24 Memory32 Memory32Fixed
syn keyword aslResources QWordIO QWordMemory QWordSpace Register SpiSerialBus SpiSerialBusV2
syn keyword aslResources StartDependentFn StartDependentFnNoPri UartSerialBus UartSerialBusV2 VendorLong
syn keyword aslResources VendorShort WordBusNumber WordIO WordSpace

syn keyword aslIncludes Include

" Highlight trailing whitespace
syn match aslSpaceError "\s\+$" display

hi link aslLineComment Comment
hi link aslComment Comment
hi link aslTodo Todo
hi link aslString String
hi link aslNumber Number
hi link aslVariables Identifier
hi link aslOperators Keyword
hi link aslKeywords Keyword
hi link aslResources Type
hi link aslIncludes Include
hi link aslSpaceError Error
hi link aslPredefined PreProc

" iASL specifics
syn region iaslInclude start="^\s*\(%:\|#\)\s*include\>\s*["<]" end="$"
syn region iaslDefine start="^\s*\(%:\|#\)\s*\(if\|ifdef\|else\|define\|undef\|endif\)\>" skip="\\$" end="$"
hi link iaslInclude Include
hi link iaslDefine Define

let b:current_syntax = "asl"
