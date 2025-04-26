
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'service_locator.config.dart';

final _serviceLocator = GetIt.instance;

@InjectableInit(
  initializerName: 'get_it_service_locator_init', // default
  preferRelativeImports: true, // default
  asExtension: true, // default
)
void _configureDependencies() => _serviceLocator.get_it_service_locator_init();

class Injection{
  static void dependencyConfigurations()=>_configureDependencies();
  static GetIt get serviceLocator=> _serviceLocator;
}