// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a messages locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, always_declare_return_types

// Package imports:
import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = MessageLookup();

typedef String MessageIfAbsent(String? messageStr, List<Object>? args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'messages';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "aboutGeneralTermsAndConditions":
            MessageLookupByLibrary.simpleMessage("General Terms & Conditions"),
        "aboutHeader": MessageLookupByLibrary.simpleMessage("About"),
        "aboutPrivacyPolicy":
            MessageLookupByLibrary.simpleMessage("Privacy Policy"),
        "aboutWalletServiceTerms":
            MessageLookupByLibrary.simpleMessage("Wallet Service Terms"),
        "account": MessageLookupByLibrary.simpleMessage("Account"),
        "accounts": MessageLookupByLibrary.simpleMessage("Accounts"),
        "ackBackedUp": MessageLookupByLibrary.simpleMessage(
            "Are you sure that you\'ve backed up your secret phrase ?"),
        "add": MessageLookupByLibrary.simpleMessage("Add"),
        "addAccount": MessageLookupByLibrary.simpleMessage("Add Account"),
        "addContact": MessageLookupByLibrary.simpleMessage("Add Contact"),
        "addNFT": MessageLookupByLibrary.simpleMessage("Add NFT"),
        "addNFTConfirmationMessage": MessageLookupByLibrary.simpleMessage(
            "Do you confirm the creation of the following NFT ?"),
        "addNFTHeader": MessageLookupByLibrary.simpleMessage("Add NFT"),
        "addressBookDesc": MessageLookupByLibrary.simpleMessage(
            "Create and manage frequently-used addresses"),
        "addressBookHeader":
            MessageLookupByLibrary.simpleMessage("Address book"),
        "addressCopied": MessageLookupByLibrary.simpleMessage("Address Copied"),
        "addressHint": MessageLookupByLibrary.simpleMessage("Enter Address"),
        "addressInfos":
            MessageLookupByLibrary.simpleMessage("Address informations"),
        "addressMissing":
            MessageLookupByLibrary.simpleMessage("Please Enter an Address"),
        "amountMissing":
            MessageLookupByLibrary.simpleMessage("Please Enter an Amount"),
        "authMethod": MessageLookupByLibrary.simpleMessage("Auth. Method"),
        "autoLockHeader": MessageLookupByLibrary.simpleMessage("Auto Lock"),
        "backupSecretPhrase":
            MessageLookupByLibrary.simpleMessage("Backup Secret Phrase"),
        "backupSeed": MessageLookupByLibrary.simpleMessage("Backup Seed"),
        "biometricsMethod": MessageLookupByLibrary.simpleMessage("Biometrics"),
        "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
        "changeCurrencyDesc": MessageLookupByLibrary.simpleMessage(
            "Select the fiat currency you would like to display alongside UCO"),
        "changeCurrencyHeader":
            MessageLookupByLibrary.simpleMessage("Currency"),
        "close": MessageLookupByLibrary.simpleMessage("Close"),
        "confirm": MessageLookupByLibrary.simpleMessage("Confirm"),
        "confirmBiometrics":
            MessageLookupByLibrary.simpleMessage("Authenticate to Confirm"),
        "connectWallet":
            MessageLookupByLibrary.simpleMessage("Connect to my wallet"),
        "contactAdded":
            MessageLookupByLibrary.simpleMessage("%1 added to address book."),
        "contactExists":
            MessageLookupByLibrary.simpleMessage("Contact Already Exists"),
        "contactHeader": MessageLookupByLibrary.simpleMessage("Contact"),
        "contactInvalid":
            MessageLookupByLibrary.simpleMessage("Invalid Contact Name"),
        "contactNameHint":
            MessageLookupByLibrary.simpleMessage("Enter a Name @"),
        "contactNameMissing": MessageLookupByLibrary.simpleMessage(
            "Choose a Name for this contact"),
        "contactRemoved": MessageLookupByLibrary.simpleMessage(
            "%1 has been removed from address book!"),
        "copied": MessageLookupByLibrary.simpleMessage("Copied"),
        "copy": MessageLookupByLibrary.simpleMessage("Copy"),
        "copyAddress": MessageLookupByLibrary.simpleMessage("Copy Address"),
        "currency": MessageLookupByLibrary.simpleMessage("Currency"),
        "customUrlDesc":
            MessageLookupByLibrary.simpleMessage("Define the endpoint"),
        "customUrlHeader": MessageLookupByLibrary.simpleMessage("Custom Urls"),
        "defaultAccountName":
            MessageLookupByLibrary.simpleMessage("Main Account"),
        "defaultNewAccountName":
            MessageLookupByLibrary.simpleMessage("Account %1"),
        "deleteOption": MessageLookupByLibrary.simpleMessage("Delete"),
        "enterAddress": MessageLookupByLibrary.simpleMessage("Enter Address"),
        "enterAmount": MessageLookupByLibrary.simpleMessage("Enter Amount"),
        "enterEndpoint":
            MessageLookupByLibrary.simpleMessage("Enter an endpoint"),
        "enterTxAddressHint":
            MessageLookupByLibrary.simpleMessage("Enter a transaction address"),
        "enterTxChainSeedHint": MessageLookupByLibrary.simpleMessage(
            "Enter a transaction chain seed"),
        "enterTxChainSeedText": MessageLookupByLibrary.simpleMessage(
            "Please, enter a transaction chain seed"),
        "exit": MessageLookupByLibrary.simpleMessage("Exit"),
        "fees": MessageLookupByLibrary.simpleMessage("Fees"),
        "fingerprintSeedBackup": MessageLookupByLibrary.simpleMessage(
            "Authenticate to backup seed."),
        "getOption": MessageLookupByLibrary.simpleMessage("Get"),
        "goBackButton": MessageLookupByLibrary.simpleMessage("Go Back"),
        "hideAccountHeader":
            MessageLookupByLibrary.simpleMessage("Hide Account?"),
        "iUnderstandTheRisks":
            MessageLookupByLibrary.simpleMessage("I Understand the Risks"),
        "informations": MessageLookupByLibrary.simpleMessage("Informations"),
        "instantly": MessageLookupByLibrary.simpleMessage("Instantly"),
        "insufficientBalance":
            MessageLookupByLibrary.simpleMessage("Insufficient Balance"),
        "invalidAddress":
            MessageLookupByLibrary.simpleMessage("Address entered was invalid"),
        "language": MessageLookupByLibrary.simpleMessage("Language"),
        "lockAppSetting":
            MessageLookupByLibrary.simpleMessage("Auth. on Launch"),
        "locked": MessageLookupByLibrary.simpleMessage("Locked"),
        "logout": MessageLookupByLibrary.simpleMessage("Logout"),
        "logoutAction":
            MessageLookupByLibrary.simpleMessage("Delete Infos and Logout"),
        "logoutAreYouSure":
            MessageLookupByLibrary.simpleMessage("Are you sure?"),
        "logoutDetail": MessageLookupByLibrary.simpleMessage(
            "Logging out will remove all ArchEthic Wallet-related data from this device. If your secret phrase is not backed up, you will never be able to access your wallet again"),
        "logoutReassurance": MessageLookupByLibrary.simpleMessage(
            "As long as you\'ve backed up your seed you have nothing to worry about."),
        "manage": MessageLookupByLibrary.simpleMessage("Manage"),
        "minimumSend": MessageLookupByLibrary.simpleMessage(
            "Minimum send amount is %1 UCO"),
        "nextButton": MessageLookupByLibrary.simpleMessage("Next"),
        "nftHeader": MessageLookupByLibrary.simpleMessage("NFT"),
        "nftHeaderDesc": MessageLookupByLibrary.simpleMessage(
            "Manage your Non Financial Tokens"),
        "nftInitialSupply":
            MessageLookupByLibrary.simpleMessage("Initial supply: "),
        "nftInitialSupplyHint":
            MessageLookupByLibrary.simpleMessage("Enter an initial supply"),
        "nftInitialSupplyMissing": MessageLookupByLibrary.simpleMessage(
            "Choose an initial supply for the NFT"),
        "nftInitialSupplyPositive": MessageLookupByLibrary.simpleMessage(
            "The initial supply should be > 0"),
        "nftName": MessageLookupByLibrary.simpleMessage("Name: "),
        "nftNameHint": MessageLookupByLibrary.simpleMessage("Enter a name"),
        "nftNameMissing":
            MessageLookupByLibrary.simpleMessage("Choose a Name for the NFT"),
        "no": MessageLookupByLibrary.simpleMessage("No"),
        "noSkipButton": MessageLookupByLibrary.simpleMessage("No, Skip"),
        "nodesHeader": MessageLookupByLibrary.simpleMessage("Nodes"),
        "nodesHeaderDesc":
            MessageLookupByLibrary.simpleMessage("Nodes informations"),
        "ok": MessageLookupByLibrary.simpleMessage("Ok"),
        "pinConfirmError":
            MessageLookupByLibrary.simpleMessage("Pins do not match"),
        "pinConfirmTitle":
            MessageLookupByLibrary.simpleMessage("Confirm your pin"),
        "pinCreateTitle":
            MessageLookupByLibrary.simpleMessage("Create a 6-digit pin"),
        "pinEnterTitle": MessageLookupByLibrary.simpleMessage("Enter pin"),
        "pinInvalid":
            MessageLookupByLibrary.simpleMessage("Invalid pin entered"),
        "pinMethod": MessageLookupByLibrary.simpleMessage("PIN"),
        "pinPadShuffle":
            MessageLookupByLibrary.simpleMessage("PIN Pad Shuffle"),
        "pinSecretPhraseBackup": MessageLookupByLibrary.simpleMessage(
            "Enter PIN to Backup Secret Phrase"),
        "preferences": MessageLookupByLibrary.simpleMessage("Preferences"),
        "qrInvalidAddress": MessageLookupByLibrary.simpleMessage(
            "QR code does not contain a valid destination"),
        "qrInvalidPermissions": MessageLookupByLibrary.simpleMessage(
            "Please Grant Camera Permissions to scan QR Codes"),
        "qrUnknownError":
            MessageLookupByLibrary.simpleMessage("Could not Read QR Code"),
        "received": MessageLookupByLibrary.simpleMessage("Received"),
        "recentTransactionsHeader":
            MessageLookupByLibrary.simpleMessage("Recent transactions"),
        "recentTransactionsNoTransactionYet":
            MessageLookupByLibrary.simpleMessage("No transaction yet"),
        "releaseNoteHeader":
            MessageLookupByLibrary.simpleMessage("What\'s new"),
        "removeAccountText": MessageLookupByLibrary.simpleMessage(
            "Are you sure you want to hide this account? You can re-add it later by tapping the \'%1\' button."),
        "removeContact": MessageLookupByLibrary.simpleMessage("Remove Contact"),
        "removeContactConfirmation": MessageLookupByLibrary.simpleMessage(
            "Are you sure you want to delete %1?"),
        "rootWarning": MessageLookupByLibrary.simpleMessage(
            "It appears your device is \"rooted\", \"jailbroken\", or modified in a way that compromises security. It is recommended that you reset your device to its original state before proceeding."),
        "scanQrCode": MessageLookupByLibrary.simpleMessage("Scan QR Code"),
        "secretInfo": MessageLookupByLibrary.simpleMessage(
            "In the next screen, you will see your recovery phrase. A recovery phrase is essentially a human readable form of your crypto\'s wallet private key, and is displayed as 24 mnemonic words. After mastering the mnemonic words, you can restore your wallet at will. Please keep the words properly and don\'t leak them to anyone."),
        "secretInfoHeader":
            MessageLookupByLibrary.simpleMessage("Safety First!"),
        "secretWarning": MessageLookupByLibrary.simpleMessage(
            "If you lose your device or uninstall the application, you\'ll need your secret phrase to recover your funds!"),
        "securityHeader": MessageLookupByLibrary.simpleMessage("Security"),
        "seedDescription": MessageLookupByLibrary.simpleMessage(
            "A seed bears the same information as a secret phrase, but in a machine-readable way. As long as you have one of them backed up, you\'ll have access to your funds."),
        "send": MessageLookupByLibrary.simpleMessage("Send"),
        "sendAmountConfirm":
            MessageLookupByLibrary.simpleMessage("Send %1 UCO"),
        "sendError": MessageLookupByLibrary.simpleMessage(
            "An error occurred. Try again later."),
        "sent": MessageLookupByLibrary.simpleMessage("Sent"),
        "sentTo": MessageLookupByLibrary.simpleMessage("Sent To"),
        "systemDefault": MessageLookupByLibrary.simpleMessage("System Default"),
        "tapToHide": MessageLookupByLibrary.simpleMessage("Tap to hide"),
        "tapToReveal": MessageLookupByLibrary.simpleMessage("Tap to reveal"),
        "to": MessageLookupByLibrary.simpleMessage("To"),
        "tooManyFailedAttempts": MessageLookupByLibrary.simpleMessage(
            "Too many failed unlock attempts."),
        "transactionHeader":
            MessageLookupByLibrary.simpleMessage("Transaction"),
        "transferAmountConfirm":
            MessageLookupByLibrary.simpleMessage("Transfer %1 UCO"),
        "transferNFT": MessageLookupByLibrary.simpleMessage("Transfer NFT"),
        "transferNFTName": MessageLookupByLibrary.simpleMessage("Transfer %1"),
        "transferSuccess": MessageLookupByLibrary.simpleMessage(
            "The transaction was sent successfully"),
        "transferUCO": MessageLookupByLibrary.simpleMessage("Transfer UCO"),
        "transfering": MessageLookupByLibrary.simpleMessage("Transfering"),
        "understandButton":
            MessageLookupByLibrary.simpleMessage("I understand"),
        "unlock": MessageLookupByLibrary.simpleMessage("Unlock"),
        "unlockBiometrics":
            MessageLookupByLibrary.simpleMessage("Authenticate to Unlock"),
        "unlockPin":
            MessageLookupByLibrary.simpleMessage("Enter PIN to Unlock"),
        "update": MessageLookupByLibrary.simpleMessage("Update"),
        "walletFAQDesc": MessageLookupByLibrary.simpleMessage(
            "Have a question? Check here first!"),
        "walletFAQHeader": MessageLookupByLibrary.simpleMessage("Wallet FAQ"),
        "warning": MessageLookupByLibrary.simpleMessage("Warning"),
        "welcomeText": MessageLookupByLibrary.simpleMessage(
            "Welcome to Internet of Trust.\n\nARCHEthic gives back to humanity control over technology, and to each individual, control over their identity."),
        "xMinute": MessageLookupByLibrary.simpleMessage("After %1 minute"),
        "xMinutes": MessageLookupByLibrary.simpleMessage("After %1 minutes"),
        "yes": MessageLookupByLibrary.simpleMessage("Yes")
      };
}
