[![Platform](https://img.shields.io/badge/Platform-Flutter-02569B?logo=flutter)](https://flutter.dev) [![CodeFactor](https://www.codefactor.io/repository/github/archethic-foundation/archethic-wallet/badge)](https://www.codefactor.io/repository/github/archethic-foundation/archethic-wallet)
[![Github All Releases](https://img.shields.io/github/downloads/archethic-foundation/archethic-wallet/total.svg)](https://github.com/archethic-foundation/archethic-wallet/releases)
[![Github Downloads (monthly)](https://img.shields.io/github/downloads/archethic-foundation/archethic-wallet/latest/total.svg)](https://github.com/archethic-foundation/archethic-wallet/releases)

# Archethic Wallet

The app is mainly a FULLY decentralized and cryptocurrency non-custodial hot wallet that enables you to safely manage assets on Layer 1 Archethic blockchain.</br>
This wallet includes the features of send and receive coins instantly to and from anyone.</br>
No signup or KYC needed, you just control your service access keychain, protected by different security ways like PIN Code, Password, Yubikey devices and Biometrics</br>
NB: Yubikey is a device that makes 2-factor authentication as simple as possible (see [yubico.com](https://www.yubico.com))</br>

Archethic Wallet has implemented the following features:

### Main features
- Decentralized keychain management
- Multiple accounts' management
- Creation of Fungible Tokens
- Creation of NFTs
- Support for transactions (Sending and Receiving UCO Token, Fungible Tokens and NFTs)
- List of recent transactions
- List of acquired tokens

### Security
- Security access with Password, PIN, Yubicloud OTP, Face ID, Touch ID, Uniris Biometrics (2023)
- Use of 24 Words Mnemonics

### Customization
- Support for English and French Language
- Support for multiple Currencies (view only, not meant as multiple cryptocurrencies wallet)
- Multi themes (9 themes available)
- UI customization

### Other features
- Local notifications
- Access to exchanges to buy ERC20 UCO
- Share address with QR Code or mobile share feature
- Address book
- UCO Price chart
- Access latest Archethic blog articles

## Application Initial Screen
<img src="fastlane/metadata/android/en-US/images/phoneScreenshots/1.png?v=20221202" width="300"/>

## Information
All news about wallet are available on the [Archethic Youtube Channel](https://www.youtube.com/playlist?list=PL6GQEJjcIwHChTok4CJyw3lsmlvoJLnZK)

## How to install Archethic Wallet

### Android
- [Available on Google Play Store](https://play.google.com/store/apps/details?id=net.archethic.archethic_wallet)

### Windows
- [Available on Microsoft Store](https://apps.microsoft.com/store/detail/archethic-wallet/9N33TTVRJZXF)

### MacOS
- [Available on MacOS Store](https://apps.apple.com/app/archethic-wallet/id6443334906)

### iOS
- [Available on Apple Store](https://apps.apple.com/app/apple-store/id6443334906)

### FDroid
- In progress

### WebApp
- Soon

### Chrome Extension
- Soon

## How to test the Archethic Wallet

To test Archethic Wallet with Faucet:

- Copy your address from the wallet and paste on the [Archethic Testnet Faucet](https://testnet.archethic.net/faucet) 
- Click on 'Transfer 100 UCO'
- Refresh your dashboard</br>
Now, you can send some UCO and see your transactions

### Patrol installation and configuration

Patrol is a flutter package, you can install it using a simple `flutter pub get`

Full patrol using on this project can be found [here](integration_test/README.md)

## Setup this Application for developers

### Pre-requisites

- Flutter 3.7+
- Dart 2.19+

### Instructions

- Download the repo into a folder
- Goto the folder and from terminal run `flutter pub get` to get the packages
- Once packages are installed :
    - You can build and run the program for emulator from VSCode Flutter SDK Tools.
    - You can build for android emulator if already installed.
- Once the packages and installed and application is built
- Run the program with `flutter run`

By default, the endpoint is https://testnet.archethic.net but you can change it in 'Networks' menu.

### Note

*** This Application is currently in active development so it might fail to build. Please refer to issues or create new issues if you find any. Contributions are welcomed.
