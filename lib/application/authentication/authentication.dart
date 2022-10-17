import 'dart:async';

import 'package:aewallet/application/authentication/model/model.dart';
import 'package:aewallet/application/settings.dart';
import 'package:aewallet/features/authentication/domain/port/i_authenticate_with_credentials.dart';
import 'package:aewallet/model/authentication_method.dart';
import 'package:aewallet/util/preferences.dart';
import 'package:aewallet/util/vault.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'repository/repository.dart';
part 'repository/vault_repository.dart';
part 'provider/provider.dart';
