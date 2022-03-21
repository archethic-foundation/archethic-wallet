[![Platform](https://img.shields.io/badge/Platform-Flutter-02569B?logo=flutter)](https://flutter.dev) [![CodeFactor](https://www.codefactor.io/repository/github/archethic-foundation/archethic-wallet/badge)](https://www.codefactor.io/repository/github/archethic-foundation/archethic-wallet)

# ARCHEthic Wallet

Similar to a bank account for fiat currency, a crypto wallet is a personal interface for a cryptocurrency network that provides reliable storage and enables transactions. Whether a cryptocurrency is securely stored or not, much depends on the wallet, which is only as secure as its private keys.

Software wallets come in many forms, each with its own set of unique characteristics. Most are somehow connected to the internet and are hot in nature. Wallets are distinguished by a set of supported cryptocurrencies and software platforms such as Windows, Mac and other operating systems. Software wallets are available in three forms — desktop, mobile and online:
- Desktop wallets are computer programs that store cryptocurrencies on a PC so that its information is not accessible to anyone but the user, whose private keys are kept only on the desktop.
- Mobile wallets come in the form of a smartphone app and are easily accessible to their users at any time, considering most people don’t leave their homes without their phones. However, it is worth remembering that mobile devices are vulnerable to various malware and can be easily lost.
- Online wallets are web wallets that can be accessed from anywhere and any device, making them more convenient, but the private keys are stored by website owners rather than locally on user devices.

ARCHEthic Wallet uses the standard bip39 protocol and uses a 24 words mneumonics for deriving private and public keys. If you are familiar with Metamask then ARCHEthic Wallet is similar application for ARCHEthic blockchain.

ARCHEthic Wallet have features that are implemented:
- Use of 24 Words Mnemonics.
- Support for Multiple Languages
- Support for Multiple Currencies (Only views not as in multiple cryptocurrencies)
- Support for transactions (Sending and Receiving UCO Tokens)
- Upcoming Support for NFTs and Many More

![Application Initial Screen](assets/screenshots/AppInit.png?v=20220322)
* Application Initial Screen

## How to install ARCHEthic Wallet

### Android

To install ARCHEthic Wallet in Android Devices:
- Download the APK file for application for your platform from [releases](https://github.com/archethic-foundation/archethic_mobile_wallet/releases).
- Click on the downloaded file and Click on Install
    - If asks for permission to install from unknown sources
        - Goto Settings and Allow Installation from unknown sources for browser or file manager.
- Once installed open the application and proceed as per instructions the application.

### Windows

To install ARCHEthic Wallet in Windows platforms:
- Download the MSIX file from [releases](https://github.com/archethic-foundation/archethic_mobile_wallet/releases).
- Install the certificate 
    1) Right click on the MSIX file, click on Properties and then go to "Digital Signature" tab. Select the certificate from "Signature list" and then click "Details"
    2) Click view certificate
    3) Click "Install certificate" 
    4) Select "Local Machine" and then click "Next"
    5) Select "Place all certificates in the following store" and then click "Browse"
    6) Browse to "Trusted Root Certification Authorities" and then click "OK"
    7) Click "Next"
    8) Click "Finish"
    9) Click "OK"
    The required certificate is imported now and you can begin installing the msix file
- Install the MSIX file

### MacOS

To install ARCHEthic Wallet in MacOS platforms:
- Download the app.zip file from [releases](https://github.com/archethic-foundation/archethic_mobile_wallet/releases).
- Unzip the file
- Launch the APP file

### iOS

To install ARCHEthic Wallet in iOS Devices:
- Soon

### WebApp

- No installation. Just go to https://reddwarf03.github.io/archethic_web/index.html

## How to test the ARCHEthic Wallet

To test ARCHEthic Wallet with Testnet:
- Copy your address from the wallet and paste on the [ARCHEthic Testnet Faucet](https://testnet.archethic.net/faucet) 
- Click on 'Transfer 100 UCO'
- Refresh your dashboard
Now, you can send some UCO and see your transactions

## Setup this Application for developers

### Pre-requisites
- Flutter 2.8+
- Dart 2.15+

### Instructions
- Download the repo into a folder
- Goto the folder and from terminal run `flutter pub get` to get the packages
- Once packages are installed 
    - You can build and run the program for emulator from VSCode Flutter SDK Tools
    - You can build for android emulator if already installed.
- Once the packages and installed and application is built
- Run the program with `flutter run`

By default, the endpoint is https://testnet.archethic.net but you can change it in 'Custom URLs' menu. (You can specify local node with http://localhost:4000 if you want for example.)

### Web app
The wallet (beta version) is available in web mode too with the same source code as the mobile versions.
[Wallet Web App](https://reddwarf03.github.io/archethic_web/)

### Note

*** This Application is currently in active development so it might fail to build. Please refer to issues or create new issues if you find any. Contributions are welcomed.
