; hello-os
; TAB=4

		ORG		0x7c00			; w¾öI?n¬

; Èº?q?°?yFATi®??

		JMP		entry
		DB		0x90
		DB		"HELLOIPL"		; ??æI¼ÌÂÈ¥CÓIøi8?j
		DW		512				; ?¢îæisectorjIå¬iK??512?j
		DB		1				; âÆiclusterjIå¬iK??1¢îæj
		DW		1				; FATINnÊuiêÊ¸æê¢îæ?nj
		DB		2				; FATI¢iK??2j
		DW		224				; ªÚ?Iå¬iêÊ?¬224?j
		DW		2880			; ?¥?Iå¬iK?¥2880îæj
		DB		0xf0			; ¥?I??iK?¥0xf0j
		DW		9				; FATI?xiK?¥9îæj
		DW		18				; 1¢¥¹itrackjL{¢îæiK?¥18j
		DW		2				; ¥?iK?¥2j
		DD		0				; s?pªæCK?¥0
		DD		2880			; dÊê¥?å¬
		DB		0,0,0x29		; Ó?s¾CÅè
		DD		0xffffffff		; (Â\¥) É??
		DB		"HELLO-OS   "	; ¥?I¼Ìi11?jÓFø¢IóiÂs¥ÖUÊIC§¥?¹?[?
		DB		"FAT12   "		; ¥?i®¼Ìi8?j
		RESB	18				; æóo18?

; öjS

entry:
		MOV		AX,0			; n»ñ¶í
		MOV		SS,AX
		MOV		SP,0x7c00
		MOV		DS,AX
		MOV		ES,AX

		MOV		SI,msg
putloop:						; z?
		MOV		AL,[SI]			; cSIn¬Iê¢?Iàe?üAL
		ADD		SI,1			; ?SIÁ1
		CMP		AL,0			; ä?AL¥Û°0
		JE		fin				; @Êä?I?Ê¬§C?µ?fin,fin¥ê¢?C\¦g?©h
		MOV		AH,0x0e			; ?¦ê¢¶
		MOV		BX,15			; wè?F
		INT		0x10			; ?p??BIOSCINT ¥ê¢fwßC?¢ÂÈ??ð?g?ph
		JMP		putloop
fin:
		HLT						; ?CPUâ~CÒwßC?CPU?üÒ÷ó?
		JMP		fin				; ÙÀz?

msg:
		DB		0x0a, 0x0a		; ?s?
		DB		"hello,Inios"
		DB		0x0a			; ?s
		DB		0

		RESB	0x7dfe-$		; ¸0x7dfen¬?np0x00U[

		DB		0x55, 0xaa

; Èº¥ø?îæÈOIªI?q

		DB		0xf0, 0xff, 0xff, 0x00, 0x00, 0x00, 0x00, 0x00
		RESB	4600
		DB		0xf0, 0xff, 0xff, 0x00, 0x00, 0x00, 0x00, 0x00
		RESB	1469432