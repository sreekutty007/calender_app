import 'package:get/get.dart';

import '../modules/add_event/bindings/add_event_binding.dart';
import '../modules/add_event/views/add_event_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = Routes.home;

  static final routes = [
    GetPage(
      name: _Paths.home,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.addEvent,
      page: () => const AddEventView(),
      binding: AddEventBinding(),
    ),
  ];
}
