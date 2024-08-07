#ifndef __SET_EXTENSIONS_H__
#define __SET_EXTENSIONS_H__

#define portasmHAS_MTIME 1
#define portasmHANDLE_INTERRUPT 0

#define portasmADDITIONAL_CONTEXT_SIZE 0

.macro portasmSAVE_ADDITIONAL_REGISTERS
    .endm

.macro portasmRESTORE_ADDITIONAL_REGISTERS
    .endm

#endif