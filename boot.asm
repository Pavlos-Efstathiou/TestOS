bits 16

org 0x7c00 ; BIOS offset

mov ah, 06h    ; Scroll up function
xor al, al     ; Clear entire screen
xor cx, cx     ; Upper left corner CH=row, CL=column
mov dx, 184Fh  ; Lower right corner DH=row, DL=column 
mov bh, 1Fh    ; Dark blue background, white letters
int 10h

mov si, logo    ; Moves the logo variable to the si register to print it
call print      ; calls print
int 10h         ; Issue a BIOS interrupt for video services  
jmp $           ; Infinite loop

print:
    lodsb           ; Load byte at address si to al
    test al, al     ; Check if al==0 / a NULL byte, meaning end of a C string
    jz end          ; Exits when a NULL byte is found  
    mov ah, 0Eh     ; BIOS teletype
    int 0x10        ; Issue a BIOS interrupt for video services                                                
    jmp print       ; Repeat
    end:            ; End label
        ret         ; Returns the printed text

; The 0 ends the string. If I didn't put that there it would also print the next string
logo db " _   _       _    __          ___           _                   ", 0Ah, 0Dh, "| \ | |     | |   \ \        / (_)         | |                  ", 0Ah, 0Dh, "|  \| | ___ | |_   \ \  /\  / / _ _ __   __| | _____      _____ ", 0Ah, 0Dh, "| . ` |/ _ \| __|   \ \/  \/ / | | '_ \ / _` |/ _ \ \ /\ / / __|", 0Ah, 0Dh, "| |\  | (_) | |_     \  /\  /  | | | | | (_| | (_) \ V  V /\__ \", 0Ah, 0Dh, "|_| \_|\___/ \__|     \/  \/   |_|_| |_|\__,_|\___/ \_/\_/ |___/", 0Ah, 0Dh, 0
times 510 - ($ - $$) db 0
dw 0xAA55