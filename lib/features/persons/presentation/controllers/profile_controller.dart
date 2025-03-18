part of '../presentation.dart';

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
    appStateController.setIsLoading(TranslationsProvider.translator.loadingPleaseWait);
    return await logoutUsecase
        .call()
        .then((resultValue) => resultValue.fold((error) {
              appStateController.unsetIsLoading();
              appStateController.throwException(error);
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
