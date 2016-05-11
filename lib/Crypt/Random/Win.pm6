use v6;
use strict;
use NativeCall;

unit module Crypt::Random::Win;



class CSP is repr('CPointer') { };
constant PROV_RSA_FULL = 0x00000001;
constant CRYPT_VERIFYCONTEXT = 0xF0000000;



sub CryptGenRandom(CSP $hProv, uint32 $dwLen, Buf $pbBuffer)
    returns Bool
    is native('Advapi32', v0)
    { * }

sub CryptAcquireContextA(CSP $phProv is rw, Str $pszContainer,
                        Str $pszProvider, uint32 $dwProvType, uint32 $dwFlags)
    returns Bool
    is native('Advapi32', v0)
    { * }

sub CryptReleaseContext(CSP $hProv, uint32 $dwFlags)
    returns Bool
    is native('Advapi32', v0)
    { * }

sub GetLastError()
    returns uint32
    is native('Kernel32', v0)
    { * }



sub _crypt_random_bytes($len) returns Buf is export {
    my CSP $hProv .= new;
    my $ctx_ret = CryptAcquireContextA($hProv, Code, Code, PROV_RSA_FULL, CRYPT_VERIFYCONTEXT);
    if !$ctx_ret {
        my $lasterr = GetLastError();
        die "CryptAcquireContext() failure: $lasterr";
    }

    my $bytes = Buf.new;
    $bytes[$len - 1] = 0;

    my $rand_ret = CryptGenRandom($hProv, $len, $bytes);
    die "CryptGenRandom() failure" if !$rand_ret;

    my $rel_ret = CryptReleaseContext($hProv, 0);
    die "CryptReleaseContext() failure" if !$rel_ret;

    $bytes;
}

