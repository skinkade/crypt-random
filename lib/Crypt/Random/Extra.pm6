use v6;
use strict;
use Crypt::Random;
use experimental :pack;

unit module Crypt::Random::Extra;



sub crypt_random_UUID4 returns Str is export {
    my $buf = crypt_random_buf(16);
    $buf[6] +|= 0b01000000;
    $buf[6] +&= 0b01001111;
    $buf[8] +|= 0b10000000;
    $buf[8] +&= 0b10111111;

    my $uuid = $buf.unpack("H16");
    $uuid.substr-rw(8, 0) = '-';
    $uuid.substr-rw(13, 0) = '-';
    $uuid.substr-rw(18, 0) = '-';
    $uuid.substr-rw(23, 0) = '-';

    $uuid;
}
