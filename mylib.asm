.code

conversie_binar proc
	push ebp
	mov ebp, esp
	sub esp, 4
	
	mov eax, 0
	mov eax, [ebp+8]
	mov esi, biti
	mov cl, 2
et1:
	div cl
	cmp ah, 0
	je et2
	mov cod1[esi], 49
	dec esi
	cmp cod1[0], 49
	je sfarsit
	cmp al, 0
	jne et1
	jmp sfarsit
et2:
	mov cod1[esi], 48
	dec esi
	cmp esi, -1
	je sfarsit
	cmp al, 0
	jne et1
sfarsit:
	
	mov esp, ebp
	pop ebp
	ret 0
conversie_binar endp
;------------------------------------------------
conversie_decimal proc
	push ebp
	mov ebp, esp
	sub esp, 0
	
	mov esi, -1
	mov edi, 0
	mov eax, 0
	mov ebx, 0
	mov cl, 2
	mov edi, biti
et1:
	inc esi
	cmp cod1[esi], 49
	jne et3
	mov eax, 1
et2:
	mul cl
	dec edi
	cmp edi, 0
	jne et2
	add ebx, eax 
	;inc esi
	;dec biti
	;mov edi, biti
et3:
	dec biti
	mov edi, biti
	;inc esi
	cmp esi, 4
	jne et1
	cmp cod1[5], 49
	jne sfarsit
	add ebx, 1
sfarsit:
	mov numar, ebx
	
	mov esp, ebp
	pop ebp
	ret 4
conversie_decimal endp
;-----------------Encoding-----------------
encoding proc
	push ebp
	mov ebp, esp
	sub esp, 0
	
	mov ebx, 0
	mov eax, 0
	mov edx, 0
	mov ecx, 0
	push offset mode_read
	push offset filecodificare
	call fopen
	mov pointer_fisier1, eax
	
	push offset mode_read
	push offset fileread
	call fopen
	mov pointer_fisier2, eax
		
	push offset caracter1
	push offset format_caracter
	push pointer_fisier2
	call fscanf
et11:	
	mov esi, 0
	mov esi, -1
et24:	
	cmp caracter1[1], 48
	je et26
	push offset caracter1
	call strlen
	mov esi, eax
et25:
	dec esi
	mov nr4, esi
	jmp et27
et26:
	mov nr4, 0
et27:	
	push SEEK_SET
	push 0
	push pointer_fisier1
	call fseek
	jmp et1
et28:
	cmp nr, 0
	je et1
	mov ecx, 0
	mov eax, 7
	mov ecx, nr
	mul ecx
	mov ebx, 0
	sub ebx, eax
	push SEEK_CUR
	push ebx
	push pointer_fisier1
	call fseek
et1:	
	push offset caracter
	push offset format_string
	push pointer_fisier1
	call fscanf
	mov eax, -1
	mov ebx, 0
	mov ecx, 0
et16:	
	inc eax
	mov nr, eax
	mov bl, caracter[eax]
	push SEEK_CUR
	push 7
	push pointer_fisier1
	call fseek
	mov eax, nr
	cmp bl, caracter1[eax]
	jne et28
	cmp nr4, eax
	jne et16
	cmp nr4, 0
	jne et29
	push SEEK_CUR
	push -7
	push pointer_fisier1
	call fseek
	jmp et15	
et29:
	cmp nr4, 2 
	jne et33
	push SEEK_CUR
	push -20
	push pointer_fisier1
	call fseek
	jmp et15
et33:
	mov eax, 0
	sub eax, 14
	add eax, nr4
	push SEEK_CUR
	push eax
	push pointer_fisier1
	call fseek
et15:
	push offset cod2
	push offset format_string
	push pointer_fisier1
	call fscanf
	
	push offset caracter3
	push offset format_caracter
	push pointer_fisier2
	call fscanf
	
	mov esi, -1
et2:	
	cmp caracter1[1], 48
	je et3
	push offset caracter1
	call strlen
	mov edx, eax
	jmp et4
et3:
	mov edx, 1
et4:
	cmp edx, 1
	jne et5
	push SEEK_CUR
	push -2
	push pointer_fisier2
	call fseek
	push offset caracter4
	push offset format2
	push pointer_fisier2
	call fscanf
	mov nr1, 1
	jmp sf1
et5:
	cmp edx, 2
	jne et6
	push SEEK_CUR
	push -3
	push pointer_fisier2
	call fseek
	push offset caracter4
	push offset format3
	push pointer_fisier2
	call fscanf
	mov nr1, 2
	jmp sf1
et6:
	cmp edx, 3
	jne et7
	push SEEK_CUR
	push -4
	push pointer_fisier2
	call fseek
	push offset caracter4
	push offset format4
	push pointer_fisier2
	call fscanf
	mov nr1, 3
	jmp sf1
et7: 
	cmp edx, 4
	jne et8
	push SEEK_CUR
	push -5
	push pointer_fisier2
	call fseek
	push offset caracter4
	push offset format5
	push pointer_fisier2
	call fscanf
	mov ecx, 0
	mov nr1, 4
	jmp sf1
et8: 
	push SEEK_CUR
	push -6
	push pointer_fisier2
	call fseek
	push offset caracter4
	push offset format6
	push pointer_fisier2
	call fscanf
	mov ecx, 0
	mov nr1, 5
sf1: 
	mov eax, 0
	push SEEK_SET
	push 0
	push pointer_fisier1
	call fseek
	jmp et13
et21:
	cmp nr3, 0
	je et13
	mov ecx, 0
	mov eax, 7
	mov ecx, nr3
	mul ecx
	mov ebx, 0
	sub ebx, eax
	push SEEK_CUR
	push ebx
	push pointer_fisier1
	call fseek
et13:
	push offset caracter
	push offset format_string
	push pointer_fisier1
	call fscanf
	cmp eax, -1
	je et9
	mov ebx, 0
	mov eax, -1
	mov ecx, 0
et14:
	inc eax
	mov nr3, eax
	mov bl, caracter[eax]
	;mov nr2, eax
	push SEEK_CUR
	push 7
	push pointer_fisier1
	call fseek
	mov eax, nr3
	cmp bl, caracter4[eax]
	jne et21
	cmp nr1, eax
	jne et14
	mov eax, 1
et9:
	cmp eax, 1
	jne et10
	mov ecx, 0
	mov eax, 0
et18:
	mov cl, caracter4[eax]
	mov caracter1[eax], cl
	inc eax
	cmp eax, 7
	jne et18
	jmp sf3
et10:
	push offset mode_write
	push offset filewrite
	call fopen
	mov pointer_fisier4, eax

	push offset cod2
	push offset format_scriere
	push pointer_fisier4
	call fprintf
	
	push pointer_fisier4
	call fclose
	
	inc cod_intreg
	mov edi, 0
	mov edi, cod_intreg
	push edi
	call conversie_binar
	
	
	push offset mode_write
	push offset filecodificare
	call fopen
	mov pointer_fisier3, eax
	
	push offset cod1
	push offset caracter4
	push offset format1
	push pointer_fisier3
	call fprintf
	
	push pointer_fisier3
	call fclose
	
	mov ecx, 0
	mov eax, 0
et19:
	mov cl, caracter3[eax]
	mov caracter1[eax], cl
	inc eax
	cmp eax, 7
	jne et19
	
sf3:	
	mov eax, 0
	mov ebx, -1
et31:
	inc ebx
	mov al, caracter1[ebx]
	cmp al, 48
	jne et31
	dec ebx
	cmp caracter1[ebx], 35
	jne et11
	
	push SEEK_SET
	push 2
	push pointer_fisier1
	call fseek
	
	push offset cod1
	push offset format_string
	push pointer_fisier1
	call fscanf
	
	push offset mode_write
	push offset filewrite
	call fopen
	mov pointer_fisier4, eax

	push offset cod1
	push offset format_scriere
	push pointer_fisier4
	call fprintf
	
	push pointer_fisier4
	call fclose
	
	push pointer_fisier1
	call fclose
	
	push pointer_fisier2
	call fclose
		
	mov esp, ebp
	pop ebp
	ret 0
encoding endp
;---------------Decoding-------------
decoding proc
	push ebp
	mov ebp, esp
	sub esp, 0
	
	push offset mode_read
	push offset filecodificare
	call fopen
	mov ptr_fisier, eax
	
	push offset mode_read
	push offset filewrite
	call fopen
	mov ptr_fisier1, eax
	
	push offset mode_write
	push offset fileout
	call fopen
	mov ptr_fisier2, eax
et51:	
	push offset string
	push offset format_string
	push ptr_fisier1
	call fscanf
	cmp eax, -1
	je sfarsit
	push SEEK_SET
	push 0
	push ptr_fisier
	call fseek
et50:	
	push offset string1
	push offset char
	push offset format1
	push ptr_fisier
	call fscanf
	
	push offset string
	push offset string1
	call strcmp
	cmp eax, 0
	jne et50
	
	push offset char
	push offset format_string
	push ptr_fisier2
	call fprintf
	jmp et51

sfarsit:
	
	push ptr_fisier
	call fclose
	
	push ptr_fisier1
	call fclose
	
	push ptr_fisier2
	call fclose
	
	mov esp, ebp
	pop ebp
	ret 0
decoding endp