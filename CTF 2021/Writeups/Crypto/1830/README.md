GF_elements = list(GF(64))

This string tells us that script uses Galois field.
Let's move to the key generation.

def generate_key():
	arr = []
	for i in range(randint(10,20)):
		arr.append(GF_elements[randint(1,63)])
	if math.prod(arr) == 0:
		generate_key()
	return math.prod(arr)


The whole point here is that despite all operations in function generate_key, her result is still an element of Galois field.
So, all you need is to check all 64 elements and one of them will be the key.
Besides, you need to reverse this piece of code:

for i in b64encoded_flag:
	GF_initial = GF_elements[alphabet.index(chr(i))]
	GF_final = GF_elements.index(key*GF_initial)
	cipher_text += alphabet[GF_final]

for example in this way

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

You can find exploit in this folder.
Flag:
flag{Tr1but3_t0_Evariste_Galois}
