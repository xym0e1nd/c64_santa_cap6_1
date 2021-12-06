;===============================================================================
; BASIC Loader

*=$0801 ; 10 SYS (2064)

        byte $0E, $08, $0A, $00, $9E, $20, $28, $32
        byte $30, $36, $34, $29, $00, $00, $00

        ; Our code starts at $0810 (2064 decimal)
        ; after the 15 bytes for the BASIC loader

;===============================================================================
; Initialize

        ; Turn off interrupts to stop LIBSCREEN_WAIT failing every so 
        ; often when the kernal interrupt syncs up with the scanline test
        sei

        ; Disable run/stop + restore keys
        lda #$FC 
        sta $0328

        ;scroll 38 mode
        lda $D016
        and #$F7
        sta $D016
        
        ; Set border and background colors
        ; The last 3 parameters are not used yet
        LIBSCREEN_SETCOLORS Red, White, Black, Black, Black

        ; Fill 1000 bytes (40x25) of screen memory 
        LIBSCREEN_SET1000 SCREENRAM, 'a' ; 'a' maps to char 1

        ; Fill 1000 bytes (40x25) of color memory
        LIBSCREEN_SET1000 COLORRAM, Black

        

;===============================================================================
; Update

gMLoop

        ;scroll 38 mode
        lda $D016
        and #$F7
        adc #$00
        sta $D016

        LIBSCREEN_WAIT_V 255
        ;inc EXTCOL ; start code timer change border color
        ; Game update code goes here
        ;dec EXTCOL ; end code timer reset border color
        jmp gMLoop





