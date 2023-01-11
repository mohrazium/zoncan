part of zoncan.config;

class Injector {
  static Injector inject = Injector();

  List<Bind<Object>> get appBinds => [
        Bind.factory<LoggerService>((i) => LoggerService()),
        AsyncBind<ZoncanDatabase>((i) async => ZoncanDatabase.create()),
        Bind.factory<Auditor>((i) => AuditorImpl()),
        Bind.factory<UserDetailsRepository>((i) => UserDetailsRepositoryImpl()),
        Bind.factory<UserDetailsService>((i) => UserDetailsServiceImpl(i())),
        Bind.factory<StorageProvider>((i) => StorageProviderImpl()),
        Bind.factory<SecureStorage>((i) => SecureStorageImpl()),
        Bind.factory<AuthService>((i) => AuthServiceImpl(i(), i(), i(),i())),
        Bind.factory<SettingsProvider>((i) => SettingsProviderImpl(i())),
        Bind.singleton<AppStateController>((i) => AppStateController(i()),
            onDispose: (controller) => controller.dispose()),
        Bind.singleton<FloyWindowManager>((i) => FloyWindowManager())
      ];

  List<Bind<Object>> get accountsBinds => [
        Bind.singleton<StrengthPasswordChecker>(
            (i) => StrengthPasswordChecker()),
        Bind.singleton<SignupController>((i) => SignupController(i(), i(), i()),
            onDispose: (controller) => controller.dispose()),
        Bind.singleton<LoginController>((i) => LoginController(i(), i()),
            onDispose: (controller) => controller.dispose()),
      ];
}
