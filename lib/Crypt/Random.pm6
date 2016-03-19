use v6;
use if;
use strict;
use Subsets::Common;
use experimental :pack;

use Crypt::Random::Win:if($*DISTRO.is-win);
use Crypt::Random::Nix:if(!$*DISTRO.is-win);

unit module Crypt::Random;



subset Buflen of Int where 1 .. 256;
sub crypt_random_buf(Buflen $len) returns Buf is export {
    _crypt_random_bytes($len);
}

sub crypt_random returns Int is export {
    crypt_random_buf(4).unpack("L");
}

sub crypt_random_uniform(UInt32 $upper_bound) returns Int is export {
    if ($upper_bound < 2) {
        return 0;
    }

    my ($r, $min);

    $min = -$upper_bound % $upper_bound;

    loop (;;) {
        $r = crypt_random();
        if ($r >= $min) {
            last;
        }
    }

    $r % $upper_bound;
}
