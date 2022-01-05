
<h1>Catch the hand</h1>

![This is an image](https://github.com/infosecby/InfoSecBY-CTF/blob/main/CTF%202021/Tasks/Crypto/Catch%20the%20hand/Catchthehand.png)

1) Understand that we have wifi handshake
2) Use hashcat and letter to simulate possible Wi-Fi password
3) Use online toole or local kali toole for converting .cap file to .hccapx or to .hc22000 extension
4) Build mask for brute force (correct mask Alice19?d?d)
5) Сrack the hash: hashcat -a 3 -m 22000 445.hc22000 Alice19?d?d



