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
import '../../../app/src/app_state_controller.dart' as _i897;
import '../../../core/common/common.dart' as _i833;
import '../../../core/common/database/helper/zoncan_database.dart' as _i808;
import '../../../core/common/storage/storage_provider.dart' as _i338;
import '../../../core/core.dart' as _i353;
import '../../../core/exceptions/logger_service.dart' as _i193;
import '../../../core/security/application/services/authentication_guard.dart'
    as _i77;
import '../../../core/security/data/repository/authentication_repository_impl.dart'
    as _i279;
import '../../../core/security/data/repository/secure_storage_impl.dart'
    as _i183;
import '../../../core/security/domain/repository/authentication_repository.dart'
    as _i775;
import '../../../core/security/security.dart' as _i925;
import '../../../core/security/utils/strength_password_checker.dart' as _i580;
import '../../../features/accounts/data/datasource/local/daos/person_dao.dart'
    as _i1021;
import '../../../features/accounts/data/datasource/local/daos/user_details_dao.dart'
    as _i704;
import '../../../features/accounts/data/repository/user_details_repository_impl.dart'
    as _i474;
import '../../../features/accounts/domain/repository/user_details_repository.dart'
    as _i736;
import '../../../features/accounts/domain/usecases/current_user_details_usecase.dart'
    as _i950;
import '../../../features/accounts/domain/usecases/email_address_already_exists_usecase.dart'
    as _i356;
import '../../../features/accounts/domain/usecases/is_user_logged_in_usecase.dart'
    as _i1030;
import '../../../features/accounts/domain/usecases/login_usecase.dart' as _i357;
import '../../../features/accounts/domain/usecases/logout_usecase.dart'
    as _i1061;
import '../../../features/accounts/domain/usecases/remembered_password_usecase.dart'
    as _i704;
import '../../../features/accounts/domain/usecases/remembered_username_usecase.dart'
    as _i875;
import '../../../features/accounts/domain/usecases/sign_up_usecase.dart'
    as _i1062;
import '../../../features/accounts/domain/usecases/user_exist_usecase.dart'
    as _i228;
import '../../../features/accounts/domain/usecases/user_findby_email_usecase.dart'
    as _i534;
import '../../../features/accounts/domain/usecases/user_findby_username_usecase.dart'
    as _i997;
import '../../../features/accounts/domain/usecases/user_findby_uuid_usecase.dart'
    as _i86;
import '../../../features/accounts/domain/usecases/username_already_exists_usecase.dart'
    as _i322;
import '../../../features/accounts/presentation/controllers/login_controller.dart'
    as _i545;
import '../../../features/accounts/presentation/controllers/profile_controller.dart'
    as _i262;
import '../../../features/accounts/presentation/controllers/signup_controller.dart'
    as _i146;
import '../../../features/home/presentation/controllers/home_controller.dart'
    as _i909;
import '../../config.dart' as _i379;
import '../router/zrouter.dart' as _i356;
import '../settings/settings_provider.dart' as _i141;

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
    gh.factory<_i580.StrengthPasswordChecker>(
        () => _i580.StrengthPasswordChecker());
    gh.factory<_i77.AuthenticationGuard>(() => _i77.AuthenticationGuard());
    gh.factory<_i193.LoggerService>(() => _i193.LoggerService());
    gh.lazySingleton<_i808.ZoncanDatabase>(() => _i808.ZoncanDatabase());
    gh.factory<_i353.SecureStorageRepository>(
        () => _i183.SecureStorageRepositoryImpl());
    gh.factory<_i338.StorageProvider>(() => _i338.StorageProviderImpl());
    gh.factory<_i1021.PersonDao>(
        () => _i1021.PersonDao(gh<_i353.ZoncanDatabase>()));
    gh.factory<_i704.UserDetailsDao>(
        () => _i704.UserDetailsDao(gh<_i353.ZoncanDatabase>()));
    gh.factory<_i736.UserDetailsRepository>(
        () => _i474.UserDetailsRepositoryImpl(gh<_i704.UserDetailsDao>()));
    gh.factory<_i353.AuthenticationRepository>(
        () => _i279.AuthenticationRepositoryImpl(
              gh<_i736.UserDetailsRepository>(),
              gh<_i353.SecureStorageRepository>(),
              gh<_i353.StorageProvider>(),
            ));
    gh.factory<_i141.SettingsProvider>(
        () => _i141.SettingsProviderImpl(gh<_i833.StorageProvider>()));
    gh.factory<_i997.UserFindByUsernameUsecase>(() =>
        _i997.UserFindByUsernameUsecase(gh<_i736.UserDetailsRepository>()));
    gh.factory<_i534.UserFindByEmailUsecase>(
        () => _i534.UserFindByEmailUsecase(gh<_i736.UserDetailsRepository>()));
    gh.factory<_i228.UserExistUsecase>(
        () => _i228.UserExistUsecase(gh<_i736.UserDetailsRepository>()));
    gh.factory<_i86.UserFindByUUIDUsecase>(
        () => _i86.UserFindByUUIDUsecase(gh<_i736.UserDetailsRepository>()));
    gh.factory<_i1061.LogoutUsecase>(
        () => _i1061.LogoutUsecase(gh<_i353.AuthenticationRepository>()));
    gh.factory<_i1062.SignUpUsecase>(
        () => _i1062.SignUpUsecase(gh<_i353.AuthenticationRepository>()));
    gh.factory<_i356.EmailAddressAlreadyExistsUsecase>(() =>
        _i356.EmailAddressAlreadyExistsUsecase(
            gh<_i353.AuthenticationRepository>()));
    gh.factory<_i704.RememberedPasswordUsecase>(() =>
        _i704.RememberedPasswordUsecase(gh<_i353.AuthenticationRepository>()));
    gh.factory<_i357.LoginUsecase>(
        () => _i357.LoginUsecase(gh<_i353.AuthenticationRepository>()));
    gh.factory<_i322.UsernameAlreadyExistsUsecase>(() =>
        _i322.UsernameAlreadyExistsUsecase(
            gh<_i353.AuthenticationRepository>()));
    gh.factory<_i1030.IsUserLoggedInUsecase>(() =>
        _i1030.IsUserLoggedInUsecase(gh<_i353.AuthenticationRepository>()));
    gh.factory<_i950.CurrentUserDetailsUsecase>(() =>
        _i950.CurrentUserDetailsUsecase(gh<_i353.AuthenticationRepository>()));
    gh.factory<_i875.RememberedUsernameUsecase>(() =>
        _i875.RememberedUsernameUsecase(gh<_i353.AuthenticationRepository>()));
    gh.lazySingleton<_i897.AppStateController>(() => _i897.AppStateController(
          gh<_i379.SettingsProvider>(),
          gh<_i353.AuthenticationRepository>(),
        ));
    gh.factory<_i545.LoginController>(() => _i545.LoginController(
          gh<_i89.AppStateController>(),
          gh<_i357.LoginUsecase>(),
          gh<_i356.EmailAddressAlreadyExistsUsecase>(),
          gh<_i322.UsernameAlreadyExistsUsecase>(),
          gh<_i704.RememberedPasswordUsecase>(),
          gh<_i875.RememberedUsernameUsecase>(),
        ));
    gh.factory<_i262.ProfileController>(() => _i262.ProfileController(
          gh<_i89.AppStateController>(),
          gh<_i1061.LogoutUsecase>(),
        ));
    gh.factory<_i909.HomeController>(() => _i909.HomeController(
          gh<_i775.AuthenticationRepository>(),
          gh<_i897.AppStateController>(),
        ));
    gh.factory<_i146.SignupController>(() => _i146.SignupController(
          gh<_i1062.SignUpUsecase>(),
          gh<_i322.UsernameAlreadyExistsUsecase>(),
          gh<_i356.EmailAddressAlreadyExistsUsecase>(),
          gh<_i925.StrengthPasswordChecker>(),
          gh<_i89.AppStateController>(),
        ));
    return this;
  }
}
