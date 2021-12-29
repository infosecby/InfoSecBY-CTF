# SIMplTon

**[⬆ to writups](../../README.md)**

## Solution

1.  We can reverse it by a while, but easier way would be to get strings from the file.
2.  There will be this string: ```em`hzugbst@oDy`nomdPeTHNS``sbihuddsvqf|```
3.  If we look closely on it, we will notice that:
```
e + 1 = f
m – 1 = l
` + 1 = a
h – 1 = g
z + 1 = {
…
```
And so on

4. By continuing applying this pattern to the rest of the string we will get the flag: **flag{thatsAnExampleOfSIMT_architecture}**
