# ARuDOIN

**[⬆ to writups](../README.md)**

## Data:

- File: [ARuDOIN.hex](../../Tasks/Reverse/ARuDOIN/ARuDOIN.hex)

## Solution

1.  First of all we need to get assembly code. To do so we can use avr-objdump:
```
avr-objdump -Dx -m avr5 ARuDOIN.hex
```
Or to reverse it inside of r2 we need to convert it from hex to binary format:
```
avr-objcopy –I ihex –O binary ARuDOIN.hex ARuDOIN.bin
```
And resulted binary file can be reversed inside of r2 or Cutter (or in my case both just so that would be convenient): 
```
r2 ARuDOIN.bin
```

2.  First of all, we can look at address 0x0 to see interrupt vector table:
```
pd @0x0
```

To understand what each of them means, you can look in the datasheet of microcontroller that is used. For now we interested in first jump that is occuring on system reset: jmp entry0

3.  As flash memory in AVR can't be modified, usually at the start of the entry function all the static data that will be modified during program run is copied to SRAM, which we can see here:

So what is happenning is:
```
0x00000278      ldi     r26, 0x00
0x0000027a      ldi     r27, 0x01
```
Is setting address where the data will be copied (0x100)
```
0x0000027c      ldi     r30, 0x1a
0x0000027e      ldi     r31, 0x1b
```
Is setting from where data will be copied
```
0x00000286      cpi     r26, 0xe2
```
Comparison for end of the cycle that is telling us that data of length 0xe2 will be copied.

4.  Let's look on that memory:


As you can see, it contains application's strings. And even some flag, but it is not working, so let's continue our search.

5.  

We get the flag: **flag{}**

## Usefull links
https://github.com/thomasbbrunner/arduino-reverse-engineering

https://r2wiki.readthedocs.io/en/latest/analysis/avr/
