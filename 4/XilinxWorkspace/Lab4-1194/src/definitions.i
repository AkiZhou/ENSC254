;@ Symbols for the Zedboard
;@ as configured for ENSC 254/351 at Simon Fraser University (SFU)
;@ Copyright (C) 2019 School of Engineering Science, SFU

;@ OLED definitions
.set OLED_COLS, 16		;@ number of column on the display
.set OLED_FONT_OFFSET, 0x10000	;@ offset from OLED base address to font table buffer
.set OLED_CHAR_OFFSET, 0x10400	;@ offset from OLED base address to character display buffer


;@Define button masks
.set BtnCMask, 0x01 ;@ Center button
.set BtnDMask, 0x02 ;@ Down button
.set BtnLMask, 0x04 ;@ Left button
.set BtnRMask, 0x08 ;@ Right button
.set BtnUMask, 0x10 ;@ Up button
.set BtnAllMask, 0x1F ;@ Any button
