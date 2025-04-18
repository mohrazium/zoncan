// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../../app/app.dart' as _i89;
import '../../../core/common/src/database/database.dart' as _i959;
import '../../../core/common/src/storage/storage.dart' as _i709;
import '../../../core/core.dart' as _i353;
import '../../../core/security/security.dart' as _i925;
import '../../../features/accounts/accounts.dart' as _i410;
import '../../../features/accounts/data/data.dart' as _i496;
import '../../../features/accounts/domain/domain.dart' as _i260;
import '../../../features/accounts/presentation/presentation.dart' as _i610;
import '../../../features/home/presentation/presentation.dart' as _i652;
import '../../config.dart' as _i379;
import '../logger/logger.dart' as _i512;
import '../router/zrouter.dart' as _i356;
import '../settings/settings.dart' as _i405;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt get_it_service_locator_init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.factory<_i356.ZRouter>(() => _i356.ZRouter());
    gh.factory<_i512.LoggerService>(() => _i512.LoggerService());
    gh.factory<_i925.AuthenticationGuard>(() => _i925.AuthenticationGuard());
    gh.factory<_i925.StrengthPasswordChecker>(
        () => _i925.StrengthPasswordChecker());
    gh.lazySingleton<_i959.ZoncanDatabase>(() => _i959.ZoncanDatabase());
    gh.factory<_i925.SecureStorageRepository>(
        () => _i925.SecureStorageRepositoryImpl());
    gh.factory<_i709.StorageProvider>(() => _i709.StorageProviderImpl());
    gh.factory<_i496.UserDetailsDao>(
        () => _i496.UserDetailsDao(gh<_i353.ZoncanDatabase>()));
    gh.factory<_i496.PersonDao>(
        () => _i496.PersonDao(gh<_i353.ZoncanDatabase>()));
    gh.factory<_i405.SettingsProvider>(
        () => _i405.SettingsProviderImpl(gh<_i353.StorageProvider>()));
    gh.factory<_i410.UserDetailsRepository>(
        () => _i496.UserDetailsRepositoryImpl(gh<_i496.UserDetailsDao>()));
    gh.factory<_i260.UserFindByEmailUsecase>(
        () => _i260.UserFindByEmailUsecase(gh<_i260.UserDetailsRepository>()));
    gh.factory<_i260.UserFindByUsernameUsecase>(() =>
        _i260.UserFindByUsernameUsecase(gh<_i260.UserDetailsRepository>()));
    gh.factory<_i260.UserFindByUUIDUsecase>(
        () => _i260.UserFindByUUIDUsecase(gh<_i260.UserDetailsRepository>()));
    gh.factory<_i260.UserExistUsecase>(
        () => _i260.UserExistUsecase(gh<_i260.UserDetailsRepository>()));
    gh.factory<_i925.AuthenticationRepository>(
        () => _i925.AuthenticationRepositoryImpl(
              gh<_i410.UserDetailsRepository>(),
              gh<_i925.SecureStorageRepository>(),
              gh<_i353.StorageProvider>(),
            ));
    gh.factory<_i925.CurrentUserDetailsUsecase>(() =>
        _i925.CurrentUserDetailsUsecase(gh<_i925.AuthenticationRepository>()));
    gh.factory<_i925.EmailAddressAlreadyExistsUsecase>(() =>
        _i925.EmailAddressAlreadyExistsUsecase(
            gh<_i925.AuthenticationRepository>()));
    gh.factory<_i925.IsUserLoggedInUsecase>(() =>
        _i925.IsUserLoggedInUsecase(gh<_i925.AuthenticationRepository>()));
    gh.factory<_i925.LoginUsecase>(
        () => _i925.LoginUsecase(gh<_i925.AuthenticationRepository>()));
    gh.factory<_i925.LogoutUsecase>(
        () => _i925.LogoutUsecase(gh<_i925.AuthenticationRepository>()));
    gh.factory<_i925.RememberedPasswordUsecase>(() =>
        _i925.RememberedPasswordUsecase(gh<_i925.AuthenticationRepository>()));
    gh.factory<_i925.SignUpUsecase>(
        () => _i925.SignUpUsecase(gh<_i925.AuthenticationRepository>()));
    gh.factory<_i925.UsernameAlreadyExistsUsecase>(() =>
        _i925.UsernameAlreadyExistsUsecase(
            gh<_i925.AuthenticationRepository>()));
    gh.factory<_i925.RememberedUsernameUsecase>(() =>
        _i925.RememberedUsernameUsecase(gh<_i925.AuthenticationRepository>()));
    gh.factory<_i89.AppStateController>(() => _i89.AppStateController(
          gh<_i379.SettingsProvider>(),
          gh<_i353.AuthenticationRepository>(),
        ));
    gh.factory<_i610.SignupController>(() => _i610.SignupController(
          gh<_i353.SignUpUsecase>(),
          gh<_i353.UsernameAlreadyExistsUsecase>(),
          gh<_i353.EmailAddressAlreadyExistsUsecase>(),
          gh<_i353.StrengthPasswordChecker>(),
          gh<_i89.AppStateController>(),
        ));
    gh.factory<_i610.LoginController>(() => _i610.LoginController(
          gh<_i89.AppStateController>(),
          gh<_i353.LoginUsecase>(),
          gh<_i353.EmailAddressAlreadyExistsUsecase>(),
          gh<_i353.UsernameAlreadyExistsUsecase>(),
          gh<_i353.RememberedPasswordUsecase>(),
          gh<_i353.RememberedUsernameUsecase>(),
        ));
    gh.factory<_i652.HomeController>(() => _i652.HomeController(
          gh<_i925.AuthenticationRepository>(),
          gh<_i89.AppStateController>(),
        ));
    gh.factory<_i610.ProfileController>(() => _i610.ProfileController(
          gh<_i89.AppStateController>(),
          gh<_i353.LogoutUsecase>(),
        ));
    return this;
  }
}
