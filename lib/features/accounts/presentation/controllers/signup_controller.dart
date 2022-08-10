part of zoncan.features.accounts.presentation;

class SignupController
    extends NotifierStore<UserDetailsModel, FailureException> {

  SignupController(super.value);
  @override
  void initStore() {
    super.initStore();
  }

  @override
  Future destroy() async {
    super.destroy();
  }
}
