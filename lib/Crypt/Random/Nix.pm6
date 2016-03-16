use v6;
use strict;

unit module Crypt::Random::Nix;



sub _crypt_random_bytes ($len) is export {
    my $fh = open("/dev/urandom", :bin);
    my $bytes = $fh.read($len);
    $fh.close;
    $bytes;
}
