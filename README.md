# Caesar-s-Cipher on Zig
This is my first attempt to implement the Caesar cipher on Zig using raylib.
The Caesar cipher is a simple encryption method in which each letter of the original text is replaced by a letter a fixed number of positions (a shift, or key) further or closer in the alphabet.

![image](https://github.com/tornado4444/Zig_Caesar-s-Cipher/blob/main/algorithm.jpg)

If we associate each character of the alphabet with its serial number (numbering from 0), then encryption and decryption can be expressed by the formulas of modular arithmetic:
```c
y = (x+k) mod n
x = (y - k) mod n
```
where x is the plaintext symbol, is the ciphertext symbol, y is the alphabet power (length), and k is the key.
