// ignore_for_file: constant_identifier_names

part of '../exceptions.dart';

class FailureException implements Exception {
  final ExceptionType type;
  final ExceptionLevel level;
  final String? message;
  final String? userMessage;
  final Object? error;
  final StackTrace? stackTrace;

  FailureException({
    ExceptionType? type,
    ExceptionLevel? level,
    this.message,
    String? userMessage,
    this.error,
    this.stackTrace,
  })  : type = type ?? ExceptionType.NONE,
        level = level ?? ExceptionLevel.IGNORE,
        userMessage = userMessage ?? "" {
    _logException(); // Call logging logic in constructor
  }

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

  Future<void> _logException() async {
    final logMessage = _buildLogMessage();
    await _writeLogToFile(logMessage);

    // Log to console based on level
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
          logger.error("${error.runtimeType} => ${error.toString()}");
        }
        break;
    }
  }

  String _buildLogMessage() {
    final timestamp = DateTime.now().toIso8601String();
    String log = "[$timestamp] [$level] Type: $type";
    if (message != null) log += " - Message: $message";
    if (userMessage != null) log += " - User Message: $userMessage";
    if (error != null) log += " - Error: ${error.toString()}";
    if (stackTrace != null) log += "\nStackTrace: $stackTrace";
    return log;
  }

  Future<void> _writeLogToFile(String logMessage) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final logFileName = 'app_logs_${DateTime.now().toString().substring(0, 10)}.txt';
      final logFile = File('${directory.path}/$logFileName');

      await _manageLogFiles(directory);
      await logFile.writeAsString("$logMessage\n", mode: FileMode.append);
    } catch (e) {
      logger.info("Failed to write log to file: $e");
    }
  }

  Future<void> _manageLogFiles(Directory directory) async {
    const maxLogFiles = 5;

    final logFiles = directory
        .listSync()
        .where((file) => file.path.contains('app_logs_') && file.path.endsWith('.txt'))
        .map((file) => File(file.path))
        .toList();

    logFiles.sort((a, b) => a.lastModifiedSync().compareTo(b.lastModifiedSync()));

    if (logFiles.length >= maxLogFiles) {
      final filesToDelete = logFiles.take(logFiles.length - (maxLogFiles - 1));
      for (var file in filesToDelete) {
        try {
          await file.delete();
        } catch (e) {
          logger.info("Failed to delete old log file ${file.path}: $e");
        }
      }
    }
  }

  @override
  String toString() {
    return 'FailureException(type: $type, level: $level, message: $message, error: $error, stackTrace: $stackTrace)';
  }
}