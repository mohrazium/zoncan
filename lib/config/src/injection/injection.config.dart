// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../../app/app.dart' as _i14;
import '../../../core/common/src/database/database.dart' as _i5;
import '../../../core/common/src/storage/storage.dart' as _i8;
import '../../../core/core.dart' as _i13;
import '../../../core/security/security.dart' as _i4;
import '../../../features/accounts/accounts.dart' as _i9;
import '../../../features/accounts/data/data.dart' as _i10;
import '../../../features/accounts/domain/domain.dart' as _i11;
import '../../../features/accounts/presentation/presentation.dart' as _i16;
import '../../../features/home/presentation/presentation.dart' as _i18;
import '../../../features/persons/data/data.dart' as _i7;
import '../../../features/persons/domain/domain.dart' as _i6;
import '../../../features/persons/presentation/presentation.dart' as _i17;
import '../../config.dart' as _i15;
import '../logger/logger.dart' as _i3;
import '../settings/settings.dart' as _i12;

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
    gh.factory<_i6.PersonRepository>(() => _i7.PersonRepositoryImpl());
    gh.factory<_i8.StorageProvider>(() => _i8.StorageProviderImpl());
    gh.factory<_i9.UserDetailsRepository>(
        () => _i10.UserDetailsRepositoryImpl());
    gh.factory<_i11.UserFindByEmailUsecase>(
        () => _i11.UserFindByEmailUsecase(gh<_i11.UserDetailsRepository>()));
    gh.factory<_i11.UserFindByUsernameUsecase>(
        () => _i11.UserFindByUsernameUsecase(gh<_i11.UserDetailsRepository>()));
    gh.factory<_i11.UserFindByUUIDUsecase>(
        () => _i11.UserFindByUUIDUsecase(gh<_i11.UserDetailsRepository>()));
    gh.factory<_i11.UserNotExistUsecase>(
        () => _i11.UserNotExistUsecase(gh<_i11.UserDetailsRepository>()));
    gh.factory<_i6.UserFindByEmailUsecase>(
        () => _i6.UserFindByEmailUsecase(gh<_i11.UserDetailsRepository>()));
    gh.factory<_i6.UserFindByUsernameUsecase>(
        () => _i6.UserFindByUsernameUsecase(gh<_i11.UserDetailsRepository>()));
    gh.factory<_i6.UserFindByUUIDUsecase>(
        () => _i6.UserFindByUUIDUsecase(gh<_i11.UserDetailsRepository>()));
    gh.factory<_i6.UserNotExistUsecase>(
        () => _i6.UserNotExistUsecase(gh<_i11.UserDetailsRepository>()));
    gh.factory<_i12.SettingsProvider>(
        () => _i12.SettingsProviderImpl(gh<_i13.StorageProvider>()));
    gh.factory<_i4.AuthenticationRepository>(
        () => _i4.AuthenticationRepositoryImpl(
              gh<_i9.UserDetailsRepository>(),
              gh<_i4.SecureStorageRepository>(),
              gh<_i13.StorageProvider>(),
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
    gh.factory<_i14.AppStateController>(() => _i14.AppStateController(
          gh<_i15.SettingsProvider>(),
          gh<_i13.AuthenticationRepository>(),
        ));
    gh.factory<_i16.SignupController>(() => _i16.SignupController(
          gh<_i4.SignUpUsecase>(),
          gh<_i4.UsernameAlreadyExistsUsecase>(),
          gh<_i4.EmailAddressAlreadyExistsUsecase>(),
          gh<_i4.StrengthPasswordChecker>(),
          gh<_i14.AppStateController>(),
        ));
    gh.factory<_i17.SignupController>(() => _i17.SignupController(
          gh<_i4.SignUpUsecase>(),
          gh<_i4.UsernameAlreadyExistsUsecase>(),
          gh<_i4.EmailAddressAlreadyExistsUsecase>(),
          gh<_i4.StrengthPasswordChecker>(),
          gh<_i14.AppStateController>(),
        ));
    gh.factory<_i16.LoginController>(() => _i16.LoginController(
          gh<_i14.AppStateController>(),
          gh<_i4.LoginUsecase>(),
          gh<_i4.EmailAddressAlreadyExistsUsecase>(),
          gh<_i4.UsernameAlreadyExistsUsecase>(),
          gh<_i4.RememberedPasswordUsecase>(),
          gh<_i4.RememberedUsernameUsecase>(),
        ));
    gh.factory<_i17.LoginController>(() => _i17.LoginController(
          gh<_i14.AppStateController>(),
          gh<_i4.LoginUsecase>(),
          gh<_i4.EmailAddressAlreadyExistsUsecase>(),
          gh<_i4.UsernameAlreadyExistsUsecase>(),
          gh<_i4.RememberedPasswordUsecase>(),
          gh<_i4.RememberedUsernameUsecase>(),
        ));
    gh.factory<_i18.HomeController>(() => _i18.HomeController(
          gh<_i4.AuthenticationRepository>(),
          gh<_i14.AppStateController>(),
        ));
    gh.factory<_i16.ProfileController>(() => _i16.ProfileController(
          gh<_i14.AppStateController>(),
          gh<_i4.LogoutUsecase>(),
        ));
    gh.factory<_i17.ProfileController>(() => _i17.ProfileController(
          gh<_i14.AppStateController>(),
          gh<_i4.LogoutUsecase>(),
        ));
    return this;
  }
}
