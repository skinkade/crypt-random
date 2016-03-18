use v6;
use strict;

unit module Crypt::Random::Nix;



subset Buflen of Int where 1 .. 256;
sub _crypt_random_bytes(Buflen $len) returns Buf is export {
    my $fh = open("/dev/urandom", :bin);
    my $bytes = $fh.read($len);
    $fh.close;
    $bytes;
}
