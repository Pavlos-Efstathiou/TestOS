bits 16

org 0x7c00

mov ah, 06h    ; Scroll up function
xor al, al     ; Clear entire screen
xor cx, cx     ; Upper left corner CH=row, CL=column
mov dx, 184Fh  ; Lower right corner DH=row, DL=column 
mov bh, 1Fh    ; black on white
int 10h

mov si, text
call print
mov ah, 0
int 16h
jmp $ ; Infinite loop

print:
    ; Load byte at address si to al
    lodsb
    ; Check if al==0 / a NULL byte, meaning end of a C string
    test al, al
    ; If al==0, jump to end, where the bootloader will be halted
    jz end
    ; BIOS teletype
    mov ah, 0Eh
    ; Issue a BIOS interrupt 0x10 for video services
    int 0x10                                                
    ; Repeat
    jmp print
    end:
        ret

text db "Bootloader loaded", 0Ah, 0Dh
not_protected db "Not running under protected mode", 0Ah, 0Dh
times 510 - ($ - $$) db 0
dw 0xAA55