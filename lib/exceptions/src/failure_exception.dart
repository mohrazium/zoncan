// ignore_for_file: constant_identifier_names

import 'package:zoncan/config/config.dart' show logger;

import 'exceptions_type.dart';
import 'failure.dart';

class FailureException implements Failure {
  late final String? message;
  final Object? error;
  final StackTrace? stackTrace;

  FailureException(this.message, [this.error = Exception, this.stackTrace]) {
    _handleException();
  }

  @override
  String toString() => message ?? "";

  void _handleException() {
    if (error is Exception) {
      logger.error("${error.runtimeType} with an error => ${error.toString()}");
    } else if (error is ExceptionLevel) {
      if (error == ExceptionLevel.NOT_FOUND) {
        logger.info(message ?? "Your object is null or not found!");
      } else if (error == ExceptionLevel.IGNORE) {
        logger.info(message ?? "Your object ignored.");
      }
    }
  }
}
