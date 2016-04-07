# Crypt::Random
Random numbers and bytes emulating `arc4random()`.


## Synopsis
```
use Crypt::Random;

# Random 32-bit Int
my Int $foo = crypt_random();

# Random 32-bit Int between 0 and $upper_bound (exclusive)
my Int $bar = crypt_random_uniform($upper_bound);

# Buf of $len random bytes
my Buf $baz = crypt_random_buf($len);
```

## Extra
Additional useful functions built upon the above primitives. Currently contains
a random UUID function.
```
use Crypt::Random::Extra;

my Str $uuid = crypt_random_UUIDv4();
```

## Entropy Sources
Random bytes are drawn from `/dev/urandom` on Unix-like systems, and `RtlGenRandom()`
on Windows.

## Copyright & License
Copyright 2016 Shawn Kinkade.

This module may be used under the terms of the Artistic License 2.0.
