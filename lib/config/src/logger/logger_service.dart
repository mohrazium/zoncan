part of 'logger.dart';

final LoggerService logger = Injection.serviceLocator.get<LoggerService>();

@Injectable()
class LoggerService {
  static final List<String> _logs = [];

  Logger log({Level? level, required message}) {
    final Logger logger = Logger('Zoncan');
    level == null ? logger.log(Level.ALL, message) : logger.log(level, message);
    return logger;
  }

  Logger info(String message) {
    final Logger logger = Logger('Zoncan');
    logger.log(Level.INFO, message);
    return logger;
  }

  Logger warning(String message) {
    final Logger logger = Logger('Zoncan');
    logger.log(Level.WARNING, message);
    return logger;
  }

  Logger error(String message) {
    final Logger logger = Logger('Zoncan');
    logger.log(Level.SEVERE, message);
    return logger;
  }

  void setup() {
    Logger.root.level = Level.ALL;
    Logger.root.onRecord.listen((rec) async {
      var log =
          // '${_getPlatformNameAndVersion()}: ${rec.level.name}: ${rec.time.year}-${rec.time.month}-${rec.time.day} ${rec.time.hour}:${rec.time.minute}:${rec.time.second} : ${rec.loggerName} => ${rec.message}'),
          '${rec.level.name}: ${rec.time.year}-${rec.time.month}-${rec.time.day} ${rec.time.hour}:${rec.time.minute}:${rec.time.second} : ${rec.loggerName} => ${rec.message}';
      if (kDebugMode) {
        print(log);
        _logs.add(log);
      }
    });
    logger
        .log(level: Level.INFO, message: "Logger service is started...");
  }
}
