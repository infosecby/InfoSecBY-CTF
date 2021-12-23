from sage.all import *
import base64
import math
import string

GF_elements = list(GF(64))
alphabet = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\\="
flag = ""

f = open ("cipher_text.txt", "r")
cipher_text = f.read()

for i in GF_elements:
	if i == 0:
		continue
	key = i
	for j in cipher_text:
		tmp = GF_elements[alphabet.index(j)] / key
		flag += alphabet[GF_elements.index(tmp)]
	try:
		flag = (base64.b64decode(flag.encode("ascii"))).decode("ascii")
	except:
		pass
	if "flag{" in flag:
		print (flag)
		break
	flag = ""
