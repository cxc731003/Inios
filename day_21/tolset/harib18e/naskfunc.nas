; naskfunc
; TAB=4

[FORMAT "WCOFF"]				; 崙恬朕炎猟周議庁塀	
[INSTRSET "i486p"]				; 傍苧聞喘議頁486凋綜
[BITS 32]						; 崙恬32了庁塀喘議字亠囂冱
[FILE "naskfunc.nas"]			; 坿猟周兆佚連

		GLOBAL	_io_hlt, _io_cli, _io_sti, _io_stihlt
		GLOBAL	_io_in8,  _io_in16,  _io_in32
		GLOBAL	_io_out8, _io_out16, _io_out32
		GLOBAL	_io_load_eflags, _io_store_eflags
		GLOBAL	_load_gdtr, _load_idtr
		GLOBAL	_load_cr0, _store_cr0
		GLOBAL	_load_tr
		GLOBAL	_asm_inthandler20, _asm_inthandler21
		GLOBAL	_asm_inthandler27, _asm_inthandler2c
		GLOBAL	_asm_inthandler0d
		GLOBAL	_memtest_sub
		GLOBAL	_farjmp, _farcall
		GLOBAL	_asm_hrb_api, _start_app
		EXTERN	_inthandler20, _inthandler21
		EXTERN	_inthandler27, _inthandler2c
		EXTERN	_inthandler0d
		EXTERN	_hrb_api

[SECTION .text]

_io_hlt:	; void io_hlt(void);
		HLT
		RET

_io_cli:	; void io_cli(void);
		CLI
		RET

_io_sti:	; void io_sti(void);
		STI
		RET

_io_stihlt:	; void io_stihlt(void);
		STI
		HLT
		RET

_io_in8:	; int io_in8(int port);
		MOV		EDX,[ESP+4]		; port
		MOV		EAX,0
		IN		AL,DX
		RET

_io_in16:	; int io_in16(int port);
		MOV		EDX,[ESP+4]		; port
		MOV		EAX,0
		IN		AX,DX
		RET

_io_in32:	; int io_in32(int port);
		MOV		EDX,[ESP+4]		; port
		IN		EAX,DX
		RET

_io_out8:	; void io_out8(int port, int data);
		MOV		EDX,[ESP+4]		; port
		MOV		AL,[ESP+8]		; data
		OUT		DX,AL
		RET

_io_out16:	; void io_out16(int port, int data);
		MOV		EDX,[ESP+4]		; port
		MOV		EAX,[ESP+8]		; data
		OUT		DX,AX
		RET

_io_out32:	; void io_out32(int port, int data);
		MOV		EDX,[ESP+4]		; port
		MOV		EAX,[ESP+8]		; data
		OUT		DX,EAX
		RET

_io_load_eflags:	; int io_load_eflags(void);
		PUSHFD		; PUSH EFLAGS という吭龍
		POP		EAX
		RET

_io_store_eflags:	; void io_store_eflags(int eflags);
		MOV		EAX,[ESP+4]
		PUSH	EAX
		POPFD		; POP EFLAGS という吭龍
		RET

_load_gdtr:		; void load_gdtr(int limit, int addr);
		MOV		AX,[ESP+4]		; limit
		MOV		[ESP+6],AX
		LGDT	[ESP+6]
		RET

_load_idtr:		; void load_idtr(int limit, int addr);
		MOV		AX,[ESP+4]		; limit
		MOV		[ESP+6],AX
		LIDT	[ESP+6]
		RET

_load_cr0:		; int load_cr0(void);
		MOV		EAX,CR0
		RET

_store_cr0:		; void store_cr0(int cr0);
		MOV		EAX,[ESP+4]
		MOV		CR0,EAX
		RET

_load_tr:		; void load_tr(int tr);
		LTR		[ESP+4]			; tr
		RET

_asm_inthandler20:
		PUSH	ES
		PUSH	DS
		PUSHAD
		MOV		AX,SS
		CMP		AX,1*8
		JNE		.from_app
;	輝荷恬狼由試強扮恢伏嶄僅議秤趨才岻念餓音謹
		MOV		EAX,ESP
		PUSH	SS				; 隠贋嶄僅扮議SS
		PUSH	EAX				; 隠贋嶄僅扮議ESP
		MOV		AX,SS
		MOV		DS,AX
		MOV		ES,AX
		CALL	_inthandler20
		ADD		ESP,8
		POPAD
		POP		DS
		POP		ES
		IRETD
.from_app:
;	輝哘喘殻會試強扮窟伏嶄僅
		MOV		EAX,1*8
		MOV		DS,AX			; 枠叙繍DS譜協葎荷恬狼由喘
		MOV		ECX,[0xfe4]		; 荷恬狼由議ESP
		ADD		ECX,-8
		MOV		[ECX+4],SS		; 隠贋嶄僅扮議SS
		MOV		[ECX  ],ESP		; 隠贋嶄僅扮議ESP
		MOV		SS,AX
		MOV		ES,AX
		MOV		ESP,ECX
		CALL	_inthandler20
		POP		ECX
		POP		EAX
		MOV		SS,AX			; 繍SS譜指哘喘殻會喘
		MOV		ESP,ECX			; 繍ESP譜指哘喘殻會喘
		POPAD
		POP		DS
		POP		ES
		IRETD

_asm_inthandler21:
		PUSH	ES
		PUSH	DS
		PUSHAD
		MOV		AX,SS
		CMP		AX,1*8
		JNE		.from_app
;	輝荷恬狼由試強扮恢伏嶄僅議秤趨才岻念餓音謹
		MOV		EAX,ESP
		PUSH	SS				; 隠贋嶄僅扮議SS
		PUSH	EAX				; 隠贋嶄僅扮議ESP
		MOV		AX,SS
		MOV		DS,AX
		MOV		ES,AX
		CALL	_inthandler21
		ADD		ESP,8
		POPAD
		POP		DS
		POP		ES
		IRETD
.from_app:
;	輝哘喘殻會試強扮窟伏嶄僅
		MOV		EAX,1*8
		MOV		DS,AX			; 枠叙繍DS譜協葎荷恬狼由喘
		MOV		ECX,[0xfe4]		; 荷恬狼由議ESP
		ADD		ECX,-8
		MOV		[ECX+4],SS		; 隠贋嶄僅扮議SS
		MOV		[ECX  ],ESP		; 隠贋嶄僅扮議ESP
		MOV		SS,AX
		MOV		ES,AX
		MOV		ESP,ECX
		CALL	_inthandler21
		POP		ECX
		POP		EAX
		MOV		SS,AX			; 繍SS譜指哘喘殻會喘
		MOV		ESP,ECX			; 繍ESP譜指哘喘殻會喘
		POPAD
		POP		DS
		POP		ES
		IRETD

_asm_inthandler27:
		PUSH	ES
		PUSH	DS
		PUSHAD
		MOV		AX,SS
		CMP		AX,1*8
		JNE		.from_app
;	輝荷恬狼由試強扮恢伏嶄僅議秤趨才岻念餓音謹
		MOV		EAX,ESP
		PUSH	SS				; 隠贋嶄僅扮議SS
		PUSH	EAX				; 隠贋嶄僅扮議ESP
		MOV		AX,SS
		MOV		DS,AX
		MOV		ES,AX
		CALL	_inthandler27
		ADD		ESP,8
		POPAD
		POP		DS
		POP		ES
		IRETD
.from_app:
;	輝哘喘殻會試強扮窟伏嶄僅
		MOV		EAX,1*8
		MOV		DS,AX			; 枠叙繍DS譜協葎荷恬狼由喘
		MOV		ECX,[0xfe4]		; 荷恬狼由議ESP
		ADD		ECX,-8
		MOV		[ECX+4],SS		; 隠贋嶄僅扮議SS
		MOV		[ECX  ],ESP		; 隠贋嶄僅扮議ESP
		MOV		SS,AX
		MOV		ES,AX
		MOV		ESP,ECX
		CALL	_inthandler27
		POP		ECX
		POP		EAX
		MOV		SS,AX			; 繍SS譜指哘喘殻會喘
		MOV		ESP,ECX			; 繍ESP譜指哘喘殻會喘
		POPAD
		POP		DS
		POP		ES
		IRETD

_asm_inthandler2c:
		PUSH	ES
		PUSH	DS
		PUSHAD
		MOV		AX,SS
		CMP		AX,1*8
		JNE		.from_app
;	輝荷恬狼由試強扮恢伏嶄僅議秤趨才岻念餓音謹
		MOV		EAX,ESP
		PUSH	SS				; 隠贋嶄僅扮議SS
		PUSH	EAX				; 隠贋嶄僅扮議ESP
		MOV		AX,SS
		MOV		DS,AX
		MOV		ES,AX
		CALL	_inthandler2c
		ADD		ESP,8
		POPAD
		POP		DS
		POP		ES
		IRETD
.from_app:
;	輝哘喘殻會試強扮窟伏嶄僅
		MOV		EAX,1*8
		MOV		DS,AX			; 枠叙繍DS譜協葎荷恬狼由喘
		MOV		ECX,[0xfe4]		; 荷恬狼由議ESP
		ADD		ECX,-8
		MOV		[ECX+4],SS		; 隠贋嶄僅扮議SS
		MOV		[ECX  ],ESP		; 隠贋嶄僅扮議ESP
		MOV		SS,AX
		MOV		ES,AX
		MOV		ESP,ECX
		CALL	_inthandler2c
		POP		ECX
		POP		EAX
		MOV		SS,AX			; 繍SS譜指哘喘殻會喘
		MOV		ESP,ECX			; 繍ESP譜指哘喘殻會喘
		POPAD
		POP		DS
		POP		ES
		IRETD
		
_asm_inthandler0d:
		STI
		PUSH	ES
		PUSH	DS
		PUSHAD
		MOV		AX,SS
		CMP		AX,1*8
		JNE		.from_app
;	輝荷恬狼由試強扮恢伏嶄僅議秤趨才岻念餓音謹
		MOV		EAX,ESP
		PUSH	SS				; 隠贋嶄僅扮議SS
		PUSH	EAX				; 隠贋嶄僅扮議ESP
		MOV		AX,SS
		MOV		DS,AX
		MOV		ES,AX
		CALL	_inthandler0d
		ADD		ESP,8
		POPAD
		POP		DS
		POP		ES
		ADD		ESP,4			; 壓 INT 0x0d 嶄俶勣緩鞘旗鷹
		IRETD
.from_app:
;	輝哘喘殻會試強扮窟伏嶄僅
		CLI
		MOV		EAX,1*8
		MOV		DS,AX			; 枠叙繍DS譜協葎荷恬狼由喘
		MOV		ECX,[0xfe4]		; 荷恬狼由ESP
		ADD		ECX,-8
		MOV		[ECX+4],SS		; 隠贋嶄僅扮議SS
		MOV		[ECX  ],ESP		; 隠贋嶄僅扮議ESP
		MOV		SS,AX
		MOV		ES,AX
		MOV		ESP,ECX
		STI
		CALL	_inthandler0d
		CLI
		CMP		EAX,0
		JNE		.kill
		POP		ECX
		POP		EAX
		MOV		SS,AX			; 繍SS志鹸葎哘喘殻會喘
		MOV		ESP,ECX			; 繍ESP志鹸葎哘喘殻會喘
		POPAD
		POP		DS
		POP		ES
		ADD		ESP,4			; 壓 INT 0x0d 嶄俶勣緩鞘旗鷹
		IRETD
.kill:
;	繍哘喘殻會膿崙潤崩
		MOV		EAX,1*8			; 荷恬狼由喘DS/SS
		MOV		ES,AX
		MOV		SS,AX
		MOV		DS,AX
		MOV		FS,AX
		MOV		GS,AX
		MOV		ESP,[0xfe4]		; 膿崙卦指欺start_app扮議ESP
		STI			; 俳算頼撹朔志鹸嶄僅萩箔
		POPAD	; 志鹸並枠隠贋議篠贋匂議峙
		RET
		
_memtest_sub:	; unsigned int memtest_sub(unsigned int start, unsigned int end)
		PUSH	EDI						; ��EBX, ESI, EDI も聞いたいので��
		PUSH	ESI
		PUSH	EBX
		MOV		ESI,0xaa55aa55			; pat0 = 0xaa55aa55;
		MOV		EDI,0x55aa55aa			; pat1 = 0x55aa55aa;
		MOV		EAX,[ESP+12+4]			; i = start;
mts_loop:
		MOV		EBX,EAX
		ADD		EBX,0xffc				; p = i + 0xffc;
		MOV		EDX,[EBX]				; old = *p;
		MOV		[EBX],ESI				; *p = pat0;
		XOR		DWORD [EBX],0xffffffff	; *p ^= 0xffffffff;
		CMP		EDI,[EBX]				; if (*p != pat1) goto fin;
		JNE		mts_fin
		XOR		DWORD [EBX],0xffffffff	; *p ^= 0xffffffff;
		CMP		ESI,[EBX]				; if (*p != pat0) goto fin;
		JNE		mts_fin
		MOV		[EBX],EDX				; *p = old;
		ADD		EAX,0x1000				; i += 0x1000;
		CMP		EAX,[ESP+12+8]			; if (i <= end) goto mts_loop;
		JBE		mts_loop
		POP		EBX
		POP		ESI
		POP		EDI
		RET
mts_fin:
		MOV		[EBX],EDX				; *p = old;
		POP		EBX
		POP		ESI
		POP		EDI
		RET

_farjmp:		; void farjmp(int eip, int cs);
		JMP		FAR	[ESP+4]				; eip, cs
		RET

_farcall:		; void farcall(int eip, int cs);
		CALL	FAR	[ESP+4]				; eip, cs
		RET

_asm_hrb_api:
		; 葎圭宴軟需貫蝕遊祥鋤峭嶄僅萩箔
		PUSH	DS
		PUSH	ES
		PUSHAD		; 喘噐隠贋議PUSH
		MOV		EAX,1*8
		MOV		DS,AX			; 枠叙繍DS譜協葎荷恬狼由喘
		MOV		ECX,[0xfe4]		; 荷恬狼由議ESP
		ADD		ECX,-40
		MOV		[ECX+32],ESP	; 隠贋哘喘殻會議ESP
		MOV		[ECX+36],SS		; 隠贋哘喘殻會議SS

; 繍PUSHAD朔議峙験峙欺狼由媚

		MOV		EDX,[ESP   ]
		MOV		EBX,[ESP+ 4]
		MOV		[ECX   ],EDX	; 鹸崙勧弓公hrb_api
		MOV		[ECX+ 4],EBX	; 鹸崙勧弓公hrb_api
		MOV		EDX,[ESP+ 8]
		MOV		EBX,[ESP+12]
		MOV		[ECX+ 8],EDX	; 鹸崙勧弓公hrb_api
		MOV		[ECX+12],EBX	; 鹸崙勧弓公hrb_api
		MOV		EDX,[ESP+16]
		MOV		EBX,[ESP+20]
		MOV		[ECX+16],EDX	; 鹸崙勧弓公hrb_api
		MOV		[ECX+20],EBX	; 鹸崙勧弓公hrb_api
		MOV		EDX,[ESP+24]
		MOV		EBX,[ESP+28]
		MOV		[ECX+24],EDX	; 鹸崙勧弓公hrb_api
		MOV		[ECX+28],EBX	; 鹸崙勧弓公hrb_api

		MOV		ES,AX			; 繍複噫議粁篠贋匂匆譜葎荷恬狼由喘
		MOV		SS,AX
		MOV		ESP,ECX
		STI			; 志鹸嶄僅萩箔

		CALL	_hrb_api

		MOV		ECX,[ESP+32]	; 函竃哘喘殻會議ESP
		MOV		EAX,[ESP+36]	; 函竃哘喘殻會議SS
		CLI
		MOV		SS,AX
		MOV		ESP,ECX
		POPAD
		POP		ES
		POP		DS
		IRETD		; 宸倖凋綜氏徭強峇佩STI

_start_app:		; void start_app(int eip, int cs, int esp, int ds);
		PUSHAD		; 繍32了篠贋匂議峙畠何隠贋軟栖
		MOV		EAX,[ESP+36]	; 哘喘殻會喘EIP
		MOV		ECX,[ESP+40]	; 哘喘殻會喘CS
		MOV		EDX,[ESP+44]	; 哘喘殻會喘ESP
		MOV		EBX,[ESP+48]	; 哘喘殻會喘DS/SS
		MOV		[0xfe4],ESP		; 荷恬狼由ESP
		CLI			; 壓俳算狛殻嶄鋤峭嶄僅萩箔
		MOV		ES,BX
		MOV		SS,BX
		MOV		DS,BX
		MOV		FS,BX
		MOV		GS,BX
		MOV		ESP,EDX
		STI			; 俳算頼撹朔志鹸嶄僅萩箔
		PUSH	ECX				; 喘噐far-CALL議PUSH��cs��
		PUSH	EAX				; 喘噐far-CALL議PUSH��eip��
		CALL	FAR [ESP]		; 距喘哘喘殻會

;	哘喘殻會潤崩朔卦指緩侃

		MOV		EAX,1*8			; 荷恬狼由喘DS/SS
		CLI			; 壅肝序佩俳算��鋤峭嶄僅萩箔
		MOV		ES,AX
		MOV		SS,AX
		MOV		DS,AX
		MOV		FS,AX
		MOV		GS,AX
		MOV		ESP,[0xfe4]
		STI			; 俳算頼撹朔志鹸嶄僅萩箔
		POPAD	; 志鹸岻念隠贋議篠贋匂峙
		RET
