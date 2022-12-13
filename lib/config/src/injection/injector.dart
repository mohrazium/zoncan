part of zoncan.config;

class Injector {
  Injector.inject();

  List<Bind<Object>> get appBinds => [
        Bind.factory<LoggerService>((i) => LoggerService()),
        AsyncBind<ZoncanDatabase>((i) async => ZoncanDatabase.create()),
        Bind.factory<UserDetailsRepository>((i) => UserDetailsRepositoryImpl()),
        Bind.factory<UserDetailsService>((i) => UserDetailsServiceImpl(i())),
        Bind.factory<StorageProvider>((i) => StorageProviderImpl()),
        Bind.factory<SecureStorage>((i) => SecureStorageImpl()),
        Bind.factory<AuthService>((i) => AuthServiceImpl(i(), i())),
        Bind.factory<SettingsProvider>((i) => SettingsProviderImpl(i())),
        Bind.singleton<AppStateController>((i) => AppStateController(),
            onDispose: (controller) => controller.dispose()),
      ];

  List<Bind<Object>> get accountsBinds => [
        Bind.singleton<StrengthPasswordChecker>(
            (i) => StrengthPasswordChecker()),
        Bind.factory<SignupController>((i) => SignupController(i(), i(), i())),
        Bind.factory<LoginController>((i) => LoginController(i(), i())),
      ];
}
