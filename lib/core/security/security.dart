library zoncan.core.security;

import 'dart:core';
import 'dart:io';

import 'package:cryptology/cryptology.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:password_policy/password_policy.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:validators2/validators2.dart';
import 'package:zoncan/config/config.dart';
import 'package:zoncan/core/core.dart';
import 'package:zoncan/features/accounts/accounts.dart';


part 'src/application/services/authentication_guard.dart';
part 'src/data/repository/secure_storage_impl.dart';
part 'src/utils/strength_password_checker.dart';
part 'src/data/repository/authentication_repository_impl.dart';
part 'src/domain/repository/authentication_repository.dart';
part 'src/domain/repository/secure_storage_repository.dart';
part 'src/domain/usecases/current_user_details_usecase.dart';
part 'src/domain/usecases/email_address_already_exists_usecase.dart';
part 'src/domain/usecases/is_user_logged_in_usecase.dart';
part 'src/domain/usecases/login_usecase.dart';
part 'src/domain/usecases/logout_usecase.dart';
part 'src/domain/usecases/remembered_password_usecase.dart';
part 'src/domain/usecases/sign_up_usecase.dart';
part 'src/domain/usecases/username_already_exists_usecase.dart';
part 'src/domain/usecases/remembered_username_usecase.dart';
part 'src/application/middewares/redirect_ifauth_middleware.dart';
part 'src/application/middewares/require_auth_middleware.dart';