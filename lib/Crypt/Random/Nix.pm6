use v6;
use nqp;
use strict;
use NativeCall;

unit module Crypt::Random::Nix;

sub syscall ( long, Buf, size_t, uint32 --> ssize_t ) is native {*}
enum CVar (
    SYS_getrandom => 318,
    GRND_NONBLOCK => 0b01,
);

sub _crypt_random_bytes(uint32 $len) returns Buf is export {
    return _crypt_random_bytes_urandom($len)
        if Version.new($*KERNEL.release) < v3.17;

    my $errno     := cglobal ('c', v6), 'errno', int32;
    my $getrandom := syscall SYS_getrandom,
        (my Buf $bytes.=allocate: $len), $len, GRND_NONBLOCK;

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
