library zoncan.config;

import 'package:flutter_modular/flutter_modular.dart' show AsyncBind, Bind;
import 'package:zoncan/common/common.dart'
    show StorageProvider, StorageProviderImpl, ZoncanDatabase;
import 'package:zoncan/security/security.dart'
    show
        AuthService,
        AuthServiceImpl,
        SecureStorage,
        SecureStorageImpl,
        UserDetailsRepository,
        UserDetailsRepositoryImpl;
import 'package:zoncan/settings/settings.dart'
    show SettingsProvider, SettingsProviderImpl;

import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';

part 'src/injection/injector.dart';
part 'src/logger/logger_service.dart';
part 'src/router/routes.dart';
