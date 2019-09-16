use v6;
use nqp;
use strict;
use NativeCall;

unit module Crypt::Random::Nix;

sub getrandom ( Buf, size_t, uint32 --> ssize_t ) is native {*}
enum CVar (
    GRND_NONBLOCK => 0b01,
);

sub _crypt_random_bytes(uint32 $len) returns Buf is export {
    my $errno     := try cglobal ('c', v6), 'errno', int32;
    my $getrandom := try getrandom (my Buf $bytes.=allocate: $len),
        $len, GRND_NONBLOCK unless $!;

    return _crypt_random_bytes_urandom($len) if $!;

    die "getrandom() error: errno $errno" if $getrandom == -1;
    die 'Failed to read enough bytes from getrandom()' if $getrandom != $len;

    $bytes;
}

sub _crypt_random_bytes_urandom(uint32 $len) returns Buf {
    my $urandom := nqp::open('/dev/urandom', 'r');
    my $bytes   := Buf.new;

    nqp::readfh($urandom, $bytes, $len);
    nqp::closefh($urandom);

    die "Failed to read enough bytes from /dev/urandom" if $bytes.elems != $len;

    $bytes;
}
