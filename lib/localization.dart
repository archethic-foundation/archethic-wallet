/// SPDX-License-Identifier: AGPL-3.0-or-later

// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:intl/intl.dart';

// Project imports:
import 'package:aewallet/l10n/messages_all.dart';
import 'package:aewallet/model/available_language.dart';

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

  String get noConnectionBanner {
    return Intl.message('No connection', name: 'noConnectionBanner');
  }

  String get welcomeText {
    return Intl.message(
        'Welcome to the empowered\n{Humans; Nature; Apps}\nera of Web3',
        name: 'welcomeText');
  }

  String get welcomeText2 {
    return Intl.message(
        'Archethic gives back to humanity control over technology, and to each individual, control over their identity.',
        name: 'welcomeText2');
  }

  String get welcomeDisclaimerChoice {
    return Intl.message('I have read and agree to the privacy policy',
        name: 'welcomeDisclaimerChoice');
  }

  String get welcomeDisclaimerLink {
    return Intl.message('Terms of use', name: 'welcomeDisclaimerLink');
  }

  String get noData {
    return Intl.message('No data', name: 'noData');
  }

  String get cancel {
    return Intl.message('Cancel', name: 'cancel');
  }

  String get back {
    return Intl.message('Back', name: 'back');
  }

  String get close {
    return Intl.message('Close', name: 'close');
  }

  String get confirm {
    return Intl.message('Confirm', name: 'confirm');
  }

  String get pass {
    return Intl.message('Pass', name: 'pass');
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

  String get previewNotAvailable {
    return Intl.message('Preview not available', name: 'previewNotAvailable');
  }

  String get noToken {
    return Intl.message('No token', name: 'noToken');
  }

  String get noNFT {
    return Intl.message('No NFT', name: 'noNFT');
  }

  String get token {
    return Intl.message('token', name: 'token');
  }

  String get tokens {
    return Intl.message('tokens', name: 'tokens');
  }

  String get nft {
    return Intl.message('NFT', name: 'nft');
  }

  String get transferTokens {
    return Intl.message('Send %1', name: 'transferTokens');
  }

  String get transferToken {
    return Intl.message('Transfer Token', name: 'transferToken');
  }

  String get transferNFT {
    return Intl.message('Transfer NFT', name: 'transferNFT');
  }

  String get transferTokenName {
    return Intl.message('Transfer %1', name: 'transferTokenName');
  }

  String get recentTransactionsHeader {
    return Intl.message('Recent transactions',
        name: 'recentTransactionsHeader');
  }

  String get recentTransactionsNoTransactionYet {
    return Intl.message('No transaction yet',
        name: 'recentTransactionsNoTransactionYet');
  }

  String get keychainCreationTransactionConfirmed1 {
    return Intl.message(
        'Your keychain has been created with %1 confirmation on %2',
        name: 'keychainCreationTransactionConfirmed1');
  }

  String get keychainCreationTransactionConfirmed {
    return Intl.message(
        'Your keychain has been created with %1 confirmations on %2',
        name: 'keychainCreationTransactionConfirmed');
  }

  String get keychainAccessCreationTransactionConfirmed1 {
    return Intl.message(
        'Accesses to your keychain have been created with %1 confirmation on %2',
        name: 'keychainAccessCreationTransactionConfirmed1');
  }

  String get keychainAccessCreationTransactionConfirmed {
    return Intl.message(
        'Accesses to your keychain have been created with %1 confirmations on %2',
        name: 'keychainAccessCreationTransactionConfirmed');
  }

  String get nftCreationTransactionConfirmed1 {
    return Intl.message('Your NFT has been created with %1 confirmation on %2',
        name: 'nftCreationTransactionConfirmed1');
  }

  String get nftCreationTransactionConfirmed {
    return Intl.message('Your NFT has been created with %1 confirmations on %2',
        name: 'nftCreationTransactionConfirmed');
  }

  String get transactionConfirmed1 {
    return Intl.message('Transaction confirmed with %1 replication out of %2',
        name: 'transactionConfirmed1');
  }

  String get transactionConfirmed {
    return Intl.message('Transaction confirmed with %1 replications out of %2',
        name: 'transactionConfirmed');
  }

  String get addTokenConfirmed1 {
    return Intl.message('The token was created with %1 confirmation on %2',
        name: 'addTokenConfirmed1');
  }

  String get addTokenConfirmed {
    return Intl.message('The token was created with %1 confirmations on %2',
        name: 'addTokenConfirmed');
  }

  String get addAccountConfirmed1 {
    return Intl.message('The account was created with %1 confirmation on %2',
        name: 'addAccountConfirmed1');
  }

  String get addAccountConfirmed {
    return Intl.message('The account was created with %1 confirmations on %2',
        name: 'addAccountConfirmed');
  }

  String get transferConfirmed1 {
    return Intl.message('The transfer was created with %1 confirmation on %2',
        name: 'transferConfirmed1');
  }

  String get transferConfirmed {
    return Intl.message('The transfer was created with %1 confirmations on %2',
        name: 'transferConfirmed');
  }

  String get fungiblesTokensListNoTokenYet {
    return Intl.message('No token yet', name: 'fungiblesTokensListNoTokenYet');
  }

  String get addressCopied {
    return Intl.message('Address Copied', name: 'addressCopied');
  }

  String get publicKeyCopied {
    return Intl.message('Public key Copied', name: 'publicKeyCopied');
  }

  String get amountCopied {
    return Intl.message('Amount copied', name: 'amountCopied');
  }

  String get copyAddress {
    return Intl.message('Copy Address', name: 'copyAddress');
  }

  String get addressHint {
    return Intl.message('Enter Address', name: 'addressHint');
  }

  String get publicKeyHint {
    return Intl.message('Enter Public Key', name: 'publicKeyHint');
  }

  String get scanQrCode {
    return Intl.message('Scan QR Code', name: 'scanQrCode');
  }

  String get qrInvalidAddress {
    return Intl.message('QR code doesn\'t contain a valid destination',
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

  String get enterEndpointBlank {
    return Intl.message('The endpoint cannot be empty',
        name: 'enterEndpointBlank');
  }

  String get enterEndpointNotValid {
    return Intl.message('The endpoint is not valid',
        name: 'enterEndpointNotValid');
  }

  String get enterEndpointUseByNetwork {
    return Intl.message('The endpoint is already used by a network',
        name: 'enterEndpointUseByNetwork');
  }

  String get enterEndpointHeader {
    return Intl.message('Please, specify your endpoint',
        name: 'enterEndpointHeader');
  }

  String get enterYubikeyClientID {
    return Intl.message('Enter the client ID', name: 'enterYubikeyClientID');
  }

  String get enterYubikeyClientAPIKey {
    return Intl.message('Enter the client API Key',
        name: 'enterYubikeyClientAPIKey');
  }

  String get enterYubikeyClientIDEmpty {
    return Intl.message('The client ID is mandatory',
        name: 'enterYubikeyClientIDEmpty');
  }

  String get enterYubikeyAPIKeyEmpty {
    return Intl.message('The API Key is mandatory',
        name: 'enterYubikeyAPIKeyEmpty');
  }

  String get yubikeyParamsHeader {
    return Intl.message('Yubikey Params', name: 'yubikeyParamsHeader');
  }

  String get yubikeyParamsDesc {
    return Intl.message('Setting up Yubicloud access',
        name: 'yubikeyParamsDesc');
  }

  String get yubikeyConnectInvite {
    return Intl.message('Please, connect your Yubikey',
        name: 'yubikeyConnectInvite');
  }

  String get yubikeyConnectHoldNearDevice {
    return Intl.message('Hold your device near the Yubikey',
        name: 'yubikeyConnectHoldNearDevice');
  }

  String get contactPublicKeyGetAuto {
    return Intl.message(
        'The public key associated with this address has been recovered: ',
        name: 'contactPublicKeyGetAuto');
  }

  String get removeContact {
    return Intl.message('Remove Contact', name: 'removeContact');
  }

  String get removeContactConfirmation {
    return Intl.message('Are you sure you want to delete %1?',
        name: 'removeContactConfirmation');
  }

  String get contactAddressTabHeader {
    return Intl.message('Address', name: 'contactAddressTabHeader');
  }

  String get contactPublicKeyTabHeader {
    return Intl.message('Public Key', name: 'contactPublicKeyTabHeader');
  }

  String get addressBookHeader {
    return Intl.message('Address book', name: 'addressBookHeader');
  }

  String get viewAddressBook {
    return Intl.message('View my address book', name: 'viewAddressBook');
  }

  String get contactAddressInfoKeychainService {
    return Intl.message(
        'The following QR Code contains the address of your account.\n\nYou can use this address to receive funds or tokens on this account.\n\nTo use it, you can :\n- either scan the QR Code above,\n- or click on it to copy the address.',
        name: 'contactAddressInfoKeychainService');
  }

  String get contactPublicKeyInfoKeychainService {
    return Intl.message(
        'The following QR Code contains the public key of your account.\n\nYou can use this public key\n- to give him access rights to information that you want to protect (specific properties associated with NFTs, messages, ...).\n- to verify the authenticity of an information by checking that it comes from this account.\n\nTo use it, you can\n- either scan the QR Code above,\n- or click on it to copy the public key.',
        name: 'contactPublicKeyInfoKeychainService');
  }

  String get contactAddressInfoExternalContact {
    return Intl.message(
        'The following QR Code contains the address of your contact.\n\nYou can use this address to send funds or tokens to your contact.\n\nTo use it, you can :\n- either scan the QR Code above,\n- or click on it to copy the address.',
        name: 'contactAddressInfoExternalContact');
  }

  String get contactPublicKeyInfoExternalContact {
    return Intl.message(
        'The following QR Code contains the public key of your contact.\n\nYou can use this public key\n- to give him access rights to information that you want to protect (specific properties associated with NFTs, messages, ...).\n- to verify the authenticity of an information by checking that it comes from this contact.\n\nTo use it, you can\n- either scan the QR Code above,\n- or click on it to copy the public key.',
        name: 'contactPublicKeyInfoExternalContact');
  }

  String get contactPublicKeyInfoWarning {
    return Intl.message(
        'Don\'t use this information to receive funds or tokens!',
        name: 'contactPublicKeyInfoWarning');
  }

  String get contactHeader {
    return Intl.message('Contact', name: 'contactHeader');
  }

  String get addressBookDesc {
    return Intl.message('Create and manage frequently-used addresses',
        name: 'addressBookDesc');
  }

  String get addContactDescription {
    return Intl.message(
        'To create a contact, you must specify a name and address.\n\nConcerning the address, it allows to send funds or tokens to your contact. You can either type it, copy and paste it or get it from a QR Code.\n\nThe public key is automatically retrieved unless your contact has never made a transaction on the Archethic network. In this case, you just have to ask him/her and either enter it, copy and paste it or retrieve it from a QR Code.\nThe public key allows you to give your contact access rights to information that you want to protect (specific properties associated with NFTs, messages, ...).or to verify the authenticity of an information by checking that it comes from this contact.',
        name: 'addContactDescription');
  }

  String get addContact {
    return Intl.message('Add Contact', name: 'addContact');
  }

  String get contactNameHint {
    return Intl.message('Enter a Name', name: 'contactNameHint');
  }

  String get contactInvalid {
    return Intl.message('Invalid Contact Name', name: 'contactInvalid');
  }

  String get messageInvalid {
    return Intl.message(
        'Your message cannot contain (for the moment) special characters',
        name: 'messageInvalid');
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

  String get contactExistsName {
    return Intl.message('You already have a contact with this name',
        name: 'contactExistsName');
  }

  String get contactExistsAddress {
    return Intl.message('You already have a contact with this address',
        name: 'contactExistsAddress');
  }

  String get contactPublicKeyNotFound {
    return Intl.message(
        'No public key was found automatically. Please ask your contact for it.',
        name: 'contactPublicKeyNotFound');
  }

  String get transferSuccess {
    return Intl.message('The transaction was sent successfully',
        name: 'transferSuccess');
  }

  String get transfering {
    return Intl.message('Transfering', name: 'transfering');
  }

  String get sendMessageHeader {
    return Intl.message('Message', name: 'sendMessageHeader');
  }

  String get sendMessageConfirmHeader {
    return Intl.message('Your message :', name: 'sendMessageConfirmHeader');
  }

  String get messageInTxTransfer {
    return Intl.message('See the message attached...',
        name: 'messageInTxTransfer');
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
    return Intl.message('The request ID doesn\'t exist.',
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

  String get enterPublicKey {
    return Intl.message('Enter Public Key', name: 'enterPublicKey');
  }

  String get userCancelledOperation {
    return Intl.message('User cancelled operation',
        name: 'userCancelledOperation');
  }

  String get transactionConfirmationFormHeader {
    return Intl.message('Transaction send confirmation',
        name: 'transactionConfirmationFormHeader');
  }

  String get unknownAccount {
    return Intl.message('Account %1 does not exist.', name: 'unknownAccount');
  }

  String get invalidTransaction {
    return Intl.message('Transaction is invalid', name: 'invalidTransaction');
  }

  String get invalidAddress {
    return Intl.message('Address entered is invalid', name: 'invalidAddress');
  }

  String get invalidPasteAddress {
    return Intl.message('The address you want to paste is not valid.',
        name: 'invalidPasteAddress');
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

  String get amountZero {
    return Intl.message('Your amount should be > 0', name: 'amountZero');
  }

  String get maxSendRecipientMissing {
    return Intl.message('Please, enter the recipient to define the max amount.',
        name: 'maxSendRecipientMissing');
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
    return Intl.message('Total :', name: 'total');
  }

  String get availableAfterTransfer {
    return Intl.message('Available after transfer :',
        name: 'availableAfterTransfer');
  }

  String get availableAfterCreation {
    return Intl.message('Available after creation :',
        name: 'availableAfterCreation');
  }

  String get availableAfterMint {
    return Intl.message('Available after mint :', name: 'availableAfterMint');
  }

  String get estimatedFeesNoteNFT {
    return Intl.message(
        'Note : The fees will be estimated when the address is specified.',
        name: 'estimatedFeesNoteNFT');
  }

  String get estimatedFeesNote {
    return Intl.message(
        'Note : The fees will be estimated when the address and the amount are specified.',
        name: 'estimatedFeesNote');
  }

  String get estimatedFeesCalculationNote {
    return Intl.message('Fees are being calculated',
        name: 'estimatedFeesCalculationNote');
  }

  String get estimatedFeesAddTokenNote {
    return Intl.message(
        'Note : The fees will be estimated when the name and the initial supply are specified.',
        name: 'estimatedFeesAddTokenNote');
  }

  String get estimatedFeesAddNFTNote {
    return Intl.message('Fees will be estimated when the NFT is defined.',
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

  String get passwordMethod {
    return Intl.message('Password', name: 'passwordMethod');
  }

  String get biometricsUnirisMethod {
    return Intl.message('Uniris Biometrics (Soon...)',
        name: 'biometricsUnirisMethod');
  }

  String get currency {
    return Intl.message('Currency', name: 'currency');
  }

  String get currencyOracleInfo {
    return Intl.message(
        'This icon means that the conversion will use an oracle provided by Archethic.',
        name: 'currencyOracleInfo');
  }

  String get nftAddPhotoFormatInfo {
    return Intl.message('The accepted formats are: JPG, PNG, GIF, WEBP, BMP.',
        name: 'nftAddPhotoFormatInfo');
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

  String get primaryCurrency {
    return Intl.message('Primary currency', name: 'primaryCurrency');
  }

  String get removeWallet {
    return Intl.message('Remove Wallet from this device', name: 'removeWallet');
  }

  String get removeWalletDescription {
    return Intl.message('You can find it at any time with your secret phrase',
        name: 'removeWalletDescription');
  }

  String get resyncWallet {
    return Intl.message('Resynchronize Wallet', name: 'resyncWallet');
  }

  String get resyncWalletAreYouSure {
    return Intl.message(
        'Are you sure you want to clear your cache and reload the information from the blockchain?\n\nThis action takes a few seconds and is safe because it only reloads your recent transactions.',
        name: 'resyncWalletAreYouSure');
  }

  String get resyncWalletDescription {
    return Intl.message(
        'Empty the cache and reload informations from the blockchain',
        name: 'resyncWalletDescription');
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
        'You are about to remove all Archethic-related data from this device. If your secret phrase is not backed up, you will never be able to access your wallet again',
        name: 'removeWalletDetail');
  }

  String get removeWalletAction {
    return Intl.message('Delete', name: 'removeWalletAction');
  }

  String get areYouSure {
    return Intl.message('Are you sure?', name: 'areYouSure');
  }

  String get removeWalletReassurance {
    return Intl.message(
        'As long as you\'ve backed up your seed you have nothing to worry about.',
        name: 'removeWalletReassurance');
  }

  String get passBackupConfirmationDisclaimer {
    return Intl.message('DISCLAIMER', name: 'passBackupConfirmationDisclaimer');
  }

  String get passBackupConfirmationMessage {
    return Intl.message(
        'We invite you to manually confirm the registration of your recovery phrase. In case of loss, you will lose your funds.',
        name: 'passBackupConfirmationMessage');
  }

  String get archethicDoesntKeepCopy {
    return Intl.message('As a reminder, Archethic doesn\'t keep any copy.',
        name: 'archethicDoesntKeepCopy');
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
    return Intl.message('Too many failed unlock attempts.\nPlease, try again',
        name: 'tooManyFailedAttempts');
  }

  String get attempt {
    return Intl.message('Attempt: ', name: 'attempt');
  }

  String get securityHeader {
    return Intl.message('Security', name: 'securityHeader');
  }

  String get customHeader {
    return Intl.message('Customization', name: 'customHeader');
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
    return Intl.message('Archethic Website', name: 'aeWebsiteLinkHeader');
  }

  String get aeWebsiteLinkDesc {
    return Intl.message('Visit the Archethic website',
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

  String get tapToReveal {
    return Intl.message('Tap to reveal', name: 'tapToReveal');
  }

  String get tapToHide {
    return Intl.message('Tap to hide', name: 'tapToHide');
  }

  String get pinPadShuffle {
    return Intl.message('PIN Pad Shuffle', name: 'pinPadShuffle');
  }

  String get showBalances {
    return Intl.message('Show balances', name: 'showBalances');
  }

  String get showBlog {
    return Intl.message('Show blog', name: 'showBlog');
  }

  String get activateVibrations {
    return Intl.message('Activate vibrations', name: 'activateVibrations');
  }

  String get activateNotifications {
    return Intl.message('Activate notifications',
        name: 'activateNotifications');
  }

  String get transactionSignatureCommandReceivedNotification {
    return Intl.message('Application %1 wants to send a transaction.',
        name: 'transactionSignatureCommandReceivedNotification');
  }

  String get addServiceCommandReceivedNotification {
    return Intl.message('Application %1 wants to add a service.',
        name: 'addServiceCommandReceivedNotification');
  }

  String get transactionInputNotification {
    return Intl.message('You have received %1 %2 on your %3 account',
        name: 'transactionInputNotification');
  }

  String get showPriceChart {
    return Intl.message('Show price chart', name: 'showPriceChart');
  }

  String get copy {
    return Intl.message('Copy', name: 'copy');
  }

  String get viewExplorer {
    return Intl.message('View on explorer', name: 'viewExplorer');
  }

  String get confirmSecretPhraseExplanation {
    return Intl.message('Select the words to put them in the correct order.',
        name: 'confirmSecretPhraseExplanation');
  }

  String get confirmSecretPhraseKo {
    return Intl.message('The order is not correct.',
        name: 'confirmSecretPhraseKo');
  }

  String get importSecretPhrase {
    return Intl.message('Import Secret Phrase', name: 'importSecretPhrase');
  }

  String get importSecretPhraseHint {
    return Intl.message('Please enter your 24-word secret phrase below.',
        name: 'importSecretPhraseHint');
  }

  String get qrMnemonicError {
    return Intl.message('QR doesn\'t contain a valid secret phrase',
        name: 'qrMnemonicError');
  }

  String get mnemonicInvalidWord {
    return Intl.message('%1 is not a valid word', name: 'mnemonicInvalidWord');
  }

  String get mnemonicSizeError {
    return Intl.message('Secret phrase may only contain 24 words',
        name: 'mnemonicSizeError');
  }

  String get noKeychain {
    return Intl.message('No keychain exists with this secret phrase.',
        name: 'noKeychain');
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

  String get confirmSecretPhrase {
    return Intl.message('Confirm your secret phrase.',
        name: 'confirmSecretPhrase');
  }

  String get backupSecretPhrase {
    return Intl.message('Backup Secret Phrase', name: 'backupSecretPhrase');
  }

  String get configureSecurityIntro {
    return Intl.message('It\'s important to protect the access to your wallet!',
        name: 'configureSecurityIntro');
  }

  String get seYubicloudHeader {
    return Intl.message(
        'Please, precise your client identity and client API key.',
        name: 'seYubicloudHeader');
  }

  String get seYubicloudConfirmHeader {
    return Intl.message(
        'Please, confirm your client identity and client API key.',
        name: 'seYubicloudConfirmHeader');
  }

  String get seYubicloudDescription {
    return Intl.message(
        'To use the Yubico OTP with your Yubikey, you need to get an API key from https://upgrade.yubico.com/getapikey. It\'s quick and free.\n\nAfter that, you can precise the given client identity and the client API key',
        name: 'seYubicloudDescription');
  }

  String get configureSecurityExplanation {
    return Intl.message(
        'To access to this application or to validate important manipulations, we offer several ways to protect yourself.',
        name: 'configureSecurityExplanation');
  }

  String get configureSecurityExplanationPIN {
    return Intl.message(
        'A personal identification number (PIN) is a numeric passcode used in the process of authenticating a user accessing a system.',
        name: 'configureSecurityExplanationPIN');
  }

  String get configureSecurityExplanationPassword {
    return Intl.message(
        'A password is a string of characters used to verify the identity of a user during the authentication process. Avoid words that are too easy to find (date of birth, first name of your children, etc...)',
        name: 'configureSecurityExplanationPassword');
  }

  String get configureSecurityExplanationYubikey {
    return Intl.message(
        'The YubiKey is a device that makes two-factor authentication as simple as possible. Instead of a code being texted to you, or generated by an app on your phone, you press a button on your YubiKey.',
        name: 'configureSecurityExplanationYubikey');
  }

  String get configureSecurityExplanationBiometrics {
    return Intl.message(
        'It\'s a method of biometric identification that uses that body measures, in this case face and head, to verify the identity of a person through its facial biometric pattern and data.',
        name: 'configureSecurityExplanationBiometrics');
  }

  String get configureSecurityExplanationUnirisBiometrics {
    return Intl.message(
        'Embedded in the blockchain, the biometric technology provided by Uniris allows anyone to identify themselves without difficulty and without storing any biometric data. This is an access control that is forgery-proof and without disclosure.',
        name: 'configureSecurityExplanationUnirisBiometrics');
  }

  String get createPasswordHint {
    return Intl.message('Create a password', name: 'createPasswordHint');
  }

  String get confirmPasswordHint {
    return Intl.message('Confirm the password', name: 'confirmPasswordHint');
  }

  String get enterPasswordHint {
    return Intl.message('Enter your password', name: 'enterPasswordHint');
  }

  String get passwordsDontMatch {
    return Intl.message('Passwords do not match', name: 'passwordsDontMatch');
  }

  String get passwordBlank {
    return Intl.message('Password cannot be empty', name: 'passwordBlank');
  }

  String get invalidPassword {
    return Intl.message('Invalid Password', name: 'invalidPassword');
  }

  String get passwordStrengthWeak {
    return Intl.message('Your password is weak.', name: 'passwordStrengthWeak');
  }

  String get passwordStrengthAlright {
    return Intl.message('Your password is alright.',
        name: 'passwordStrengthAlright');
  }

  String get passwordStrengthStrong {
    return Intl.message('Your password is strong.',
        name: 'passwordStrengthStrong');
  }

  String get ok {
    return Intl.message('OK', name: 'ok');
  }

  String get addressInfos {
    return Intl.message('My public address to receive funds',
        name: 'addressInfos');
  }

  String get informations {
    return Intl.message('Informations', name: 'informations');
  }

  String get updateAvailableTitle {
    return Intl.message('App Update', name: 'updateAvailableTitle');
  }

  String get updateAvailableDesc {
    return Intl.message(
        'A new version (%1) is available.\n\nPlease update the app.',
        name: 'updateAvailableDesc');
  }

  String get nodesHeader {
    return Intl.message('Nodes', name: 'nodesHeader');
  }

  String get nodesHeaderDesc {
    return Intl.message('Nodes informations', name: 'nodesHeaderDesc');
  }

  String get priceChartHeader {
    return Intl.message('Price Chart', name: 'priceChartHeader');
  }

  String get blogHeader {
    return Intl.message('Archethic Blog', name: 'blogHeader');
  }

  String get createToken {
    return Intl.message('Create Token', name: 'createToken');
  }

  String get addTokenConfirmationMessage {
    return Intl.message('Do you confirm the creation of the following Token?',
        name: 'addTokenConfirmationMessage');
  }

  String get addAccountConfirmationMessage {
    return Intl.message('Do you confirm the creation of the following Account?',
        name: 'addAccountConfirmationMessage');
  }

  String get searchNFTHint {
    return Intl.message('Search for a NFT\nfrom an address.',
        name: 'searchNFTHint');
  }

  String get nftNotFound {
    return Intl.message('The NFT was not found.', name: 'nftNotFound');
  }

  String get createNFTConfirmationMessage {
    return Intl.message('Do you confirm the mint of the following NFT?',
        name: 'createNFTConfirmationMessage');
  }

  String get tokensHeader {
    return Intl.message('Tokens', name: 'tokensHeader');
  }

  String get tokenHeaderDesc {
    return Intl.message('Manage your tokens', name: 'tokenHeaderDesc');
  }

  String get tokenNameHint {
    return Intl.message('Enter a name', name: 'tokenNameHint');
  }

  String get tokenName {
    return Intl.message('Name :', name: 'tokenName');
  }

  String get tokenSymbol {
    return Intl.message('Symbol :', name: 'tokenSymbol');
  }

  String get tokenSymbolMaxNumberCharacter {
    return Intl.message('4 characters maximum',
        name: 'tokenSymbolMaxNumberCharacter');
  }

  String get tokenSymbolHint {
    return Intl.message('Enter a symbol', name: 'tokenSymbolHint');
  }

  String get tokenInitialSupplyHint {
    return Intl.message('Enter an initial supply',
        name: 'tokenInitialSupplyHint');
  }

  String get nftInitialSupplyHint {
    return Intl.message('Enter a quantity', name: 'nftInitialSupplyHint');
  }

  String get tokenNameMissing {
    return Intl.message('Choose a Name for the Token',
        name: 'tokenNameMissing');
  }

  String get tokenNameUCO {
    return Intl.message(
        'Unfortunately, we have already taken this name of token.',
        name: 'tokenNameUCO');
  }

  String get tokenSymbolUCO {
    return Intl.message(
        'Unfortunately, we have already taken this name of symbol.',
        name: 'tokenSymbolUCO');
  }

  String get notOfficialUCOWarning {
    return Intl.message('This is not the official UCO token.',
        name: 'notOfficialUCOWarning');
  }

  String get tokenSymbolMissing {
    return Intl.message('Choose a Symbol for the Token',
        name: 'tokenSymbolMissing');
  }

  String get tokenInitialSupply {
    return Intl.message('Initial supply :', name: 'tokenInitialSupply');
  }

  String get tokenSupply {
    return Intl.message('Supply :', name: 'tokenSupply');
  }

  String get tokenInitialSupplyMissing {
    return Intl.message('Choose an initial supply for the Token',
        name: 'tokenInitialSupplyMissing');
  }

  String get tokenInitialSupplyPositive {
    return Intl.message('The initial supply should be > 0',
        name: 'tokenInitialSupplyPositive');
  }

  String get tokenInitialSupplyTooHigh {
    return Intl.message('The initial supply is too high',
        name: 'tokenInitialSupplyTooHigh');
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
    return Intl.message('To :', name: 'txListTo');
  }

  String get txListFees {
    return Intl.message('Fees :', name: 'txListFees');
  }

  String get txListTypeTransactionLabelNewToken {
    return Intl.message('New Token',
        name: 'txListTypeTransactionLabelNewToken');
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

  String get recoveryPhraseIntroExplanation {
    return Intl.message(
        'Here is the list of 24 words to remember. The following screen will prompt you to find them in order to help you verify that you have written them down correctly.\n\nThis list will also be available in your wallet in the "Security" menu.',
        name: 'recoveryPhraseIntroExplanation');
  }

  String get dipslayPhraseExplanation {
    return Intl.message(
        'Here is the list of 24 words to remember. This list allows you to find your funds at any time if you lose your application or device.\nDo not give it to anyone! Even in the context of a support. \nArchethic will never ask you for this information.',
        name: 'dipslayPhraseExplanation');
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
    return Intl.message('Insecure ways of backup :',
        name: 'backupSafetyLabel6');
  }

  String get backupSafetyLabel7 {
    return Intl.message('1. Screenshot\n2. Take a photo',
        name: 'backupSafetyLabel7');
  }

  String get go {
    return Intl.message('Go!', name: 'go');
  }

  String get tokenCreated {
    return Intl.message('Token created :', name: 'tokenCreated');
  }

  String get nftCreated {
    return Intl.message('NFT created :', name: 'nftCreated');
  }

  String get nextButton {
    return Intl.message('Next >', name: 'nextButton');
  }

  String get previousButton {
    return Intl.message('< Previous', name: 'previousButton');
  }

  String get version {
    return Intl.message('Version :', name: 'version');
  }

  String get build {
    return Intl.message('Build :', name: 'build');
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

  String get transactionInfosKeyTokenLedger {
    return Intl.message('Token Ledger', name: 'transactionInfosKeyTokenLedger');
  }

  String get transactionInfosKeyToken {
    return Intl.message('Token', name: 'transactionInfosKeyToken');
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

  String get addPublicKeyHeader {
    return Intl.message('Add access', name: 'addPublicKeyHeader');
  }

  String get getPublicKeyHeader {
    return Intl.message('Access', name: 'getPublicKeyHeader');
  }

  String get customizeCategoryListHeader {
    return Intl.message('Customize categories',
        name: 'customizeCategoryListHeader');
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

  String get chartOptionLabel1h {
    return Intl.message('1h', name: 'chartOptionLabel1h');
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

  String get chartOptionLabelAll {
    return Intl.message('All', name: 'chartOptionLabelAll');
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

  String get seeAll {
    return Intl.message('See all transactions', name: 'seeAll');
  }

  String get setPasswordHeader {
    return Intl.message('Please, create a password.',
        name: 'setPasswordHeader');
  }

  String get setPasswordDescription {
    return Intl.message(
        'In order to protect your account, make sure your password:',
        name: 'setPasswordDescription');
  }

  String get introNewWalletGetFirstInfosWelcome {
    return Intl.message('Welcome to Archethic Wallet.',
        name: 'introNewWalletGetFirstInfosWelcome');
  }

  String get introNewWalletGetFirstInfosNameRequest {
    return Intl.message(
        'What name would you like to give to this account, which account will be stored in your decentralized keychain?',
        name: 'introNewWalletGetFirstInfosNameRequest');
  }

  String get introNewWalletGetFirstInfosNameInfos {
    return Intl.message(
        'It will allow you to distinguish this account from other accounts that you can, if you want, create later.\n\nWARNING : This name will be added to your decentralized keychain and cannot be modified.',
        name: 'introNewWalletGetFirstInfosNameInfos');
  }

  String get introNewWalletGetFirstInfosNameBlank {
    return Intl.message('Please enter a name for this account',
        name: 'introNewWalletGetFirstInfosNameBlank');
  }

  String get introNewWalletGetFirstInfosNameCharacterNonValid {
    return Intl.message('The name cannot contain "\\" and space characters',
        name: 'introNewWalletGetFirstInfosNameCharacterNonValid');
  }

  String get addAccountExists {
    return Intl.message('This name already exists in your keychain.',
        name: 'addAccountExists');
  }

  String get introNewWalletGetFirstInfosNetworkHeader {
    return Intl.message('On which network do you want to use your wallet?',
        name: 'introNewWalletGetFirstInfosNetworkHeader');
  }

  String get introNewWalletGetFirstInfosNetworkChoice {
    return Intl.message('Current network :',
        name: 'introNewWalletGetFirstInfosNetworkChoice');
  }

  String get accountHeader {
    return Intl.message('Account', name: 'accountHeader');
  }

  String get keychainHeader {
    return Intl.message('Keychain', name: 'keychainHeader');
  }

  String get accountsKeychainAddressHeader {
    return Intl.message('Your keychain\'s address',
        name: 'accountsKeychainAddressHeader');
  }

  String get accountsListDescription {
    return Intl.message(
        'Your keychain contains the following services and accounts.',
        name: 'accountsListDescription');
  }

  String get newAccount {
    return Intl.message('New account', name: 'newAccount');
  }

  String get addAccount {
    return Intl.message('Add account', name: 'addAccount');
  }

  String get newAccountConfirmation {
    return Intl.message(
        'Are you sure you want to create in your keychain "%1?"',
        name: 'newAccountConfirmation');
  }

  String get addAccountConfirmation {
    return Intl.message('Are you sure you want to add in your keychain "%1?"',
        name: 'addAccountConfirmation');
  }

  String get selectAccountDescOne {
    return Intl.message(
        'Your keychain contains one account. You will be able to create other accounts at any time.',
        name: 'selectAccountDescOne');
  }

  String get selectAccountDescSeveral {
    return Intl.message(
        'Your keychain contains several accounts. Which account do you want to manage first in your app? You will be able to create or select other accounts at any time.',
        name: 'selectAccountDescSeveral');
  }

  String get searchField {
    return Intl.message("Search...", name: 'searchField');
  }

  String get search {
    return Intl.message("Search", name: 'search');
  }

  String get pleaseWait {
    return Intl.message("Please wait", name: 'pleaseWait');
  }

  String get appWalletInitInProgress {
    return Intl.message("Your wallet is being configured...",
        name: 'appWalletInitInProgress');
  }

  String get createFungibleToken {
    return Intl.message('Create a token', name: 'createFungibleToken');
  }

  String get createNFT {
    return Intl.message('Create a NFT', name: 'createNFT');
  }

  String get createTheNFT {
    return Intl.message('Create the NFT', name: 'createTheNFT');
  }

  String get nftListEmptyExplanation {
    return Intl.message(
        'This is where you will find your NFTs related to this category. \nUnfortunately, for the moment, no NFTs are stored in this category, but you can create them by going to the "Create a NFT" function below.',
        name: 'nftListEmptyExplanation');
  }

  String get nftTabDescriptionHeader {
    return Intl.message(
        'This space allows you to access your NFTs or to create them directly from images, photos or pdf documents. You can also transfer them to any address.',
        name: 'nftTabDescriptionHeader');
  }

  String get addNFTFile {
    return Intl.message('Add a NFT', name: 'addNFTFile');
  }

  String get addNFTProperty {
    return Intl.message('Add property', name: 'addNFTProperty');
  }

  String get addNftNewCategory {
    return Intl.message('Add new category (Soon...)',
        name: 'addNftNewCategory');
  }

  String get property {
    return Intl.message('property', name: 'property');
  }

  String get properties {
    return Intl.message('properties', name: 'properties');
  }

  String get noProperty {
    return Intl.message('No property', name: 'noProperty');
  }

  String get availableCategories {
    return Intl.message('Available categories', name: 'availableCategories');
  }

  String get hiddenCategories {
    return Intl.message('Hidden categories', name: 'hiddenCategories');
  }

  String get nftNameHint {
    return Intl.message('Enter the name of the NFT', name: 'nftNameHint');
  }

  String get publicKeyAddHint {
    return Intl.message('Enter a public key', name: 'publicKeyAddHint');
  }

  String get nftDescriptionHint {
    return Intl.message('Enter a description', name: 'nftDescriptionHint');
  }

  String get nftPropertyNameHint {
    return Intl.message('Enter the name of the prop.',
        name: 'nftPropertyNameHint');
  }

  String get nftPropertyValueHint {
    return Intl.message('Enter a value', name: 'nftPropertyValueHint');
  }

  String get nftAddStep1 {
    return Intl.message('1) Import from', name: 'nftAddStep1');
  }

  String get nftAddStep2 {
    return Intl.message('2) Enter information', name: 'nftAddStep2');
  }

  String get nftAddStep3 {
    return Intl.message('3) Add properties (optional)', name: 'nftAddStep3');
  }

  String get nftAddImportFile {
    return Intl.message('File', name: 'nftAddImportFile');
  }

  String get nftAddImportPhoto {
    return Intl.message('Photo', name: 'nftAddImportPhoto');
  }

  String get nftAddImportCamera {
    return Intl.message('Take a photo', name: 'nftAddImportCamera');
  }

  String get nftAddImportUrl {
    return Intl.message('Url', name: 'nftAddImportUrl');
  }

  String get nftAddPreview {
    return Intl.message('Your NFT (Preview)', name: 'nftAddPreview');
  }

  String get nftAddFileSize {
    return Intl.message('Size: ', name: 'nftAddFileSize');
  }

  String get nftCategoryChangeCategory {
    return Intl.message('Move to a new category...',
        name: 'nftCategoryChangeCategory');
  }

  String get nftWithoutCategory {
    return Intl.message('Without category', name: 'nftWithoutCategory');
  }

  String get nftCategory {
    return Intl.message('Category', name: 'nftCategory');
  }

  String get nftCategoryArt {
    return Intl.message('Art', name: 'nftCategoryArt');
  }

  String get nftCategoryAccess {
    return Intl.message('Access', name: 'nftCategoryAccess');
  }

  String get nftCategoryDoc {
    return Intl.message('Doc', name: 'nftCategoryDoc');
  }

  String get nftCategoryCollectibles {
    return Intl.message('Collectibles', name: 'nftCategoryCollectibles');
  }

  String get nftCategoryMusic {
    return Intl.message('Music', name: 'nftCategoryMusic');
  }

  String get nftCategoryPhoto {
    return Intl.message('Photo', name: 'nftCategoryPhoto');
  }

  String get nftCategoryLoyaltyCard {
    return Intl.message('Loyalty Cards', name: 'nftCategoryLoyaltyCard');
  }

  String get conversionOraclePromotion {
    return Intl.message('(Conversion provided by Archethic Oracles)',
        name: 'conversionOraclePromotion');
  }

  String get nftCreationProcessTabImportHeader {
    return Intl.message('Import', name: 'nftCreationProcessTabImportHeader');
  }

  String get nftCreationProcessTabDescriptionHeader {
    return Intl.message('Description',
        name: 'nftCreationProcessTabDescriptionHeader');
  }

  String get nftCreationProcessTabPropertiesHeader {
    return Intl.message('Properties',
        name: 'nftCreationProcessTabPropertiesHeader');
  }

  String get nftCreationProcessTabSummaryHeader {
    return Intl.message('Summary', name: 'nftCreationProcessTabSummaryHeader');
  }

  String get createNFTConfirmation {
    return Intl.message('Are you sure you want to create this NFT?',
        name: 'createNFTConfirmation');
  }

  String get nftPropertiesRequiredByCategory {
    return Intl.message('Properties required by the category:',
        name: 'nftPropertiesRequiredByCategory');
  }

  String get nftAssetProtected1PublicKey {
    return Intl.message(
        'This asset is protected and accessible by 1 public key',
        name: 'nftAssetProtected1PublicKey');
  }

  String get nftAssetProtectedPublicKeys {
    return Intl.message(
        'This asset is protected and accessible by %1 public keys',
        name: 'nftAssetProtectedPublicKeys');
  }

  String get nftAssetNotProtected {
    return Intl.message('This asset is accessible by everyone',
        name: 'nftAssetNotProtected');
  }

  String get nftPropertyProtected1PublicKey {
    return Intl.message(
        'This property is protected and accessible by 1 public key',
        name: 'nftPropertyProtected1PublicKey');
  }

  String get nftPropertyProtectedPublicKeys {
    return Intl.message(
        'This property is protected and accessible by %1 public keys',
        name: 'nftPropertyProtectedPublicKeys');
  }

  String get nftPropertyNotProtected {
    return Intl.message('This property is accessible by everyone',
        name: 'nftPropertyNotProtected');
  }

  String get propertyAccessDescription {
    return Intl.message(
        'Add or remove public keys that can access this property.',
        name: 'propertyAccessDescription');
  }

  String get propertyAccessDescriptionReadOnly {
    return Intl.message(
        'The following list contains the public keys that can access this element.',
        name: 'propertyAccessDescriptionReadOnly');
  }

  String get propertyAccessAddAccess {
    return Intl.message('Add access', name: 'propertyAccessAddAccess');
  }

  String get nftInfosDescription {
    return Intl.message(
        'Add to your NFT a name and a human readable description.',
        name: 'nftInfosDescription');
  }

  String get nftInfosWarning {
    return Intl.message('Limitation of this wallet application version',
        name: 'nftInfosWarning');
  }

  String get nftInfosWarningDesc {
    return Intl.message(
        'Except for the properties that you voluntarily choose to protect access to, the information in the NFT that you are going to create will be PUBLIC information, therefore accessible to everyone.\nDo not create an NFT with sensitive or personal data that you do not wish to disclose.\nThe protection of images or documents is a mechanism already proposed by the Archethic blockchain, will be also proposed in a future release of the wallet application.',
        name: 'nftInfosWarningDesc');
  }

  String get nftInfosCreationConfirmationWarning {
    return Intl.message(
        'I declare that I am aware that the content of my NFT will be PUBLIC, except for properties specifically set up as protected.',
        name: 'nftInfosCreationConfirmationWarning');
  }

  String get nftInfosImportWarning {
    return Intl.message(
        'Before importing, please remove the metadata (EXIF) from your images or documents if you don\'t want them to be public.',
        name: 'nftInfosImportWarning');
  }

  String get nftPropertyNameEmpty {
    return Intl.message('Please, enter a name.', name: 'nftPropertyNameEmpty');
  }

  String get nftPropertyValueEmpty {
    return Intl.message('Please, enter a value.',
        name: 'nftPropertyValueEmpty');
  }

  String get nftPropertyExists {
    return Intl.message('This property already exists',
        name: 'nftPropertyExists');
  }

  String get publicKeyAccessExists {
    return Intl.message('This access already exists',
        name: 'publicKeyAccessExists');
  }

  String get publicKeyInvalid {
    return Intl.message('The public key is not valid',
        name: 'publicKeyInvalid');
  }

  String get nftAddConfirmationFileEmpty {
    return Intl.message('Veuillez importer un fichier ou une photo.',
        name: 'nftAddConfirmationFileEmpty');
  }

  String get nftNameEmpty {
    return Intl.message('Please, enter a name for the NFT.',
        name: 'nftNameEmpty');
  }

  String get nftFormatNotSupportedEmpty {
    return Intl.message("The format is not supported.",
        name: 'nftFormatNotSupportedEmpty');
  }

  String get nftSizeExceed {
    return Intl.message('The NFT cannot exceed 2.5 MB.', name: 'nftSizeExceed');
  }

  String get nftCategoryDescriptionHeader0 {
    return Intl.message(
        'Import a photo, a document, a piece of information, or any other element that you wish to transform into a non-fungible token.',
        name: 'nftCategoryDescriptionHeader0');
  }

  String get nftCategoryDescriptionHeader1 {
    return Intl.message('Import a photo, an image.',
        name: 'nftCategoryDescriptionHeader1');
  }

  String get nftCategoryDescriptionHeader2 {
    return Intl.message('Import a ticket to access an event or a location.',
        name: 'nftCategoryDescriptionHeader2');
  }

  String get nftCategoryDescriptionHeader3 {
    return Intl.message('Create your collections.',
        name: 'nftCategoryDescriptionHeader3');
  }

  String get nftCategoryDescriptionHeader4 {
    return Intl.message('Import a piece of music or a recording.',
        name: 'nftCategoryDescriptionHeader4');
  }

  String get nftCategoryDescriptionHeader5 {
    return Intl.message('Import a document PDF.',
        name: 'nftCategoryDescriptionHeader5');
  }

  String get nftCategoryDescriptionHeader6 {
    return Intl.message('Import a loyalty card',
        name: 'nftCategoryDescriptionHeader6');
  }

  String get nftCategoryDescriptionHeaderDefault {
    return Intl.message(
        'Import a photo, a document, a piece of information, or any other element that you wish to transform into a non-fungible token.',
        name: 'nftCategoryDescriptionHeaderDefault');
  }

  String get nftPropertyExplanation {
    return Intl.message(
        'You can add additional properties to define, characterize or specify the use of your NFT. Name and value are free.\n\nExamples : name=\"strength\", valeur=\"30\", nom=\"color\", valeur=\"green\", nom=\"year\", valeur=\"2012\".',
        name: 'nftPropertyExplanation');
  }

  String get publicKeyNotValid {
    return Intl.message('The public key is not valid.',
        name: 'publicKeyNotValid');
  }

  String get deleteFile {
    return Intl.message('Delete file', name: 'deleteFile');
  }

  String get removePublicKey {
    return Intl.message('Remove public key', name: 'removePublicKey');
  }

  String get deleteProperty {
    return Intl.message('Delete property', name: 'deleteProperty');
  }

  String get formatLabel {
    return Intl.message('Format: ', name: 'formatLabel');
  }

  String get notEnoughConfirmations {
    return Intl.message(
        'The application could not be completed due to lack of consensus',
        name: 'notEnoughConfirmations');
  }

  String get keychainNotExistWarning {
    return Intl.message('Keychain doesn\'t exist.',
        name: 'keychainNotExistWarning');
  }

  String get consensusNotReached {
    return Intl.message(
        'The consensus is not reached. Please retry your request...',
        name: 'consensusNotReached');
  }

  String get transactionTimeOut {
    return Intl.message(
        'The transaction encountered a timeout issue. Please retry your request...',
        name: 'transactionTimeOut');
  }

  String get genericError {
    return Intl.message(
        'We\'re sorry, but an error has occurred. Please retry your request...',
        name: 'genericError');
  }

  String get noConnection {
    return Intl.message(
        'The connection to the network could not be completed. Please check your network settings.',
        name: 'noConnection');
  }

  String get connectivityWarningHeader {
    return Intl.message('Check your internet connection.',
        name: 'connectivityWarningHeader');
  }

  String get connectivityWarningDesc {
    return Intl.message(
        'You can use the application when your connection is interrupted, but the information may be outdated and some features are disabled.',
        name: 'connectivityWarningDesc');
  }

  String get aewebHosting {
    return Intl.message('AEWeb hosting', name: 'aewebHosting');
  }

  String get serviceTypeLabelArchethicWallet {
    return Intl.message('Wallet', name: 'serviceTypeLabelArchethicWallet');
  }

  String get serviceTypeLabelAeweb {
    return Intl.message('Website hosted on AEWeb',
        name: 'serviceTypeLabelAeweb');
  }

  String get serviceTypeLabelOther {
    return Intl.message('Other', name: 'serviceTypeLabelOther');
  }
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalization> {
  const AppLocalizationsDelegate(this.languageSetting);

  final AvailableLanguage languageSetting;

  @override
  bool isSupported(Locale locale) {
    return languageSetting != null;
  }

  @override
  Future<AppLocalization> load(Locale locale) {
    if (languageSetting == AvailableLanguage.systemDefault) {
      return AppLocalization.load(locale);
    }
    return AppLocalization.load(Locale(languageSetting.getLocaleString()));
  }

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalization> old) {
    return true;
  }
}
