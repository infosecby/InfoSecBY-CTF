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
And resulted binary file can be reversed inside of r2: 
```
r2 ARuDOIN.bin
```

2.  

We get the flag: **flag{}**

## Usefull links
https://github.com/thomasbbrunner/arduino-reverse-engineering

https://r2wiki.readthedocs.io/en/latest/analysis/avr/
