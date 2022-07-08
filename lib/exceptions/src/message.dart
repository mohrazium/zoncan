import 'package:zoncan/config/config.dart' show logger;

import 'exceptions_type.dart';
import 'failure.dart';

class Message implements Failure {
  late final String? message;
  final ExceptionLevel level;

  Message(this.message, {this.level = ExceptionLevel.INFO}) {
    _handle();
  }

  @override
  String toString() => message ?? "";

  void _handle() {
    switch (level) {
      case ExceptionLevel.INFO:
      case ExceptionLevel.NOT_FOUND:
      case ExceptionLevel.IGNORE:
        logger.info("${level.name} message was thrown with content : $message");
        break;
      case ExceptionLevel.WARNING:
        logger.warning(
            "${level.name} message was thrown with content : $message");
        break;
      case ExceptionLevel.ERROR:
        logger
            .error("${level.name} message was thrown with content : $message");
        break;
    }
  }
}
