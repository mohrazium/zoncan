part of zoncan.config;

class Injector {
  Injector.inject();

  List<Bind<Object>> get appBinds => [
        AsyncBind<ZoncanDatabase>((i) async => ZoncanDatabase.create()),
        Bind.factory<UserDetailsRepository>((i) => UserDetailsRepositoryImpl()),
        Bind.factory<AuthService>((i) => AuthServiceImpl(i())),
        Bind.factory<StorageProvider>((i) => StorageProviderImpl()),
        Bind.factory<SecureStorage>((i) => SecureStorageImpl()),
        Bind.factory<SettingsProvider>((i) => SettingsProviderImpl(i())),
      ];
}
