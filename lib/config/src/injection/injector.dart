import 'package:flutter_modular/flutter_modular.dart' show AsyncBind, Bind;
import 'package:zoncan/common/common.dart'
    show StorageProvider, StorageProviderImpl, ZoncanDatabase;
import 'package:zoncan/security/security.dart'
    show
        AuthService,
        AuthServiceImpl,
        UserDetailsRepository,
        UserDetailsRepositoryImpl;
import 'package:zoncan/settings/settings.dart'
    show SettingsProvider, SettingsProviderImpl;

class Injector {
  Injector.inject();

  List<Bind<Object>> get appModuleBinds => [
        AsyncBind<ZoncanDatabase>((i) async => ZoncanDatabase.create()),
        Bind.factory<UserDetailsRepository>((i) => UserDetailsRepositoryImpl()),
        Bind.factory<AuthService>((i) => AuthServiceImpl(i())),
        Bind.factory<UserDetailsRepository>((i) => UserDetailsRepositoryImpl()),
        Bind.factory<StorageProvider>((i) => StorageProviderImpl()),
        Bind.factory<SettingsProvider>((i) => SettingsProviderImpl(i())),
      ];
}
