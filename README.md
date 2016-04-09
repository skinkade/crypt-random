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

### Arbitrary Precision
`crypt_random()` and `crypt_random_uniform()` operate with arbitrary precision,
defaulting to 32 bits. For example, we can use 128-bit Ints:
```
> crypt_random();
2995622573
> crypt_random((128/8).Int);
329575757216165039775477155555355515616
> crypt_random_uniform(329575757216165039775477155555355515616);
3948459150
> crypt_random_uniform(329575757216165039775477155555355515616, (128/8).Int);
41874606600151197604385879164147854165
```

## Extra
Additional useful functions built upon the above primitives.
```
use Crypt::Random::Extra;

my Str $uuid = crypt_random_UUIDv4();

my Int $prime = crypt_random_prime();
my Int $prime2048 = crypt_random_prime((2048/8).Int);
```

## Entropy Sources
Random bytes are drawn from `/dev/urandom` on Unix-like systems, and `RtlGenRandom()`
on Windows.

## Copyright & License
Copyright 2016 Shawn Kinkade.

This module may be used under the terms of the Artistic License 2.0.
