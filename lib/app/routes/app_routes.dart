import 'package:get/get.dart';
import 'package:banni_tinni/features/splash/presentation/pages/splash_screen.dart';
import 'package:banni_tinni/features/home/presentation/pages/home_screen.dart';
import 'package:banni_tinni/app/modules/link/link_binding.dart';
import 'package:banni_tinni/app/modules/link/link_view.dart';
import 'package:banni_tinni/app/modules/place/place_binding.dart';
import 'package:banni_tinni/app/modules/place/place_view.dart';
import 'package:banni_tinni/app/modules/place/widgets/history_view.dart';

class AppRoutes {
  static const String splash = '/';
  static const String home = '/home';
  static const String link = '/link';
  static const String place = '/place';
  static const String placeHistory = '/place/history';

  static final pages = [
    GetPage(name: splash, page: () => const SplashScreen()),
    GetPage(name: home, page: () => const HomeScreen()),
    GetPage(name: link, page: () => const LinkView(), binding: LinkBinding()),
    GetPage(
      name: place,
      page: () => const PlaceView(),
      binding: PlaceBinding(),
    ),
    GetPage(
      name: placeHistory,
      page: () => const PlaceHistoryView(),
      binding: PlaceBinding(),
    ),
  ];
}
