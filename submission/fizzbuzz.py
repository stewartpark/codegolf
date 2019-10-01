#!/usr/bin/env python
# By RaidAndFade
for n in range(1,int(input())+1):print("".join(["","Fizz"][n%3==0]+["","Buzz"][n%5==0]) or n)
