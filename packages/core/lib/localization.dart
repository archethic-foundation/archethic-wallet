// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:core/l10n/messages_all.dart';
import 'package:core/model/available_language.dart';
import 'package:intl/intl.dart';

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

  static AppLocalization? of(BuildContext context) {
    return Localizations.of<AppLocalization>(context, AppLocalization);
  }

  String get welcomeText {
    return Intl.message(
        'Welcome to Internet of Trust.\n\nARCHEthic gives back to humanity control over technology, and to each individual, control over their identity.',
        name: 'welcomeText');
  }

  String get cancel {
    return Intl.message('Cancel', name: 'cancel');
  }

  String get close {
    return Intl.message('Close', name: 'close');
  }

  String get confirm {
    return Intl.message('Confirm', name: 'confirm');
  }

  String get no {
    return Intl.message('No', name: 'no');
  }

  String get yes {
    return Intl.message('Yes', name: 'yes');
  }

  String get send {
    return Intl.message('Send', name: 'send');
  }

  String get add {
    return Intl.message('Add', name: 'add');
  }

  String get update {
    return Intl.message('Update', name: 'update');
  }

  String get transferTokens {
    return Intl.message('Send %1', name: 'transferTokens');
  }

  String get transferNFT {
    return Intl.message('Transfer NFT', name: 'transferNFT');
  }

  String get transferNFTName {
    return Intl.message('Transfer %1', name: 'transferNFTName');
  }

  String get recentTransactionsHeader {
    return Intl.message('Recent transactions',
        name: 'recentTransactionsHeader');
  }

  String get recentTransactionsNoTransactionYet {
    return Intl.message('No transaction yet',
        name: 'recentTransactionsNoTransactionYet');
  }

  String get addressCopied {
    return Intl.message('Address Copied', name: 'addressCopied');
  }

  String get copyAddress {
    return Intl.message('Copy Address', name: 'copyAddress');
  }

  String get addressHint {
    return Intl.message('Enter Address', name: 'addressHint');
  }

  String get scanQrCode {
    return Intl.message('Scan QR Code', name: 'scanQrCode');
  }

  String get qrInvalidAddress {
    return Intl.message('QR code does not contain a valid destination',
        name: 'qrInvalidAddress');
  }

  String get qrInvalidPermissions {
    return Intl.message('Please Grant Camera Permissions to scan QR Codes',
        name: 'qrInvalidPermissions');
  }

  String get qrUnknownError {
    return Intl.message('Could not Read QR Code', name: 'qrUnknownError');
  }

  String get networksHeader {
    return Intl.message('Networks', name: 'networksHeader');
  }

  String get networksDesc {
    return Intl.message('Define the endpoint', name: 'networksDesc');
  }

  String get walletFAQHeader {
    return Intl.message('Wallet FAQ', name: 'walletFAQHeader');
  }

  String get walletFAQDesc {
    return Intl.message('Have a question? Check here first!',
        name: 'walletFAQDesc');
  }

  String get enterEndpoint {
    return Intl.message('Enter an endpoint', name: 'enterEndpoint');
  }

  String get enterYubikeyClientID {
    return Intl.message('Enter the client ID', name: 'enterYubikeyClientID');
  }

  String get enterYubikeyClientAPIKey {
    return Intl.message('Enter the client API Key',
        name: 'enterYubikeyClientAPIKey');
  }

  String get yubikeyParamsHeader {
    return Intl.message('Yubikey Params', name: 'yubikeyParamsHeader');
  }

  String get yubikeyParamsDesc {
    return Intl.message('Setting up Yubicloud access',
        name: 'yubikeyParamsDesc');
  }

  String get removeContact {
    return Intl.message('Remove Contact', name: 'removeContact');
  }

  String get removeContactConfirmation {
    return Intl.message('Are you sure you want to delete %1?',
        name: 'removeContactConfirmation');
  }

  String get addressBookHeader {
    return Intl.message('Address book', name: 'addressBookHeader');
  }

  String get contactHeader {
    return Intl.message('Contact', name: 'contactHeader');
  }

  String get addressBookDesc {
    return Intl.message('Create and manage frequently-used addresses',
        name: 'addressBookDesc');
  }

  String get addContact {
    return Intl.message('Add Contact', name: 'addContact');
  }

  String get contactNameHint {
    return Intl.message('Enter a Name @', name: 'contactNameHint');
  }

  String get contactInvalid {
    return Intl.message('Invalid Contact Name', name: 'contactInvalid');
  }

  String get contactAdded {
    return Intl.message('%1 added to address book.', name: 'contactAdded');
  }

  String get contactRemoved {
    return Intl.message('%1 has been removed from address book!',
        name: 'contactRemoved');
  }

  String get contactNameMissing {
    return Intl.message('Choose a Name for this contact',
        name: 'contactNameMissing');
  }

  String get contactExists {
    return Intl.message('Contact Already Exists', name: 'contactExists');
  }

  String get transferSuccess {
    return Intl.message('The transaction was sent successfully',
        name: 'transferSuccess');
  }

  String get transfering {
    return Intl.message('Transfering', name: 'transfering');
  }

  String get getOption {
    return Intl.message('Get', name: 'getOption');
  }

  String get deleteOption {
    return Intl.message('Delete', name: 'deleteOption');
  }

  String get sendError {
    return Intl.message('An error occurred. Try again later.',
        name: 'sendError');
  }

  // ignore: non_constant_identifier_names
  String get yubikeyError_BAD_OTP {
    return Intl.message('The OTP is invalid format.',
        name: 'yubikeyError_BAD_OTP');
  }

  // ignore: non_constant_identifier_names
  String get yubikeyError_REPLAYED_OTP {
    return Intl.message('The OTP has already been seen by the service.',
        name: 'yubikeyError_REPLAYED_OTP');
  }

  // ignore: non_constant_identifier_names
  String get yubikeyError_BAD_SIGNATURE {
    return Intl.message('The HMAC signature verification failed.',
        name: 'yubikeyError_BAD_SIGNATURE');
  }

  // ignore: non_constant_identifier_names
  String get yubikeyError_MISSING_PARAMETER {
    return Intl.message('The request lacks a parameter.',
        name: 'yubikeyError_MISSING_PARAMETER');
  }

  // ignore: non_constant_identifier_names
  String get yubikeyError_NO_SUCH_CLIENT {
    return Intl.message('The request ID does not exist.',
        name: 'yubikeyError_NO_SUCH_CLIENT');
  }

  // ignore: non_constant_identifier_names
  String get yubikeyError_OPERATION_NOT_ALLOWED {
    return Intl.message('The request ID is not allowed to verify OTPs.',
        name: 'yubikeyError_OPERATION_NOT_ALLOWED');
  }

  // ignore: non_constant_identifier_names
  String get yubikeyError_BACKEND_ERROR {
    return Intl.message('Unexpected error in the yubicloud server.',
        name: 'yubikeyError_BACKEND_ERROR');
  }

  // ignore: non_constant_identifier_names
  String get yubikeyError_NOT_ENOUGH_ANSWERS {
    return Intl.message(
        'Server could not get requested number of syncs during before timeout.',
        name: 'yubikeyError_NOT_ENOUGH_ANSWERS');
  }

  // ignore: non_constant_identifier_names
  String get yubikeyError_REPLAYED_REQUEST {
    return Intl.message('Server has seen the OTP/Nonce combination before',
        name: 'yubikeyError_REPLAYED_REQUEST');
  }

  // ignore: non_constant_identifier_names
  String get yubikeyError_RESPONSE_KO {
    return Intl.message(
        'An error occurred with Yubikey Authentification. Try again later.',
        name: 'yubikeyError_RESPONSE_KO');
  }

  // ignore: non_constant_identifier_names
  String get yubikeyError_OTP_NOT_FOUND {
    return Intl.message('The OTP is empty', name: 'yubikeyError_OTP_NOT_FOUND');
  }

  String get enterAmount {
    return Intl.message('Enter Amount', name: 'enterAmount');
  }

  String get enterAddress {
    return Intl.message('Enter Address', name: 'enterAddress');
  }

  String get invalidAddress {
    return Intl.message('Address entered is invalid', name: 'invalidAddress');
  }

  String get addressMissing {
    return Intl.message('Please Enter an Address', name: 'addressMissing');
  }

  String get sendToMeError {
    return Intl.message('You can\'t send %1 to your own wallet.',
        name: 'sendToMeError');
  }

  String get amountMissing {
    return Intl.message('Please Enter an Amount', name: 'amountMissing');
  }

  String get insufficientBalance {
    return Intl.message('You don\'t have enough %1',
        name: 'insufficientBalance');
  }

  String get fees {
    return Intl.message('Fees', name: 'fees');
  }

  String get estimatedFees {
    return Intl.message('Estimated fees', name: 'estimatedFees');
  }

  String get total {
    return Intl.message('Total', name: 'total');
  }

  String get estimatedFeesNote {
    return Intl.message(
        'Note: The fees will be estimated when the address and the amount are specified.',
        name: 'estimatedFeesNote');
  }

  String get estimatedFeesAddNFTNote {
    return Intl.message(
        'Note: The fees will be estimated when the name and the initial supply are specified.',
        name: 'estimatedFeesAddNFTNote');
  }

  String get pinCreateTitle {
    return Intl.message('Create a 6-digit pin', name: 'pinCreateTitle');
  }

  String get pinConfirmTitle {
    return Intl.message('Confirm your pin', name: 'pinConfirmTitle');
  }

  String get pinEnterTitle {
    return Intl.message('Enter pin', name: 'pinEnterTitle');
  }

  String get pinConfirmError {
    return Intl.message('Pins do not match', name: 'pinConfirmError');
  }

  String get pinInvalid {
    return Intl.message('Invalid pin entered', name: 'pinInvalid');
  }

  String get authMethod {
    return Intl.message('Auth. Method', name: 'authMethod');
  }

  String get pinMethod {
    return Intl.message('PIN', name: 'pinMethod');
  }

  String get yubikeyWithYubiCloudMethod {
    return Intl.message('Yubikey', name: 'yubikeyWithYubiCloudMethod');
  }

  String get ledgerMethod {
    return Intl.message('Ledger Nano S', name: 'ledgerMethod');
  }

  String get biometricsMethod {
    return Intl.message('Biometrics', name: 'biometricsMethod');
  }

  String get currency {
    return Intl.message('Currency', name: 'currency');
  }

  String get currencyOracleInfo {
    return Intl.message(
        'This icon means that the conversion will use an oracle provided by ARCHEthic.',
        name: 'currencyOracleInfo');
  }

  String get changeCurrencyHeader {
    return Intl.message('Currency', name: 'changeCurrencyHeader');
  }

  String get changeCurrencyDesc {
    return Intl.message(
        'Select the fiat currency you would like to display alongside %1',
        name: 'changeCurrencyDesc');
  }

  String get language {
    return Intl.message('Language', name: 'language');
  }

  String get removeWallet {
    return Intl.message('Remove Wallet', name: 'removeWallet');
  }

  String get rootWarning {
    return Intl.message(
        'It appears your device is "rooted", "jailbroken", or modified in a way that compromises security. It is recommended that you reset your device to its original state before proceeding.',
        name: 'rootWarning');
  }

  String get iUnderstandTheRisks {
    return Intl.message('I Understand the Risks', name: 'iUnderstandTheRisks');
  }

  String get exit {
    return Intl.message('Exit', name: 'exit');
  }

  String get warning {
    return Intl.message('Warning', name: 'warning');
  }

  String get removeWalletDetail {
    return Intl.message(
        'You are about to remove all ARCHEthic-related data from this device. If your secret phrase is not backed up, you will never be able to access your wallet again',
        name: 'removeWalletDetail');
  }

  String get removeWalletAction {
    return Intl.message('Delete from this device your wallet',
        name: 'removeWalletAction');
  }

  String get removeWalletAreYouSure {
    return Intl.message('Are you sure?', name: 'removeWalletAreYouSure');
  }

  String get removeWalletReassurance {
    return Intl.message(
        'As long as you\'ve backed up your seed you have nothing to worry about.',
        name: 'removeWalletReassurance');
  }

  String get preferences {
    return Intl.message('Preferences', name: 'preferences');
  }

  String get manage {
    return Intl.message('Manage', name: 'manage');
  }

  String get fingerprintSeedBackup {
    return Intl.message('Authenticate to backup seed.',
        name: 'fingerprintSeedBackup');
  }

  String get pinSecretPhraseBackup {
    return Intl.message('Enter PIN to Backup Secret Phrase',
        name: 'pinSecretPhraseBackup');
  }

  String get systemDefault {
    return Intl.message('System Default', name: 'systemDefault');
  }

  String get unlockPin {
    return Intl.message('Enter PIN to Unlock', name: 'unlockPin');
  }

  String get unlockBiometrics {
    return Intl.message('Authenticate to Unlock', name: 'unlockBiometrics');
  }

  String get unlockNFCYubikey {
    return Intl.message('Authenticate to Unlock', name: 'unlockNFCYubikey');
  }

  String get confirmBiometrics {
    return Intl.message('Authenticate to Confirm', name: 'confirmBiometrics');
  }

  String get lockAppSetting {
    return Intl.message('Auth. on Launch', name: 'lockAppSetting');
  }

  String get locked {
    return Intl.message('Locked', name: 'locked');
  }

  String get unlock {
    return Intl.message('Unlock', name: 'unlock');
  }

  String get tooManyFailedAttempts {
    return Intl.message('Too many failed unlock attempts.',
        name: 'tooManyFailedAttempts');
  }

  String get securityHeader {
    return Intl.message('Security', name: 'securityHeader');
  }

  String get aboutHeader {
    return Intl.message('About', name: 'aboutHeader');
  }

  String get themeHeader {
    return Intl.message('Theme', name: 'themeHeader');
  }

  String get aboutGeneralTermsAndConditions {
    return Intl.message('General Terms & Conditions',
        name: 'aboutGeneralTermsAndConditions');
  }

  String get aboutWalletServiceTerms {
    return Intl.message('Wallet Service Terms',
        name: 'aboutWalletServiceTerms');
  }

  String get aboutPrivacyPolicy {
    return Intl.message('Privacy Policy', name: 'aboutPrivacyPolicy');
  }

  String get labLinkHeader {
    return Intl.message('Lab', name: 'labLinkHeader');
  }

  String get labLinkDesc {
    return Intl.message(
        'Latest tech and product updates on the Archethic ecosystem',
        name: 'labLinkDesc');
  }

  String get aeWebsiteLinkHeader {
    return Intl.message('ARCHEthic Website', name: 'aeWebsiteLinkHeader');
  }

  String get aeWebsiteLinkDesc {
    return Intl.message('Visit the ARCHEthic website',
        name: 'aeWebsiteLinkDesc');
  }

  String get autoLockHeader {
    return Intl.message('Auto Lock', name: 'autoLockHeader');
  }

  String get xMinutes {
    return Intl.message('After %1 minutes', name: 'xMinutes');
  }

  String get xMinute {
    return Intl.message('After %1 minute', name: 'xMinute');
  }

  String get instantly {
    return Intl.message('Instantly', name: 'instantly');
  }

  String get defaultAccountName {
    return Intl.message('Main Account', name: 'defaultAccountName');
  }

  String get tapToReveal {
    return Intl.message('Tap to reveal', name: 'tapToReveal');
  }

  String get tapToHide {
    return Intl.message('Tap to hide', name: 'tapToHide');
  }

  String get pinPadShuffle {
    return Intl.message('PIN Pad Shuffle', name: 'pinPadShuffle');
  }

  String get copy {
    return Intl.message('Copy', name: 'copy');
  }

  String get viewExplorer {
    return Intl.message('View on explorer', name: 'viewExplorer');
  }

  String get secretWarning {
    return Intl.message(
        'If you lose your device or uninstall the application, you\'ll need your secret phrase to recover your funds!',
        name: 'secretWarning');
  }

  String get importSecretPhrase {
    return Intl.message('Import Secret Phrase', name: 'importSecretPhrase');
  }

  String get importSecretPhraseHint {
    return Intl.message(
        'Please enter your 24-word secret phrase below. Each word should be separated by a space.',
        name: 'importSecretPhraseHint');
  }

  String get qrMnemonicError {
    return Intl.message('QR does not contain a valid secret phrase',
        name: 'qrMnemonicError');
  }

  String get mnemonicInvalidWord {
    return Intl.message('%1 is not a valid word', name: 'mnemonicInvalidWord');
  }

  String get mnemonicSizeError {
    return Intl.message('Secret phrase may only contain 24 words',
        name: 'mnemonicSizeError');
  }

  String get importWallet {
    return Intl.message('I already have a wallet', name: 'importWallet');
  }

  String get newWallet {
    return Intl.message('Get started', name: 'newWallet');
  }

  String get understandButton {
    return Intl.message('I understand', name: 'understandButton');
  }

  String get ackBackedUp {
    return Intl.message(
        'Are you sure that you\'ve backed up your secret phrase ?',
        name: 'ackBackedUp');
  }

  String get backupSecretPhrase {
    return Intl.message('Backup Secret Phrase', name: 'backupSecretPhrase');
  }

  String get ok {
    return Intl.message('Ok', name: 'ok');
  }

  String get addressInfos {
    return Intl.message('My public address to receive funds',
        name: 'addressInfos');
  }

  String get informations {
    return Intl.message('Informations', name: 'informations');
  }

  String get nodesHeader {
    return Intl.message('Nodes', name: 'nodesHeader');
  }

  String get nodesHeaderDesc {
    return Intl.message('Nodes informations', name: 'nodesHeaderDesc');
  }

  String get addNFT {
    return Intl.message('Add NFT', name: 'addNFT');
  }

  String get addNFTHeader {
    return Intl.message('Add NFT', name: 'addNFTHeader');
  }

  String get addNFTConfirmationMessage {
    return Intl.message('Do you confirm the creation of the following NFT?',
        name: 'addNFTConfirmationMessage');
  }

  String get nftHeader {
    return Intl.message('NFT', name: 'nftHeader');
  }

  String get nftHeaderDesc {
    return Intl.message('Manage your Non Financial Tokens',
        name: 'nftHeaderDesc');
  }

  String get nftNameHint {
    return Intl.message('Enter a name', name: 'nftNameHint');
  }

  String get nftName {
    return Intl.message('Name: ', name: 'nftName');
  }

  String get nftInitialSupplyHint {
    return Intl.message('Enter an initial supply',
        name: 'nftInitialSupplyHint');
  }

  String get nftNameMissing {
    return Intl.message('Choose a Name for the NFT', name: 'nftNameMissing');
  }

  String get nftInitialSupply {
    return Intl.message('Initial supply: ', name: 'nftInitialSupply');
  }

  String get nftInitialSupplyMissing {
    return Intl.message('Choose an initial supply for the NFT',
        name: 'nftInitialSupplyMissing');
  }

  String get nftInitialSupplyPositive {
    return Intl.message('The initial supply should be > 0',
        name: 'nftInitialSupplyPositive');
  }

  String get nodeNumber {
    return Intl.message('Nb of nodes : ', name: 'nodeNumber');
  }

  String get nodeFirstPublicKey {
    return Intl.message('First public key : ', name: 'nodeFirstPublicKey');
  }

  String get nodeLastPublicKey {
    return Intl.message('Last public key : ', name: 'nodeLastPublicKey');
  }

  String get nodeIP {
    return Intl.message('IP : ', name: 'nodeIP');
  }

  String get nodeGeoPatch {
    return Intl.message('Geo patch : ', name: 'nodeGeoPatch');
  }

  String get nodeNetworkPatch {
    return Intl.message('Network patch : ', name: 'nodeNetworkPatch');
  }

  String get nodeAverageAvailability {
    return Intl.message('Average availability : ',
        name: 'nodeAverageAvailability');
  }

  String get nodeAuthorized {
    return Intl.message('Authorized : ', name: 'nodeAuthorized');
  }

  String get nodeAuthorizationDate {
    return Intl.message('Authorization date : ', name: 'nodeAuthorizationDate');
  }

  String get nodeEnrollmentDate {
    return Intl.message('Enrollment date : ', name: 'nodeEnrollmentDate');
  }

  String get nodeRewardAddress {
    return Intl.message('Reward address : ', name: 'nodeRewardAddress');
  }

  String get txListFrom {
    return Intl.message('From : ', name: 'txListFrom');
  }

  String get txListTo {
    return Intl.message('To : ', name: 'txListTo');
  }

  String get txListDate {
    return Intl.message('Date : ', name: 'txListDate');
  }

  String get txListFees {
    return Intl.message('Fees : ', name: 'txListFees');
  }

  String get txListTypeTransactionLabelNewNFT {
    return Intl.message('New NFT', name: 'txListTypeTransactionLabelNewNFT');
  }

  String get txListTypeTransactionLabelReceive {
    return Intl.message('Received the ',
        name: 'txListTypeTransactionLabelReceive');
  }

  String get txListTypeTransactionLabelSend {
    return Intl.message('Sent the ', name: 'txListTypeTransactionLabelSend');
  }

  String get recoveryPhrase {
    return Intl.message('Recovery Phrase', name: 'recoveryPhrase');
  }

  String get iveBackedItUp {
    return Intl.message('I\'ve Backed It Up', name: 'iveBackedItUp');
  }

  String get backupSafetyLabel1 {
    return Intl.message(
        'On the next screen, you will see your recovery phrase.',
        name: 'backupSafetyLabel1');
  }

  String get backupSafetyLabel2 {
    return Intl.message('What is a recovery phrase?',
        name: 'backupSafetyLabel2');
  }

  String get backupSafetyLabel3 {
    return Intl.message(
        'A recovery phrase is essentially a human-readable form of your crypto\'s wallet private key, and is displayed as 24 mnemonic words. After mastering the mnemonic words, you can restore your wallet at will. Please keep the words properly and don\'t leak them to anyone.',
        name: 'backupSafetyLabel3');
  }

  String get backupSafetyLabel4 {
    return Intl.message('How to back up?', name: 'backupSafetyLabel4');
  }

  String get backupSafetyLabel5 {
    return Intl.message(
        'Write down the mnemonic words in the correct order on a piece of paper and store them in a safe place.\nPlease don\'t store the recovery phrase on electronic devices in any form, including sreenshot.\nRemember the safety of the recovery phrase is relevant to the safety of your digital assets',
        name: 'backupSafetyLabel5');
  }

  String get backupSafetyLabel6 {
    return Intl.message('Insecure ways of backup', name: 'backupSafetyLabel6');
  }

  String get backupSafetyLabel7 {
    return Intl.message('1. Screenshot\n2. Take a photo',
        name: 'backupSafetyLabel7');
  }

  String get go {
    return Intl.message('Go!', name: 'go');
  }

  String get nftCreated {
    return Intl.message('NFT Created', name: 'nftCreated');
  }

  String get version {
    return Intl.message('Version :', name: 'version');
  }

  String get settings {
    return Intl.message('Settings', name: 'settings');
  }

  String get transactionInfosHeader {
    return Intl.message('Transaction informations',
        name: 'transactionInfosHeader');
  }

  String get transactionInfosKeyAddress {
    return Intl.message('Address', name: 'transactionInfosKeyAddress');
  }

  String get transactionInfosKeyType {
    return Intl.message('Type', name: 'transactionInfosKeyType');
  }

  String get transactionInfosKeyVersion {
    return Intl.message('Version', name: 'transactionInfosKeyVersion');
  }

  String get transactionInfosKeyPreviousPublicKey {
    return Intl.message('Previous Public Key',
        name: 'transactionInfosKeyPreviousPublicKey');
  }

  String get transactionInfosKeyPreviousSignature {
    return Intl.message('Previous Signature',
        name: 'transactionInfosKeyPreviousSignature');
  }

  String get transactionInfosKeyOriginSignature {
    return Intl.message('Origin Signature',
        name: 'transactionInfosKeyOriginSignature');
  }

  String get transactionInfosKeyData {
    return Intl.message('Data', name: 'transactionInfosKeyData');
  }

  String get transactionInfosKeyContent {
    return Intl.message('Content', name: 'transactionInfosKeyContent');
  }

  String get transactionInfosKeyCode {
    return Intl.message('Code', name: 'transactionInfosKeyCode');
  }

  String get transactionInfosKeyUCOLedger {
    return Intl.message('UCO Ledger', name: 'transactionInfosKeyUCOLedger');
  }

  String get transactionInfosKeyTo {
    return Intl.message('To', name: 'transactionInfosKeyTo');
  }

  String get transactionInfosKeyAmount {
    return Intl.message('Amount', name: 'transactionInfosKeyAmount');
  }

  String get transactionInfosKeyNFTLedger {
    return Intl.message('NFT Ledger', name: 'transactionInfosKeyNFTLedger');
  }

  String get transactionInfosKeyNft {
    return Intl.message('NFT', name: 'transactionInfosKeyNft');
  }

  String get transactionInfosKeyValidationStamp {
    return Intl.message('Validation Stamp',
        name: 'transactionInfosKeyValidationStamp');
  }

  String get transactionInfosKeyProofOfWork {
    return Intl.message('Proof of work',
        name: 'transactionInfosKeyProofOfWork');
  }

  String get transactionInfosKeyProofOfIntegrity {
    return Intl.message('Proof of integrity',
        name: 'transactionInfosKeyProofOfIntegrity');
  }

  String get transactionInfosKeyTimeStamp {
    return Intl.message('Timestamp', name: 'transactionInfosKeyTimeStamp');
  }

  String get transactionInfosKeyCrossValidationStamps {
    return Intl.message('Cross Validation Stamp',
        name: 'transactionInfosKeyCrossValidationStamps');
  }

  String get transactionInfosKeySignature {
    return Intl.message('Signature', name: 'transactionInfosKeySignature');
  }

  String get transactionBuyHeader {
    return Intl.message('Buy UCO here', name: 'transactionBuyHeader');
  }

  String get transactionsAllListHeader {
    return Intl.message('Transactions', name: 'transactionsAllListHeader');
  }

  String get receive {
    return Intl.message('Receive', name: 'receive');
  }

  String get buy {
    return Intl.message('Buy', name: 'buy');
  }

  String get chart {
    return Intl.message('Chart', name: 'chart');
  }

  String get share {
    return Intl.message('Share', name: 'share');
  }

  String get chartOptionLabel14d {
    return Intl.message('14d', name: 'chartOptionLabel14d');
  }

  String get chartOptionLabel1y {
    return Intl.message('1y', name: 'chartOptionLabel1y');
  }

  String get chartOptionLabel200d {
    return Intl.message('200d', name: 'chartOptionLabel200d');
  }

  String get chartOptionLabel30d {
    return Intl.message('30d', name: 'chartOptionLabel30d');
  }

  String get chartOptionLabel60d {
    return Intl.message('60d', name: 'chartOptionLabel60d');
  }

  String get chartOptionLabel7d {
    return Intl.message('7d', name: 'chartOptionLabel7d');
  }

  String get chartOptionLabel24h {
    return Intl.message('24h', name: 'chartOptionLabel24h');
  }

  String get transactionChainExplorerHeader {
    return Intl.message('Transaction Chain Explorer',
        name: 'transactionChainExplorerHeader');
  }

  String get transactionChainExplorerDesc {
    return Intl.message('Explore each transaction stored in your chain',
        name: 'transactionChainExplorerDesc');
  }

  String get transactionChainExplorerLastAddress {
    return Intl.message('Last address',
        name: 'transactionChainExplorerLastAddress');
  }

  String get appAEWebTitle {
    return Intl.message('AEWeb', name: 'appAEWebTitle');
  }

  String get appAEMailTitle {
    return Intl.message('AEMail', name: 'appAEMailTitle');
  }

  String get appAEWalletTitle {
    return Intl.message('AEWallet', name: 'appAEWalletTitle');
  }

  String get appAEStakingTitle {
    return Intl.message('AEStaking', name: 'appAEStakingTitle');
  }

  String get seeAll {
    return Intl.message('See all transactions', name: 'seeAll');
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
