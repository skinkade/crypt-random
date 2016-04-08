use v6;
use if;
use strict;

use Crypt::Random::Win:if($*DISTRO.is-win);
use Crypt::Random::Nix:if(!$*DISTRO.is-win);

unit module Crypt::Random;



sub crypt_random_buf(UInt64 $len) returns Buf is export {
    _crypt_random_bytes($len);
}

sub crypt_random(UInt64 $size = 4) returns Int is export {
    my Int $count = 0;
    ($count +<= 8) += $_ for crypt_random_buf($size).values;
    $count;
}

sub crypt_random_uniform(Int $upper_bound, UInt64 $size = 4) returns Int is export {
    if ($upper_bound < 2) {
        return 0;
    }

    my ($r, $min);

    $min = -$upper_bound % $upper_bound;

    loop (;;) {
        $r = crypt_random($size);
        if ($r >= $min) {
            last;
        }
    }

    $r % $upper_bound;
}
