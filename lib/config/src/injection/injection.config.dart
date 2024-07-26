// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../../app/app.dart' as _i12;
import '../../../core/common/src/database/database.dart' as _i5;
import '../../../core/common/src/storage/storage.dart' as _i6;
import '../../../core/core.dart' as _i10;
import '../../../core/security/security.dart' as _i4;
import '../../../features/accounts/accounts.dart' as _i11;
import '../../../features/accounts/data/data.dart' as _i8;
import '../../../features/accounts/domain/domain.dart' as _i7;
import '../../../features/accounts/presentation/presentation.dart' as _i13;
import '../../../features/home/presentation/presentation.dart' as _i14;
import '../logger/logger.dart' as _i3;
import '../settings/settings.dart' as _i9;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.factory<_i3.LoggerService>(() => _i3.LoggerService());
    gh.factory<_i4.AuthenticationGuard>(() => _i4.AuthenticationGuard());
    gh.factory<_i4.StrengthPasswordChecker>(
        () => _i4.StrengthPasswordChecker());
    gh.lazySingleton<_i5.ZoncanDatabase>(() => _i5.ZoncanDatabase());
    gh.factory<_i4.SecureStorageRepository>(
        () => _i4.SecureStorageRepositoryImpl());
    gh.factory<_i6.StorageProvider>(() => _i6.StorageProviderImpl());
    gh.factory<_i7.UserDetailsRepository>(
        () => _i8.UserDetailsRepositoryImpl());
    gh.factory<_i7.UserFindByEmailUsecase>(
        () => _i7.UserFindByEmailUsecase(gh<_i7.UserDetailsRepository>()));
    gh.factory<_i7.UserFindByUsernameUsecase>(
        () => _i7.UserFindByUsernameUsecase(gh<_i7.UserDetailsRepository>()));
    gh.factory<_i7.UserFindByUUIDUsecase>(
        () => _i7.UserFindByUUIDUsecase(gh<_i7.UserDetailsRepository>()));
    gh.factory<_i7.UserNotExistUsecase>(
        () => _i7.UserNotExistUsecase(gh<_i7.UserDetailsRepository>()));
    gh.factory<_i9.SettingsProvider>(
        () => _i9.SettingsProviderImpl(gh<_i10.StorageProvider>()));
    gh.factory<_i4.AuthenticationRepository>(
        () => _i4.AuthenticationRepositoryImpl(
              gh<_i11.UserDetailsRepository>(),
              gh<_i4.SecureStorageRepository>(),
              gh<_i10.StorageProvider>(),
            ));
    gh.factory<_i4.CurrentUserDetailsUsecase>(() =>
        _i4.CurrentUserDetailsUsecase(gh<_i4.AuthenticationRepository>()));
    gh.factory<_i4.EmailAddressAlreadyExistsUsecase>(() =>
        _i4.EmailAddressAlreadyExistsUsecase(
            gh<_i4.AuthenticationRepository>()));
    gh.factory<_i4.IsUserLoggedInUsecase>(
        () => _i4.IsUserLoggedInUsecase(gh<_i4.AuthenticationRepository>()));
    gh.factory<_i4.LoginUsecase>(
        () => _i4.LoginUsecase(gh<_i4.AuthenticationRepository>()));
    gh.factory<_i4.LogoutUsecase>(
        () => _i4.LogoutUsecase(gh<_i4.AuthenticationRepository>()));
    gh.factory<_i4.RememberedPasswordUsecase>(() =>
        _i4.RememberedPasswordUsecase(gh<_i4.AuthenticationRepository>()));
    gh.factory<_i4.SignUpUsecase>(
        () => _i4.SignUpUsecase(gh<_i4.AuthenticationRepository>()));
    gh.factory<_i4.UsernameAlreadyExistsUsecase>(() =>
        _i4.UsernameAlreadyExistsUsecase(gh<_i4.AuthenticationRepository>()));
    gh.factory<_i4.RememberedUsernameUsecase>(() =>
        _i4.RememberedUsernameUsecase(gh<_i4.AuthenticationRepository>()));
    gh.factory<_i12.AppStateController>(() => _i12.AppStateController(
          gh<_i9.SettingsProvider>(),
          gh<_i10.AuthenticationRepository>(),
        ));
    gh.factory<_i13.SignupController>(() => _i13.SignupController(
          gh<_i4.SignUpUsecase>(),
          gh<_i4.UsernameAlreadyExistsUsecase>(),
          gh<_i4.EmailAddressAlreadyExistsUsecase>(),
          gh<_i4.StrengthPasswordChecker>(),
          gh<_i12.AppStateController>(),
        ));
    gh.factory<_i13.LoginController>(() => _i13.LoginController(
          gh<_i12.AppStateController>(),
          gh<_i4.LoginUsecase>(),
          gh<_i4.EmailAddressAlreadyExistsUsecase>(),
          gh<_i4.UsernameAlreadyExistsUsecase>(),
          gh<_i4.RememberedPasswordUsecase>(),
          gh<_i4.RememberedUsernameUsecase>(),
        ));
    gh.factory<_i14.HomeController>(() => _i14.HomeController(
          gh<_i4.AuthenticationRepository>(),
          gh<_i12.AppStateController>(),
        ));
    gh.factory<_i13.ProfileController>(() => _i13.ProfileController(
          gh<_i12.AppStateController>(),
          gh<_i4.LogoutUsecase>(),
        ));
    return this;
  }
}
