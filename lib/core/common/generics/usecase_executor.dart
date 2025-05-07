import 'package:mobx/mobx.dart';
import 'package:zoncan/config/src/constants/app_constants.dart';
import 'package:zoncan/core/exceptions/exceptions.dart';

part 'usecase_executor.g.dart';

enum UsecaseState { initial, loading, success, emtpy, error }

class UsecaseExecutor<T> = _UsecaseExecutor<T> with _$UsecaseExecutor;

abstract class _UsecaseExecutor<T> with Store {
  @observable
  UsecaseState _state = UsecaseState.initial;

  @observable
  T? data;

  @observable
  FailureException? exception;

  @computed
  bool get isInitial => _state == UsecaseState.initial;

  @computed
  bool get isLoading => _state == UsecaseState.loading;

  @computed
  bool get isSuccess => _state == UsecaseState.success;

  @computed
  bool get isEmpty => _state == UsecaseState.emtpy;

  @computed
  bool get hasError => _state == UsecaseState.error;

  @action
  void loading() {
    _state = UsecaseState.loading;
    data = null;
    exception = null;
    ZLogger(
      logLevel: LogLevel.INFO,
      message: "${data.runtimeType} state is Loading ...",
    );
  }

  @action
  void success(T result) {
    data = result;
    _state = UsecaseState.success;
    exception = null;
    ZLogger(
      logLevel: LogLevel.INFO,
      message: "${data.runtimeType} state is success ...",
    );
  }

  @action
  void empty() {
    data = null;
    _state = UsecaseState.emtpy;
    exception = null;
    ZLogger(
      logLevel: LogLevel.WARNING,
      message: "${data.runtimeType} state is empty ...",
    );
  }

  @action
  void error(FailureException excp) {
    data = null;
    _state = UsecaseState.error;
    exception = excp;
    ZLogger(
      logLevel: LogLevel.ERROR,
      message: "${data.runtimeType} state is error ...",
    );
  }

  @action
  void reset() {
    data = null;
    _state = UsecaseState.initial;
    exception = null;
    ZLogger(
      logLevel: LogLevel.INFO,
      message: "${data.runtimeType} state is reset ...",
    );
  }

  Future<void> execute(Future<T?> Function() usecase) async {
    try {
      loading(); // Pass loading message
      await Future.delayed(kDelayWaiting);
      final T? result = await usecase();
      // Adjust empty check based on T if needed
      if (result == null ||
          (result is List && result.isEmpty) ||
          (result is Map && result.isEmpty)) {
        empty();
      } else {
        success(result);
      }
    } catch (e, stackTrace) {
      ZLogger(
        logLevel: LogLevel.ERROR,
        message: "Error during use case execution: $e",
      );
      ZLogger(logLevel: LogLevel.ERROR, message: stackTrace.toString());
      // Try to extract a user-friendly message from FailureException
      if (e is FailureException && e.userMessage != null) {
        error(e);
      } else {
        error(FailureException(error: e, stackTrace: stackTrace));
      }
    }
  }
}
