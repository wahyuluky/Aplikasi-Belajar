import 'package:get/get.dart';

import '../modules/choose_friend/bindings/choose_friend_binding.dart';
import '../modules/choose_friend/views/choose_friend_view.dart';
import '../modules/choose_music/bindings/choose_music_binding.dart';
import '../modules/choose_music/views/choose_music_view.dart';
import '../modules/dashboard/bindings/dashboard_binding.dart';
import '../modules/dashboard/views/dashboard_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/play_music/bindings/play_music_binding.dart';
import '../modules/play_music/views/play_music_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.DASHBOARD,
      page: () => const DashboardView(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.CHOOSE_FRIEND,
      page: () => const ChooseFriendView(),
      binding: ChooseFriendBinding(),
    ),
    GetPage(
      name: _Paths.CHOOSE_MUSIC,
      page: () => const ChooseMusicView(),
      binding: ChooseMusicBinding(),
    ),
    GetPage(
      name: _Paths.PLAY_MUSIC,
      page: () => const PlayMusicView(),
      binding: PlayMusicBinding(),
    ),
  ];
}
