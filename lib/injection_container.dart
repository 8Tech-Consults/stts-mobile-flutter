import 'package:STTS/controllers/market_controller.dart';
import 'package:STTS/controllers/seed_controller.dart';
import 'package:STTS/controllers/user_controller.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

Future<void> initializeDependencies() async {
  locator.registerSingleton<UserController>(UserController());
  locator.registerSingleton<SeedController>(SeedController());
  locator.registerFactory<MarketController>(() => MarketController());
}
