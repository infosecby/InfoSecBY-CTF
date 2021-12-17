# T2_part1 - 80 points

**[⬆ to writups](../../README.md)**

## Description

What company does one of your friends work for? Submit Company's name as a flag: flag{company_name} For example, if company name would be "Super Duper Mega" than flag would be: flag{Super_Duper_Mega} ("The" is not expected to be in flag)


And we have the chat dump: **[log.json](./log.json)**

## Solution

1.  Read the chat and find the phrases: "\
{\
   "id": 96018,\
   "type": "message",\
   "date": "2021-10-31T15:37:34",\
   "from": "Nick",\
      "reply_to_message_id": 96016,\
   "text": "**How's your company**? Do u have any problems?"\
  },\
  {\
   "id": 96018,\
   "type": "message",\
   "date": "2021-10-31T15:30:52",\
   "from": "Rudik",\
   "text": "Oh, no. The **Mad dogs** runs well. But we have some issues to hire new employees"\
  }\
  "
2. Flag: **flag{Mad_Dogs}**
