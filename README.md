[![Platform](https://img.shields.io/badge/Platform-Flutter-02569B?logo=flutter)](https://flutter.dev) [![CodeFactor](https://www.codefactor.io/repository/github/archethic-foundation/archethic-wallet/badge)](https://www.codefactor.io/repository/github/archethic-foundation/archethic-wallet)

# Archethic Wallet

The app is mainly a FULLY decentralized and cryptocurrency non-custodial hot wallet that enables you to safety manage assets on Layer 1 Archethic blockchain.
This wallet includes the features of send and receive coins instantly to and from anyone.
No signup or KYC needed, you just control your service access keychain, protected by different security ways like PIN Code, Password, Yubikey devices (*) and Biometrics
(*) Yubikey is a device that makes 2-factor authentification as simple as possible (see [yubico.com](https://www.yubico.com))

Archethic Wallet have features that are implemented:
- Use of 24 Words Mnemonics.
- Decentralized keychain management
- Multi accounts management
- Support for transactions (Sending and Receiving UCO Token)
- Security access with Password, PIN, Yubikey, Face ID, Touch ID, Uniris Biometrics (soon)
- Support for english and french Languages
- Support for Multiple Currencies (Only views not as in multiple cryptocurrencies)
- Multi themes
- Address book
- UCO Price chart
- Last Archethic's articles

![Application Initial Screen](assets/screenshots/AppInit.png?v=20220711)
* Application Initial Screen

## Informations
All news about wallet are available on the [Archethic Youtube Channel](https://www.youtube.com/playlist?list=PL6GQEJjcIwHChTok4CJyw3lsmlvoJLnZK)

## How to install Archethic Wallet

### Android

To install Archethic Wallet in Android Devices:
- Download the APK file for application for your platform from [releases](https://github.com/archethic-foundation/archethic_mobile_wallet/releases).
- Click on the downloaded file and Click on Install
    - If asks for permission to install from unknown sources
        - Goto Settings and Allow Installation from unknown sources for browser or file manager.
- Once installed open the application and proceed as per instructions the application.

### Windows

To install Archethic Wallet in Windows platforms:
- Soon

### MacOS

To install Archethic Wallet in MacOS platforms:
- Soon

### iOS

To install Archethic Wallet in iOS Devices:
- Soon

### WebApp

- Soon

### Chrome Extension

- Soon


## How to test the Archethic Wallet

To test Archethic Wallet with Testnet:
- Copy your address from the wallet and paste on the [Archethic Testnet Faucet](https://testnet.archethic.net/faucet) 
- Click on 'Transfer 100 UCO'
- Refresh your dashboard
Now, you can send some UCO and see your transactions

## Setup this Application for developers

### Pre-requisites
- Flutter 3.0+
- Dart 2.17+

### Instructions
- Download the repo into a folder
- Goto the folder and from terminal run `flutter pub get` to get the packages
- Once packages are installed 
    - You can build and run the program for emulator from VSCode Flutter SDK Tools
    - You can build for android emulator if already installed.
- Once the packages and installed and application is built
- Run the program with `flutter run`

By default, the endpoint is https://testnet.archethic.net but you can change it in 'Networks' menu.

### Note

*** This Application is currently in active development so it might fail to build. Please refer to issues or create new issues if you find any. Contributions are welcomed.
