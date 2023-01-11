library zoncan.config;

import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:floy/floy.dart';
import 'package:flutter_modular/flutter_modular.dart'
    show AsyncBind, Bind, Modular;
import 'package:zoncan/app/app.dart';
import 'package:zoncan/common/common.dart'
    show
        Auditor,
        AuditorImpl,
        ModelSerializer,
        StorageProvider,
        StorageProviderImpl,
        ZoncanDatabase;
import 'package:zoncan/common/src/database/database.dart';
import 'package:zoncan/features/features.dart';
import 'package:zoncan/security/security.dart'
    show
        AuthService,
        AuthServiceImpl,
        SecureStorage,
        SecureStorageImpl,
        StrengthPasswordChecker;
import 'package:zoncan/settings/settings.dart'
    show SettingsProvider, SettingsProviderImpl;

import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';

part 'src/injection/injector.dart';
part 'src/logger/logger_service.dart';
part 'src/router/routes.dart';
