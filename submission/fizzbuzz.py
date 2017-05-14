#!/usr/bin/env python
# From https://gist.github.com/jaysonrowe/1592775

def fizzbuzz(n):
    if n % 3 == 0 and n % 5 == 0:
        return 'FizzBuzz'
    elif n % 3 == 0:
        return 'Fizz'
    elif n % 5 == 0:
        return 'Buzz'
    else:
        return str(n)

N = int(input())
for n in range(N):
    print(fizzbuzz(n + 1))
