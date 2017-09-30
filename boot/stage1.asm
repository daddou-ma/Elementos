org	0x7c00

BITS 16

Start:
	jmp Loader

bpbOEM			db "My OS   "

bpbBytesPerSector:  	DW 512
bpbSectorsPerCluster: 	DB 1
bpbReservedSectors: 	DW 1
bpbNumberOfFATs: 	    DB 2
bpbRootEntries: 	    DW 224
bpbTotalSectors: 	    DW 2880
bpbMedia: 	            DB 0xF0
bpbSectorsPerFAT: 	    DW 9
bpbSectorsPerTrack: 	DW 18
bpbHeadsPerCylinder: 	DW 2
bpbHiddenSectors: 	    DD 0
bpbTotalSectorsBig:     DD 0
bsDriveNumber: 	        DB 0
bsUnused: 	            DB 0
bsExtBootSignature: 	DB 0x29
bsSerialNumber:	        DD 0xa0a1a2a3
bsVolumeLabel: 	        DB "MOS FLOPPY "
bsFileSystem: 	        DB "FAT12   "

msg db "Welcome to Elementos !", 0

PrintChar
	xor bx, bx
	mov ah, 0x0E
	int	0x10
	ret

PrintStr:
	lodsb
	or 	al, al
	jz 	PrintStrDone
	
	call PrintChar

	jmp PrintStr

PrintStrDone:
	ret

Loader:
	xor ax, ax
	mov ds, ax
	mov es, ax

	mov si, msg
	call PrintStr

	cli
	hlt

times 510 - ($-$$) db 0

dw 0xAA55