

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:validators2/validators2.dart';
import 'package:zoncan/app/app.dart';
import 'package:zoncan/config/config.dart';
import 'package:zoncan/core/exceptions/exceptions.dart';
import 'package:zoncan/core/common/common.dart';
import 'package:zoncan/core/utils/utils.dart';
import 'package:zoncan/features/accounts/domain/usecases/logout_usecase.dart';

import '../../data/models/user_details_model.dart';
import '../../domain/usecases/email_address_already_exists_usecase.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/remembered_password_usecase.dart';
import '../../domain/usecases/remembered_username_usecase.dart';
import '../../domain/usecases/username_already_exists_usecase.dart';

part 'profile_controller.g.dart';

@Injectable()
class ProfileController extends _ProfileController
    with _$ProfileController
    implements Controller {
  ProfileController(
    super.appStateController,
    super.logoutUsecase,
  );

  @override
  Future<void> initState() async {
    super.setupValidations();
    logger.info("${this.runtimeType} has been initialized.");
  }

  @override
  void didChangeDependencies() {
    logger.info("${this.runtimeType} dependencies changed.");
  }

  @override
  void dispose() {
    try {
      super.disposeValidations();
      logger.info("${this.runtimeType} disposed.");
    } catch (e) {
      //ignored
    }
  }
}

abstract class _ProfileController with Store {
  @protected
  final LogoutUsecase logoutUsecase;

  @protected
  final AppStateController appStateController;

  @protected
  List<ReactionDisposer>? disposers;

  _ProfileController(
    this.appStateController,
    this.logoutUsecase,
  );

  @action
  Future<bool> logout() async {
   
    return await logoutUsecase
        .call()
        .then((resultValue) => resultValue.fold((error) {
       
              return false;
            }, (result) {
              return result!;
            }));
  }

  void setupValidations() {
    disposers = [
      // reaction((_) => username, validateUsername),
    ];
  }

  void disposeValidations() {
    if (disposers != null) {
      for (var dispose in disposers!) {
        dispose();
      }
    }
  }
}
