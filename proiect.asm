.386
.model flat, stdcall
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;includem biblioteci, si declaram ce functii vrem sa importam
includelib msvcrt.lib
extern fscanf: proc
extern fprintf: proc
extern printf: proc
extern fopen: proc
extern fclose: proc
extern fgets: proc
extern fseek: proc
extern strlen: proc
extern strcmp: proc
extern exit: proc
include mylib.asm
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;declaram simbolul start ca public - de acolo incepe executia
public start
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;sectiunile programului, date, respectiv cod
.data
;aici declaram date

filecodificare db "codificare.txt", 0
fileread db "in.txt", 0
filewrite db "out_codificare.txt", 0
mode_read db "r", 0
mode_write db "a", 0
caracter db "000000", 0
caracter1 db "000000", 0
caracter3 db "000000", 0
caracter4 db "000000", 0
cod1 db "000000", 0
cod2 db "000000", 0
format db "%c %s", 0
format1 db "%s %s",10, 0
format_caracter db "%c", 0
format_string db "%s", 0
format_scriere db "%s ", 0
pointer_fisier1 dd 0
pointer_fisier2 dd 0
pointer_fisier3 dd 0
pointer_fisier4 dd 0
SEEK_CUR equ 1
SEEK_SET equ 0
SEEK_END equ -1
biti dd 5
numar dd 0
format2 db "%2s", 0
format3 db "%3s", 0
format4 db "%4s", 0
format5 db "%5s", 0
format6 db "%6s", 0
nr dd 0
nr1 dd 0
nr3 dd 0
nr4 dd 0
format_intreg db "%d",0 
cod_intreg dd 26
;--------------for decoding---------------
string db "000000", 0
string1 db "000000", 0
char db "000000", 0
fileout db "out_decodificare.txt", 0
ptr_fisier dd 0
ptr_fisier1 dd 0
ptr_fisier2 dd 0
.code
start:
	;aici se scrie codul
	
	call encoding
	call decoding

	;terminarea programului
	push 0
	call exit
end start
