// ignore_for_file: constant_identifier_names

part of '../exceptions.dart';

class FailureException implements Exception {
  late ExceptionType _eType;
  late ExceptionLevel _eLevel;
  late String? _eMessage;
  late Object? _eError;
  late StackTrace? _eStackTrace;

  FailureException({
    ExceptionType? type,
    ExceptionLevel? level,
    String? message,
    Object? error,
    StackTrace? stackTrace,
  }) {
    this._eType = type ?? ExceptionType.NONE;
    this._eLevel = level ?? ExceptionLevel.IGNORE;
    this._eMessage = message;
    this._eError = error;
    this._eStackTrace = stackTrace;
    _handleException();
  }
  ExceptionType get type => _eType;
  ExceptionLevel get level => _eLevel;
  String? get message => _eMessage;
  Object? get error => _eError;
  StackTrace? get stackTrace => _eStackTrace;

  bool get isActive => !(type == ExceptionType.NONE &&
      level == ExceptionLevel.IGNORE &&
      message == null &&
      stackTrace == null);

  bool get hasError =>
      level == ExceptionLevel.ERROR &&
      message != null &&
      error != null &&
      stackTrace != null;

  bool get justMessage => level == ExceptionLevel.IGNORE && message != null;

  void _handleException() {
    switch (level) {
      case ExceptionLevel.INFO:
        logger.info(message ?? "");
        break;
      case ExceptionLevel.NOT_FOUND:
        logger.log(message: message ?? "", level: Level.FINE);
        break;
      case ExceptionLevel.IGNORE:
        logger.log(message: message ?? "", level: Level.FINER);
        break;
      case ExceptionLevel.WARNING:
        logger.warning(message ?? "");
        break;
      case ExceptionLevel.ERROR:
        if (error is Exception) {
          logger.error(
              "${error.runtimeType} with an error => ${error.toString()}");
        }
        break;
    }

    if (error is FailureException) {
      final failure = error as FailureException;
      this._eType = failure.type;
      this._eLevel = failure.level;
      if (_eMessage != null) {
        this._eMessage = '$_eMessage ${failure.message}';
      } else {
        this._eMessage = failure.message;
      }
      if (_eError != null) {
        var start = stackTrace.toString().indexOf("#0");
        var end = stackTrace.toString().indexOf("#1");
        this._eError = stackTrace
            .toString()
            .substring(start, start + end)
            .replaceAll(" ", "")
            .replaceAll("#0", "Error happened here => ");
      }

      if (_eStackTrace == null) {
        this._eStackTrace = failure.stackTrace;
      }
    }
  }

  @override
  String toString() {
    return 'FailureException(type: $type, level: $level, message: $message, error: $error, stackTrace: $stackTrace)';
  }
}
