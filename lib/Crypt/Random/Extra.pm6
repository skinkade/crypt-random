use v6;
use strict;
use Crypt::Random;

unit module Crypt::Random::Extra;



sub crypt_random_UUIDv4 returns Str is export {
    my $buf = crypt_random_buf(16);
    $buf[6] +|= 0b01000000;
    $buf[6] +&= 0b01001111;
    $buf[8] +|= 0b10000000;
    $buf[8] +&= 0b10111111;

    # skids is a wizard
    (:256[$buf.values].fmt("%32.32x")
        ~~ /(........)(....)(....)(....)(............)/)
        .join("-");
}
