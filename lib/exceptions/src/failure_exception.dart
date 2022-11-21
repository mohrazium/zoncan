// ignore_for_file: constant_identifier_names

part of zoncan.exceptions;

class FailureException implements Exception {
  final ExceptionType type;
  final ExceptionLevel level;
  final String? message;
  final Object? error;
  final StackTrace? stackTrace;

  FailureException({
    this.type = ExceptionType.NONE,
    this.level = ExceptionLevel.IGNORE,
    this.message,
    this.error,
    this.stackTrace,
  }) {
    _handleException();
  }

  bool get isActive => !(type == ExceptionType.NONE &&
      level == ExceptionLevel.IGNORE &&
      message == null &&
      error == null &&
      stackTrace == null);

  bool get hasError =>
      level == ExceptionLevel.ERROR ||
      message != null ||
      error != null ||
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
  }

  @override
  String toString() {
    return 'FailureException(type: $type, level: $level, message: $message, error: $error, stackTrace: $stackTrace)';
  }
}
