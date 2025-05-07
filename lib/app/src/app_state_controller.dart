
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';

import 'package:zoncan/config/config.dart';
import 'package:zoncan/core/core.dart';
import 'package:zoncan/features/accounts/data/models/user_details_model.dart';

part 'app_state_controller.g.dart';

@Injectable()
class AppStateController extends _AppStateControllerStore
    with _$AppStateController {
  AppStateController(super.settingsProvider, super.authService);

  @override
  void didChangeDependencies() {
    ZLogger(
      logLevel: LogLevel.IGNORE,
      message: "${this.runtimeType} changed dependencies.",
    );
  }

  @override
  void dispose() {
    FailureException(message: "${this.runtimeType} disposed.");
  }

  @override
  void initState() {
    loadAllSettings();
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
  bool shouldRefreshUI = false;

  @observable
  String? message;

  _AppStateControllerStore(this.settingsProvider, this.authService);

 //TODO: make the computed to use usecase state managemet
  @computed
  Future<UserDetailsModel?> get currentUser async =>
      await authService.currentUserDetails().then(
        (res) => res.fold((failure) {
          return null;
        }, (user) => user),
      );

  
  @action
  void switchTheme([ThemeMode? mode]) {
    themeMode =
        mode ??
        (themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light);
  }

  @action
  Future<void> loadAllSettings() async {
    shouldRefreshUI = false;
    settings = await settingsProvider.loadSettings();
  }

  @action
  Future<void> saveFontScale(double scale) async {
    settings = await settingsProvider.saveFontScaleFactor(scale);
    shouldRefreshUI = true;
  }
}
