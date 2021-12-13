#include <AES.h>
#include <AESLib.h>
#include <AES_config.h>
#include <xbase64.h>

AESLib aesLib;

void setup() {
  Serial.begin(9600);
  Serial.setTimeout(2000);
}

byte iv[N_BLOCK];
byte key[N_BLOCK];

char cleartext[128];

uint16_t decrypt_to_cleartext(byte msg[], uint16_t msgLen) {
  memset(cleartext, 0, sizeof(cleartext));
  uint16_t dec_bytes = aesLib.decrypt(msg, msgLen, cleartext, key, N_BLOCK, iv);
  return dec_bytes;
}


void loop() {
  // we just need to have a long string variable, and why not put a fake flag here for those who search it in the strings
  char result_string[] = "flag{th@ts_vvas_t00_ea$Y_to_f1nd_flah}";
  Serial.println("ENTER DATA");
  String input = Serial.readString();//what we need is "3THISISIVFORENCRTLOOKSLIKEAKEYTOM", 3 - a digit that we will use later, then IV and Key for AES encryption
  Serial.println("DATA "+input);
  if (input.length() == 0)
    return;
  
  int charNum = input.substring(0, 1).toInt(); // took the digit at start of the string and converted to int
  
  bool b = false;
  for (int i = 1; i < input.length(); ++i) // just as a hint that we expect only capital letters after 1 digit, we check input for other chars
  {
     b |= !isUpperCase(input[i]);
  }
  
  if (b)
    return;

  // in this string we have a key and iv for encryption as every 3rd char, we check if what user submited is the same data
  char string_with_secrets[] = "A<TD>H_7IN-SA0ILfSS0IK{VM0FD}OK0RA3ESnNMACD1RA3TSBLM9OD0OLkKA0SS0LMjID0KA9EKfALmKS4EMsYD0TK9OLAM";
  int len = strlen(string_with_secrets);
  for (int i = 1; i < len / charNum; ++i)
  {
    if (string_with_secrets[i*charNum - 1] != input[i])
    {
      return;
    }
  }


  // the real flag data is encrypted here "Y_G0t_m3_th1$_i$_r3@l_Fl@g_here!" -> "96fc0321cd951afa214979233e37c8303cb0e5dddba100bbb5d7321d00e6a1bad42aade1b644364c056bdadcc50aea1e"
  char encrypted_data[] = "lvwDIc2VGvohSXkjPjfIMDyw5d3boQC7tdcyHQDmobo=";



  strncpy(iv, input.c_str() + 1, 16);
  strncpy(key, input.c_str() + 17, 16);
  
  decrypt_to_cleartext(encrypted_data, sizeof(encrypted_data));

  strncpy(result_string + 5, cleartext, 32);

  Serial.println(result_string);
}