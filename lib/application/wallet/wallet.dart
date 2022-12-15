import 'dart:async';

import 'package:aewallet/application/authentication/authentication.dart';
import 'package:aewallet/application/contact.dart';
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/domain/models/app_wallet.dart';
import 'package:aewallet/infrastructure/datasources/hive_vault.dart';
import 'package:aewallet/model/data/account_balance.dart';
import 'package:aewallet/model/data/appdb.dart';
import 'package:aewallet/model/data/hive_app_wallet_dto.dart';
import 'package:aewallet/model/keychain_secured_infos.dart';
import 'package:aewallet/model/keychain_secured_infos_service.dart';
import 'package:aewallet/model/keychain_service_keypair.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/keychain_util.dart';
import 'package:aewallet/util/mnemonics.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'providers.dart';
part 'state.dart';
part 'wallet.g.dart';
