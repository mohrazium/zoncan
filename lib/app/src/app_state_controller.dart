import 'dart:async';

import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';

import 'package:zoncan/config/config.dart';
import 'package:zoncan/core/core.dart';
import 'package:zoncan/features/accounts/data/models/user_details_model.dart';

part 'app_state_controller.g.dart';

@LazySingleton()
class AppStateController extends _AppStateControllerStore
    with _$AppStateController {
  AppStateController(super.settingsProvider, super.authService);

  @override
  Future<void> didChangeDependencies() async {
    await getCurrentUser();
    ZLogger(
      logLevel: LogLevel.IGNORE,
      message: "${this.runtimeType} changed dependencies.",
    );
  }

  @override
  void dispose() {
    ZLogger(
      logLevel: LogLevel.IGNORE,
      message: "${this.runtimeType} disposed.",
    );
  }

  @override
  Future<void> initState() async {
   await loadAllSettings();
    ZLogger(
      logLevel: LogLevel.IGNORE,
      message: "${this.runtimeType} init state.",
    );
  }
}

abstract class _AppStateControllerStore extends Controller with Store {
  final SettingsProvider settingsProvider;
  final AuthenticationRepository authService;

  @observable
  ThemeMode themeMode = ThemeMode.light;
  @observable
  SettingProperties settings = SettingProperties.init();
  @observable
  FailureException? exception;
  @observable
  UsecaseExecutor<UserDetailsModel?> currentUserState =
      UsecaseExecutor<UserDetailsModel?>();

  _AppStateControllerStore(this.settingsProvider, this.authService);

  @computed
  UserDetailsModel? get currentUser => currentUserState.data;

  @action
  Future<void> getCurrentUser() async {
    await currentUserState.execute(() async {
      return await authService.currentUserDetails().then(
        (res) => res.fold((failure) {
          exception = failure;
          return null;
        }, (user) => user),
      );
    });
  }

  @action
  void switchTheme([ThemeMode? mode]) {
    themeMode =
        mode ??
        (themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light);
  }

  @action
  Future<void> loadAllSettings() async {
    settings = await settingsProvider.loadSettings();
  }

  @action
  Future<void> saveFontScale(double scale) async {
    settings = await settingsProvider.saveFontScaleFactor(scale);
  }
}
