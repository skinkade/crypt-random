use v6;
use if;
use strict;
use experimental :pack;

use Crypt::Random::Win:if($*DISTRO.is-win);
use Crypt::Random::Nix:if(!$*DISTRO.is-win);

unit module Crypt::Random;



sub crypt_random_buf ($len) is export {
    _crypt_random_bytes($len);
}

sub crypt_random is export {
    crypt_random_buf(4).unpack("L");
}

sub crypt_random_uniform ($upper_bound) is export {
    my ($r, $min);
    
    if ($upper_bound < 2) {
        return 0;
    }

    $min = -$upper_bound % $upper_bound;

    loop (;;) {
        $r = crypt_random();
        if ($r >= $min) {
            last;
        }
    }

    $r % $upper_bound;
}
