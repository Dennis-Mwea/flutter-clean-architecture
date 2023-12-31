import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'locator.config.dart';

final locator = GetIt.instance..allowReassignment = true;

@injectableInit
void setupLocator() {
  _init(locator);
  locator.init();
}

void _init(GetIt locator) {}
