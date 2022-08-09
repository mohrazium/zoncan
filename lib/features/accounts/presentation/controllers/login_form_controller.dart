part of zoncan.features.login;

class LoginSwitcherController extends NotifierStore<Exception, int> {
  LoginSwitcherController() : super(0);
  final val = RxNotifier<int>(12);
  Future<void> increment() async {
    setLoading(true);

    await Future.delayed(Duration(seconds: 1)).then((v) {
      int value = state + 1;
      if (value < 5) {
        update(value);
      } else {
        setError(Exception('Error: state can\'t be > 4'));
      }
      setLoading(false);
    });
  }

  @override
  initStore() {
    logger.info("${this.runtimeType} initialized");
  }

  @override
  Future destroy() async {
    logger.info("${this.runtimeType} destroyed");
  }
}
