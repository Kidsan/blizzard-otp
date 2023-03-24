# BATTLE.NET 2FA With Open Source OTP App

A [nix flake](https://nixos.org/manual/nix/stable/command-ref/new-cli/nix3-flake.html) providing the necessary python environment to allow registering 2FA apps on 
battle.net without needing Blizzard's proprietary app.

## How to use

1. Log in to battle.net account overview
2. On the Security screen select, add a mobile authenticator

```bash
$ nix develop
$ bna new # this will output the serial number you must enter into battle.net
$ bna show # this will output the authenticator code you enter into battle.net
```

3. Submit the form on battle.net and it should succeed
4. Add the code to your chosen MFA application

```bash
$ bna show-url | qr # this will generate a QR code you can scan in most OTP apps
```

Not all OTP apps work with the codes battle.net are using. I can only confirm this works with FreeOTP+.
