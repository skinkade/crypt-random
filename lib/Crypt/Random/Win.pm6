use v6;
use strict;
use NativeCall;

unit module Crypt::Random::Win;



subset HCRYPTPROV of Pointer[ulong];
constant uint32 PROV_RSA_FULL = 0x00000001;
constant uint32 CRYPT_VERIFYCONTEXT = 0xF0000000;



sub CryptGenRandom(HCRYPTPROV $hProv, uint32 $dwLen, Buf $pbBuffer)
    returns Bool
    is native('Advapi32', v0)
    { * }

sub CryptAcquireContext(Pointer[HCRYPTPROV] $phProv, Str $pszContainer,
                        Str $pszProvider, uint32 $dwProvType, uint32 $dwFlags)
    returns Bool
    is native('Advapi32', v0)
    { * }

sub CryptReleaseContext(HCRYPTPROV $hProv, uint32 $dwFlags)
    returns Bool
    is native('Advapi32', v0)
    { * }



sub _crypt_random_bytes($len) returns Buf is export {
    my HCRYPTPROV $hProv;
    my $ctx_ret = CryptAcquireContext(&hProv, Code, Code, PROV_RSA_FULL, CRYPT_VERIFYCONTEXT);
    die "CryptAcquireContext() failure" if !$ctx_ret;

    my $bytes = Buf.new;
    $bytes[$len - 1] = 0;

    my $rand_ret = CryptGenRandom($hProv, $len, $bytes);
    die "CryptGenRandom() failure" if !$rand_ret;

    my $rel_ret = CryptReleaseContext($hProv, 0);
    die "CryptReleaseContext() failure" if !$rel_ret;

    $bytes;
}

