SYS_WRITE = 4
SYS_READ = 3
SYS_EXIT = 1
STDOUT = 1
STDIN = 0
SYSCALL = 0x80
SIZE = 16

.data
    data1: .skip SIZE
    data2: .skip SIZE
    result: .skip  SIZE
    
.text
    .global _start
    _start:
        clc 
        mov $0x00, %esi
        mov $STDIN, %ebx
        mov $1, %edx
    _readData1: 
        mov $SYS_READ, %eax
        lea data1(%esi), %ecx
        int $SYSCALL
        cmp $0, %eax 
        jbe end
        inc %esi 
        cmp $SIZE, %esi
        jne _readData1 

        mov $0, %esi
    _readData2:
        mov $SYS_READ, %eax
        lea data2(%esi), %ecx
        int $SYSCALL
        cmp $0, %eax 
        jbe end
        inc %esi 
        cmp $SIZE, %esi
        jne _readData2
        
        mov $SIZE-1,%esi 
        clc
        pushf
    adding:
        clc
        popf 
        movb data1(%esi), %al
        movb data2(%esi), %ah
        adc %ah, %al
        pushf 
        movb %al, result(%esi)
        dec %esi
        cmp $-1, %esi
        jne adding 
        mov $0, %esi
        popf
        clc
        mov $0, %esi
    print:
        mov $SYS_WRITE, %eax
        mov $STDOUT, %ebx 
        lea result(%esi), %ecx
        mov $1, %edx
        int $SYSCALL
        inc %esi
        cmp $SIZE, %esi 
        jne print
        
        mov $0, %esi
    clear:
        mov $0, %eax
        mov %eax, data1(%esi)
        mov %eax, data2(%esi)
        mov %eax, result(%esi) 
        add $4, %esi 
        cmp $SIZE, %esi 
        jne clear
        jmp _start

    end:
        mov $SYS_EXIT, %eax
        int $SYSCALL 


        
        
 
