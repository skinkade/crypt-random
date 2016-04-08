use v6;
use strict;
use NativeCall;

unit module Crypt::Random::Win;



# RtlGenRandom
sub SystemFunction036(Buf, uint64)
    returns Bool
    is native('Advapi32', v0)
    { * }



sub _crypt_random_bytes(uint64 $len) returns Buf is export {
    my $bytes = Buf.allocate($len);

    if (!SystemFunction036($bytes, $len)) {
        die("RtlGenRandom() failed");
    }

    $bytes;
}
