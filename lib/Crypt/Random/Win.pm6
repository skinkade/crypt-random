use v6;
use strict;
use NativeCall;

unit module Crypt::Random::Win;



# RtlGenRandom
sub SystemFunction036(CArray[uint8], uint64)
    returns Bool
    is native('Advapi32', v1)
    { * }



sub carray-to-buf-with-zero(CArray $carray) {
    my $buf = Buf.new;
    for ^$carray.elems {
        $buf[$_] = $carray[$_];
        $carray[$_] = 0;
    }
    $buf;
}



sub _crypt_random_bytes(Int $len) returns Buf is export {
    my $bytes = CArray[uint8].new;
    $bytes[$len - 1] = 0;
    if (!SystemFunction036($bytes, $len)) {
        die("RtlGenRandom() failed");
    }
    carray-to-buf-with-zero($bytes);
}
