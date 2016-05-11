use v6;
use strict;

unit module Crypt::Random::Nix;



# Persistent file handle because repeated open/close causes
# many repeated calls to be dramatically slower
my IO::Handle $urandom;
INIT { $urandom = open("/dev/urandom", :bin); }
END  { $urandom.close; }



sub _crypt_random_bytes(uint32 $len) returns Buf is export {
    my $bytes = $urandom.read($len);

    if ($bytes.elems != $len) {
        die("Failed to read enough bytes from /dev/urandom");
    }

    $bytes;
}
