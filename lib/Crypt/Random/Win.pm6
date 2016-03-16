use v6;
use strict;
use NativeCall;

unit module Crypt::Random::Win;



sub getentropy(CArray[uint8], size_t)
    is native('./getentropy32.dll')
    { * }



# Credit: Jonathan Stowe via NativeHelpers::Array
# Copied to avoid dependencies
sub copy-carray-to-buf(CArray $array, Int $no-elems) returns Buf {
    my $buf = Buf.new;
    $buf[$_] = $array[$_] for ^$no-elems;
    $buf;
}



sub _crypt_random_bytes ($len) is export {
    my $bytes = CArray[uint8].new;
    $bytes[$len - 1] = 0;
    getentropy($bytes, $len);
    copy-carray-to-buf($bytes, $len);
}
