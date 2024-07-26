part of 'injection.dart';

final _serviceLocator = GetIt.instance;

@InjectableInit(
  initializerName: 'init', // default
  preferRelativeImports: true, // default
  asExtension: true, // default
)
void _configureDependencies() => _serviceLocator.init();

class Injection{
  static void dependencyConfigurations()=>_configureDependencies();
  static GetIt get serviceLocator=> _serviceLocator;
}