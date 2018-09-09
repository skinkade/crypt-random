use v6;
use strict;
use NativeCall;

sub arc4random_buf(Buf, size_t) is native {*}

sub _crypt_random_bytes(Int $bytes --> Buf) is export {
    my Buf $buf .= allocate: $bytes;
    arc4random_buf($buf, $bytes);
    $buf
}
