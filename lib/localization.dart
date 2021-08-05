// @dart=2.9

// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:intl/intl.dart';

// Project imports:
import 'package:archethic_mobile_wallet/l10n/messages_all.dart';
import 'package:archethic_mobile_wallet/model/available_language.dart';

/// Localization
class AppLocalization {
  static Locale currentLocale = const Locale('en', 'US');

  static Future<AppLocalization> load(Locale locale) {
    currentLocale = locale;
    final String name =
        locale.countryCode == null ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);

    return initializeMessages(localeName).then((bool _) {
      Intl.defaultLocale = localeName;
      return AppLocalization();
    });
  }

  static AppLocalization of(BuildContext context) {
    return Localizations.of<AppLocalization>(context, AppLocalization);
  }

  String get welcomeText {
    return Intl.message(
        'Welcome to Internet of Trust.\n\nJoin the Internet of Trust with ArchEthic Public Blockchain by Uniris and be the only key.\n\nTo begin, you may connect to your decentralized wallet with your transaction chain seed.',
        desc: '',
        name: 'welcomeText');
  }

  String get connectWallet {
    return Intl.message('Connect to my wallet',
        desc: '', name: 'connectWallet');
  }

  String get enterTxChainSeedText {
    return Intl.message('Please, enter a transaction chain seed',
        desc: '', name: 'enterTxChainSeedText');
  }

  String get cancel {
    return Intl.message('Cancel', desc: 'dialog_cancel', name: 'cancel');
  }

  String get close {
    return Intl.message('Close', desc: 'dialog_close', name: 'close');
  }

  String get confirm {
    return Intl.message('Confirm', desc: 'dialog_confirm', name: 'confirm');
  }

  String get no {
    return Intl.message('No', desc: 'intro_new_wallet_backup_no', name: 'no');
  }

  String get yes {
    return Intl.message('Yes',
        desc: 'intro_new_wallet_backup_yes', name: 'yes');
  }

  String get send {
    return Intl.message('Send', desc: '', name: 'send');
  }

  String get add {
    return Intl.message('Add', desc: '', name: 'add');
  }

  String get update {
    return Intl.message('Update', desc: '', name: 'update');
  }

  String get transferUCO {
    return Intl.message('Transfer UCO', desc: '', name: 'transferUCO');
  }

  String get transferNFT {
    return Intl.message('Transfer NFT', desc: '', name: 'transferNFT');
  }

  String get transferNFTName {
    return Intl.message('Transfer %1', desc: '', name: 'transferNFTName');
  }

  String get sent {
    return Intl.message('Sent', desc: 'history_sent', name: 'sent');
  }

  String get received {
    return Intl.message('Received', desc: 'history_received', name: 'received');
  }

  String get transactionHeader {
    return Intl.message('Transaction',
        desc: 'transaction_header', name: 'transactionHeader');
  }

  String get recentTransactionsHeader {
    return Intl.message('Recent transactions',
        desc: '', name: 'recentTransactionsHeader');
  }

  String get addressCopied {
    return Intl.message('Address Copied',
        desc: 'receive_copied', name: 'addressCopied');
  }

  String get copyAddress {
    return Intl.message('Copy Address',
        desc: 'receive_copy_cta', name: 'copyAddress');
  }

  String get addressHint {
    return Intl.message('Enter Address',
        desc: 'send_address_hint', name: 'addressHint');
  }

  String get scanQrCode {
    return Intl.message('Scan QR Code',
        desc: 'send_scan_qr', name: 'scanQrCode');
  }

  String get qrInvalidAddress {
    return Intl.message('QR code does not contain a valid destination',
        desc: 'qr_invalid_address', name: 'qrInvalidAddress');
  }

  String get qrInvalidPermissions {
    return Intl.message('Please Grant Camera Permissions to scan QR Codes',
        desc: 'User did not grant camera permissions to the app',
        name: 'qrInvalidPermissions');
  }

  String get qrUnknownError {
    return Intl.message('Could not Read QR Code',
        desc: 'An unknown error occurred with the QR scanner',
        name: 'qrUnknownError');
  }

  String get customUrlHeader {
    return Intl.message('Custom Urls', desc: '', name: 'customUrlHeader');
  }

  String get customUrlDesc {
    return Intl.message('Define the endpoint', desc: '', name: 'customUrlDesc');
  }

  String get walletFAQHeader {
    return Intl.message('Wallet FAQ', desc: '', name: 'walletFAQHeader');
  }

  String get walletFAQDesc {
    return Intl.message('Have a question? Check here first!',
        desc: '', name: 'walletFAQDesc');
  }

  String get enterEndpoint {
    return Intl.message('Enter an endpoint', desc: '', name: 'enterEndpoint');
  }

  String get removeContact {
    return Intl.message('Remove Contact',
        desc: 'contact_remove_btn', name: 'removeContact');
  }

  String get removeContactConfirmation {
    return Intl.message('Are you sure you want to delete %1?',
        desc: 'contact_remove_sure', name: 'removeContactConfirmation');
  }

  String get addressBookHeader {
    return Intl.message('Address book', desc: '', name: 'addressBookHeader');
  }

  String get contactHeader {
    return Intl.message('Contact', desc: '', name: 'contactHeader');
  }

  String get addressBookDesc {
    return Intl.message('Create and manage frequently-used addresses',
        desc: '', name: 'addressBookDesc');
  }

  String get addContact {
    return Intl.message('Add Contact',
        desc: 'contact_add_button', name: 'addContact');
  }

  String get contactNameHint {
    return Intl.message('Enter a Name @',
        desc: 'contact_name_hint', name: 'contactNameHint');
  }

  String get contactInvalid {
    return Intl.message('Invalid Contact Name',
        desc: 'contact_invalid_name', name: 'contactInvalid');
  }

  String get contactAdded {
    return Intl.message('%1 added to address book.',
        desc: 'contact_added', name: 'contactAdded');
  }

  String get contactRemoved {
    return Intl.message('%1 has been removed from address book!',
        desc: 'contact_removed', name: 'contactRemoved');
  }

  String get contactNameMissing {
    return Intl.message('Choose a Name for this contact',
        desc: 'contact_name_missing', name: 'contactNameMissing');
  }

  String get contactExists {
    return Intl.message('Contact Already Exists',
        desc: 'contact_name_exists', name: 'contactExists');
  }

  String get sentTo {
    return Intl.message('Sent To', desc: 'sent_to', name: 'sentTo');
  }

  String get transferSuccess {
    return Intl.message('The transaction was sent successfully',
        desc: '', name: 'transferSuccess');
  }

  String get transfering {
    return Intl.message('Transfering',
        desc: 'send_sending', name: 'transfering');
  }

  String get to {
    return Intl.message('To', desc: 'send_to', name: 'to');
  }

  String get getOption {
    return Intl.message('Get', desc: '', name: 'getOption');
  }

  String get deleteOption {
    return Intl.message('Delete', desc: '', name: 'deleteOption');
  }

  String get sendAmountConfirm {
    return Intl.message('Send %1 UCO',
        desc: 'send_pin_description', name: 'sendAmountConfirm');
  }

  String get transferAmountConfirm {
    return Intl.message('Transfer %1 UCO',
        desc: 'send_pin_description', name: 'transferAmountConfirm');
  }

  String get transferAmountConfirmPin {
    return transferAmountConfirm;
  }

  String get sendError {
    return Intl.message('An error occurred. Try again later.',
        desc: 'send_generic_error', name: 'sendError');
  }

  String get enterAmount {
    return Intl.message('Enter Amount',
        desc: 'send_amount_hint', name: 'enterAmount');
  }

  String get enterAddress {
    return Intl.message('Enter Address',
        desc: 'enter_address', name: 'enterAddress');
  }

  String get invalidAddress {
    return Intl.message('Address entered was invalid',
        desc: 'send_invalid_address', name: 'invalidAddress');
  }

  String get addressMissing {
    return Intl.message('Please Enter an Address',
        desc: 'send_enter_address', name: 'addressMissing');
  }

  String get amountMissing {
    return Intl.message('Please Enter an Amount',
        desc: 'send_enter_amount', name: 'amountMissing');
  }

  String get minimumSend {
    return Intl.message('Minimum send amount is %1 UCO',
        desc: 'send_minimum_error', name: 'minimumSend');
  }

  String get insufficientBalance {
    return Intl.message('Insufficient Balance',
        desc: 'send_insufficient_balance', name: 'insufficientBalance');
  }

  String get fees {
    return Intl.message('Fees', desc: 'fees', name: 'fees');
  }

  String get pinCreateTitle {
    return Intl.message('Create a 6-digit pin',
        desc: 'pin_create_title', name: 'pinCreateTitle');
  }

  String get pinConfirmTitle {
    return Intl.message('Confirm your pin',
        desc: 'pin_confirm_title', name: 'pinConfirmTitle');
  }

  String get pinEnterTitle {
    return Intl.message('Enter pin',
        desc: 'pin_enter_title', name: 'pinEnterTitle');
  }

  String get pinConfirmError {
    return Intl.message('Pins do not match',
        desc: 'pin_confirm_error', name: 'pinConfirmError');
  }

  String get pinInvalid {
    return Intl.message('Invalid pin entered',
        desc: 'pin_error', name: 'pinInvalid');
  }

  String get authMethod {
    return Intl.message('Auth. Method',
        desc: 'settings_disable_fingerprint', name: 'authMethod');
  }

  String get pinMethod {
    return Intl.message('PIN', desc: 'settings_pin_method', name: 'pinMethod');
  }

  String get biometricsMethod {
    return Intl.message('Biometrics',
        desc: 'settings_fingerprint_method', name: 'biometricsMethod');
  }

  String get currency {
    return Intl.message('Currency',
        desc: 'A settings menu item for changing currency', name: 'currency');
  }

  String get changeCurrencyHeader {
    return Intl.message('Currency', desc: '', name: 'changeCurrencyHeader');
  }

  String get changeCurrencyDesc {
    return Intl.message(
        'Select the fiat currency you would like to display alongside UCO',
        desc: '',
        name: 'changeCurrencyDesc');
  }

  String get language {
    return Intl.message('Language',
        desc: 'settings_change_language', name: 'language');
  }

  String get logout {
    return Intl.message('Logout', desc: 'settings_logout', name: 'logout');
  }

  String get rootWarning {
    return Intl.message(
        'It appears your device is "rooted", "jailbroken", or modified in a way that compromises security. It is recommended that you reset your device to its original state before proceeding.',
        desc:
            'Shown to users if they have a rooted Android device or jailbroken iOS device',
        name: 'rootWarning');
  }

  String get iUnderstandTheRisks {
    return Intl.message('I Understand the Risks',
        desc:
            'Shown to users if they have a rooted Android device or jailbroken iOS device',
        name: 'iUnderstandTheRisks');
  }

  String get exit {
    return Intl.message('Exit',
        desc: 'Exit action, like a button', name: 'exit');
  }

  String get warning {
    return Intl.message('Warning',
        desc: 'settings_logout_alert_title', name: 'warning');
  }

  String get logoutDetail {
    return Intl.message(
        'Logging out will remove all ArchEthic Wallet-related data from this device. If your password is not backed up, you will never be able to access your wallet again',
        desc: 'settings_logout_alert_message',
        name: 'logoutDetail');
  }

  String get logoutAction {
    return Intl.message('Delete Infos and Logout',
        desc: 'settings_logout_alert_confirm_cta', name: 'logoutAction');
  }

  String get logoutAreYouSure {
    return Intl.message('Are you sure?',
        desc: 'settings_logout_warning_title', name: 'logoutAreYouSure');
  }

  String get logoutReassurance {
    return Intl.message(
        'As long as you\'ve backed up your seed you have nothing to worry about.',
        desc: 'settings_logout_warning_message',
        name: 'logoutReassurance');
  }

  String get preferences {
    return Intl.message('Preferences',
        desc: 'settings_preferences_header', name: 'preferences');
  }

  String get manage {
    return Intl.message('Manage',
        desc: 'settings_manage_header', name: 'manage');
  }

  String get backupSeed {
    return Intl.message('Backup Seed',
        desc: 'settings_backup_seed', name: 'backupSeed');
  }

  String get fingerprintSeedBackup {
    return Intl.message('Authenticate to backup seed.',
        desc: 'settings_fingerprint_title', name: 'fingerprintSeedBackup');
  }

  String get pinSeedBackup {
    return Intl.message('Enter PIN to Backup Seed',
        desc: 'settings_pin_title', name: 'pinSeedBackup');
  }

  String get systemDefault {
    return Intl.message('System Default',
        desc: 'settings_default_language_string', name: 'systemDefault');
  }

  String get unlockPin {
    return Intl.message('Enter PIN to Unlock', desc: '', name: 'unlockPin');
  }

  String get unlockBiometrics {
    return Intl.message('Authenticate to Unlock',
        desc: '', name: 'unlockBiometrics');
  }

  String get confirmBiometrics {
    return Intl.message('Authenticate to Confirm',
        desc: '', name: 'confirmBiometrics');
  }

  String get lockAppSetting {
    return Intl.message('Auth. on Launch',
        desc: 'authenticate_on_launch', name: 'lockAppSetting');
  }

  String get locked {
    return Intl.message('Locked', desc: 'lockedtxt', name: 'locked');
  }

  String get unlock {
    return Intl.message('Unlock', desc: 'unlocktxt', name: 'unlock');
  }

  String get tooManyFailedAttempts {
    return Intl.message('Too many failed unlock attempts.',
        desc: 'fail_toomany_attempts', name: 'tooManyFailedAttempts');
  }

  String get securityHeader {
    return Intl.message('Security',
        desc: 'security_header', name: 'securityHeader');
  }

  String get aboutHeader {
    return Intl.message('About', desc: '', name: 'aboutHeader');
  }

  String get aboutGeneralTermsAndConditions {
    return Intl.message('General Terms & Conditions',
        desc: '', name: 'aboutGeneralTermsAndConditions');
  }

  String get aboutWalletServiceTerms {
    return Intl.message('Wallet Service Terms',
        desc: '', name: 'aboutWalletServiceTerms');
  }

  String get aboutPrivacyPolicy {
    return Intl.message('Privacy Policy', desc: '', name: 'aboutPrivacyPolicy');
  }

  String get autoLockHeader {
    return Intl.message('Auto Lock',
        desc: 'auto_lock_header', name: 'autoLockHeader');
  }

  String get xMinutes {
    return Intl.message('After %1 minutes',
        desc: 'after_minutes', name: 'xMinutes');
  }

  String get xMinute {
    return Intl.message('After %1 minute',
        desc: 'after_minute', name: 'xMinute');
  }

  String get instantly {
    return Intl.message('Instantly', desc: 'insantly', name: 'instantly');
  }

  String get setWalletPassword {
    return Intl.message('Set Wallet Password',
        desc: 'Allows user to encrypt wallet with a password',
        name: 'setWalletPassword');
  }

  String get setPassword {
    return Intl.message('Set Password',
        desc: 'A button that sets the wallet password', name: 'setPassword');
  }

  String get disableWalletPassword {
    return Intl.message('Disable Wallet Password',
        desc: 'Allows user to deencrypt wallet with a password',
        name: 'disableWalletPassword');
  }

  String get encryptionFailedError {
    return Intl.message('Failed to set a wallet password',
        desc: 'If encrypting a wallet raised an error',
        name: 'encryptionFailedError');
  }

  String get setPasswordSuccess {
    return Intl.message('Password has been set successfully',
        desc: 'Setting a Wallet Password was successful',
        name: 'setPasswordSuccess');
  }

  String get disablePasswordSuccess {
    return Intl.message('Password has been disabled',
        desc: 'Disabling a Wallet Password was successful',
        name: 'disablePasswordSuccess');
  }

  String get defaultAccountName {
    return Intl.message('Main Account',
        desc: 'Default account name', name: 'defaultAccountName');
  }

  String get defaultNewAccountName {
    return Intl.message('Account %1',
        desc: 'Default new account name - e.g. Account 1',
        name: 'defaultNewAccountName');
  }

  String get account {
    return Intl.message('Account', desc: 'Account text', name: 'account');
  }

  String get accounts {
    return Intl.message('Accounts', desc: 'Accounts header', name: 'accounts');
  }

  String get addAccount {
    return Intl.message('Add Account',
        desc: 'Default new account name - e.g. Account 1', name: 'addAccount');
  }

  String get hideAccountHeader {
    return Intl.message('Hide Account?',
        desc: 'Confirmation dialog header', name: 'hideAccountHeader');
  }

  String get removeAccountText {
    return Intl.message(
        'Are you sure you want to hide this account? You can re-add it later by tapping the \'%1\' button.',
        desc: 'Remove account dialog body',
        name: 'removeAccountText');
  }

  String get tapToReveal {
    return Intl.message('Tap to reveal',
        desc: 'Tap to reveal hidden content', name: 'tapToReveal');
  }

  String get tapToHide {
    return Intl.message('Tap to hide',
        desc: 'Tap to hide content', name: 'tapToHide');
  }

  String get copied {
    return Intl.message('Copied',
        desc: 'Copied (to clipboard)', name: 'copied');
  }

  String get pinPadShuffle {
    return Intl.message('PIN Pad Shuffle', desc: '', name: 'pinPadShuffle');
  }

  String get copy {
    return Intl.message('Copy', desc: 'Copy (to clipboard)', name: 'copy');
  }

  String get seedDescription {
    return Intl.message(
        'A seed bears the same information as a secret phrase, but in a machine-readable way. As long as you have one of them backed up, you\'ll have access to your funds.',
        desc: 'Describing what a seed is',
        name: 'seedDescription');
  }

  String get secretInfoHeader {
    return Intl.message('Safety First!',
        desc: 'secret info header', name: 'secretInfoHeader');
  }

  String get secretInfo {
    return Intl.message(
        'In the next screen, you will see your secret phrase. It is a password to access your funds. It is crucial that you back it up and never share it with anyone.',
        desc: 'Description for seed',
        name: 'secretInfo');
  }

  String get secretWarning {
    return Intl.message(
        'If you lose your device or uninstall the application, you\'ll need your secret phrase or seed to recover your funds!',
        desc: 'Secret warning',
        name: 'secretWarning');
  }

  String get gotItButton {
    return Intl.message('Got It!',
        desc: 'Got It! Acknowledgement button', name: 'gotItButton');
  }

  String get ackBackedUp {
    return Intl.message(
        'Are you sure that you\'ve backed up your secret phrase or seed?',
        desc: 'Ack backed up',
        name: 'ackBackedUp');
  }

  String get backupSecretPhrase {
    return Intl.message('Backup Secret Phrase',
        desc: 'backup seed', name: 'backupSecretPhrase');
  }

  String get createPasswordHint {
    return Intl.message('Create a password',
        desc: 'A text field hint that tells the user to create a password',
        name: 'createPasswordHint');
  }

  String get confirmPasswordHint {
    return Intl.message('Confirm the password',
        desc: 'A text field hint that tells the user to confirm the password',
        name: 'confirmPasswordHint');
  }

  String get enterPasswordHint {
    return Intl.message('Enter your password',
        desc: '', name: 'enterPasswordHint');
  }

  String get enterTxAddressHint {
    return Intl.message('Enter a transaction address',
        desc: '', name: 'enterTxAddressHint');
  }

  String get enterTxChainSeedHint {
    return Intl.message('Enter a transaction chain seed',
        desc: '', name: 'enterTxChainSeedHint');
  }

  String get passwordsDontMatch {
    return Intl.message('Passwords do not match',
        desc: 'An error indicating a password has been confirmed incorrectly',
        name: 'passwordsDontMatch');
  }

  String get passwordBlank {
    return Intl.message('Password cannot be empty',
        desc: 'An error indicating a password has been entered incorrectly',
        name: 'passwordBlank');
  }

  String get invalidPassword {
    return Intl.message('Invalid Password',
        desc: 'An error indicating a password has been entered incorrectly',
        name: 'invalidPassword');
  }

  String get passwordWillBeRequiredToOpenParagraph {
    return Intl.message('This password will be required to open your Wallet.',
        desc: '', name: 'passwordWillBeRequiredToOpenParagraph');
  }

  String get passwordNoLongerRequiredToOpenParagraph {
    return Intl.message(
        'You will not need a password to open your Wallet anymore.',
        desc: '',
        name: 'passwordNoLongerRequiredToOpenParagraph');
  }

  String get createPasswordFirstParagraph {
    return Intl.message(
        'You can create a password to add additional security to your wallet.',
        desc:
            'A paragraph that tells the users that they can create a password for additional security.',
        name: 'createPasswordFirstParagraph');
  }

  String get createPasswordSecondParagraph {
    return Intl.message(
        'Password is optional, and your wallet will be protected with your PIN or biometrics regardless',
        desc: '',
        name: 'createPasswordSecondParagraph');
  }

  String get createAPasswordHeader {
    return Intl.message('Create a password.',
        desc: 'A paragraph that tells the users to create a password.',
        name: 'createAPasswordHeader');
  }

  String get createPasswordSheetHeader {
    return Intl.message('Create',
        desc: 'Prompt user to create a new password',
        name: 'createPasswordSheetHeader');
  }

  String get disablePasswordSheetHeader {
    return Intl.message('Disable',
        desc: 'Prompt user to disable their password',
        name: 'disablePasswordSheetHeader');
  }

  String get requireAPasswordToOpenHeader {
    return Intl.message('Require a password to open ArchEthic Wallet ?',
        desc: '', name: 'requireAPasswordToOpenHeader');
  }

  String get releaseNoteHeader {
    return Intl.message('What\'s new',
        desc: 'What\'s new', name: 'releaseNoteHeader');
  }

  String get ok {
    return Intl.message('Ok', desc: '', name: 'ok');
  }

  String get noSkipButton {
    return Intl.message('No, Skip',
        desc: 'A button that declines and skips the mentioned process.',
        name: 'noSkipButton');
  }

  String get nextButton {
    return Intl.message('Next',
        desc: 'A button that goes to the next screen.', name: 'nextButton');
  }

  String get goBackButton {
    return Intl.message('Go Back',
        desc: 'A button that goes to the previous screen.',
        name: 'goBackButton');
  }

  String get addressInfos {
    return Intl.message('Address informations', desc: '', name: 'addressInfos');
  }

  String get informations {
    return Intl.message('Informations', desc: '', name: 'informations');
  }

  String get nodesHeader {
    return Intl.message('Nodes', desc: '', name: 'nodesHeader');
  }

  String get nodesHeaderDesc {
    return Intl.message('Nodes informations',
        desc: '', name: 'nodesHeaderDesc');
  }

  String get addNFT {
    return Intl.message('Add NFT', desc: '', name: 'addNFT');
  }

  String get addNFTHeader {
    return Intl.message('Add NFT', desc: '', name: 'addNFTHeader');
  }

  String get nftHeader {
    return Intl.message('NFT', desc: '', name: 'nftHeader');
  }

  String get nftHeaderDesc {
    return Intl.message('Manage your Non Financial Tokens', desc: '', name: 'nftHeaderDesc');
  }

  String get nftNameHint {
    return Intl.message('Enter a name', desc: '', name: 'nftNameHint');
  }

  String get nftInitialSupplyHint {
    return Intl.message('Enter an initial supply',
        desc: '', name: 'nftInitialSupplyHint');
  }

  String get nftNameMissing {
    return Intl.message('Choose a Name for the NFT',
        desc: '', name: 'nftNameMissing');
  }

  String get nftInitialSupplyMissing {
    return Intl.message('Choose an initial supply for the NFT',
        desc: '', name: 'nftInitialSupplyMissing');
  }

  String get nftInitialSupplyPositive {
    return Intl.message('The initial supply should be > 0',
        desc: '', name: 'nftInitialSupplyPositive');
  }
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalization> {
  const AppLocalizationsDelegate(this.languageSetting);

  final LanguageSetting languageSetting;

  @override
  bool isSupported(Locale locale) {
    return languageSetting != null;
  }

  @override
  Future<AppLocalization> load(Locale locale) {
    if (languageSetting.language == AvailableLanguage.DEFAULT) {
      return AppLocalization.load(locale);
    }
    return AppLocalization.load(Locale(languageSetting.getLocaleString()));
  }

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalization> old) {
    return true;
  }
}
