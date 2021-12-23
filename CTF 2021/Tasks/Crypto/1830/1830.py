from sage.all import *
import base64
import math
import string

GF_elements = list(GF(64))
alphabet = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\\="

def generate_key():
	arr = []
	for i in range(randint(10,20)):
		arr.append(GF_elements[randint(1,63)])
	if math.prod(arr) == 0:
		generate_key()
	return math.prod(arr)


f = open ("flag.txt", "r")
flag = f.read()
b64encoded_flag = base64.b64encode(flag.encode("ascii"))

key = generate_key()
cipher_text = ""

for i in b64encoded_flag:
	GF_initial = GF_elements[alphabet.index(chr(i))]
	GF_final = GF_elements.index(key*GF_initial)
	cipher_text += alphabet[GF_final]

print (cipher_text)