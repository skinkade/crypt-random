# Crypt::Random
Random numbers and bytes emulating ```arc4random```.


## Synopsis
```
# Random 32-bit Int
crypt_random();

# Random 32-bit Int less than $upper_bound
crypt_random_uniform($upper_bound);

# Buf of $len random bytes
crypt_random_buf($len);
```

## Chroot safety & Sources
```Crypt::Random``` **is not chroot-safe**. Chroot safety can be achieved
on Linux 3.17+ by bundling a shim to ```getrandom()```, but there is no
such option on OS X. For the time being, on all Unix-like systems, we use
```/dev/urandom``` reads for our data. ```CryptGenRandom()``` is used on
Windows, via ```getentropy_win.c``` from OpenBSD.

## Copyright & License
Copyright 2015 Shawn Kinkade.

```getentropy_win.c``` copyright 2014 Theo de Raddt & Bob Beck.

This module may be used under the terms of the Artistic License 2.0.
