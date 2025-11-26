import 'package:get/get.dart';

// Splash
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';

// Home
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';

// Login
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';

// Register
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';

// Profile
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';

// Dashboard
import '../modules/dashboard/bindings/dashboard_binding.dart';
import '../modules/dashboard/views/dashboard_view.dart';

// Choose Friend (kalau memang masih dipakai)
import '../modules/choose_friend/bindings/choose_friend_binding.dart';
import '../modules/choose_friend/views/choose_friend_view.dart';

// Music
import '../modules/choose_music/bindings/choose_music_binding.dart';
import '../modules/choose_music/views/choose_music_view.dart';
import '../modules/play_music/bindings/play_music_binding.dart';
import '../modules/play_music/views/play_music_view.dart';

// Focus Mode
import '../modules/focus_mode/views/focus_mode_view.dart';
import '../modules/focus_mode/bindings/focus_mode_binding.dart';

import '../modules/weekly_report/bindings/weekly_report_binding.dart';
import '../modules/weekly_report/views/weekly_report_view.dart';



part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    /// Splash
    GetPage(
      name: _Paths.SPLASH,
      page: () => SplashView(),
      binding: SplashBinding(),
    ),

    /// Home
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),

    /// Login
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),

    /// Register
    GetPage(
      name: _Paths.REGISTER,
      page: () => RegisterView(),
      binding: RegisterBinding(),
    ),

    /// Profile
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
    ),

    /// Dashboard
    GetPage(
      name: _Paths.DASHBOARD,
      page: () => DashboardView(),
      binding: DashboardBinding(),
    ),

    /// Choose Friend (hapus jika tidak dipakai)
    GetPage(
      name: _Paths.CHOOSE_FRIEND,
      page: () => ChooseFriendView(),
      binding: ChooseFriendBinding(),
    ),

    /// Choose Music (Koleksi musik)
    GetPage(
      name: _Paths.CHOOSE_MUSIC,
      page: () => ChooseMusicView(),
      binding: ChooseMusicBinding(),
    ),

    /// Play Music
    GetPage(
      name: _Paths.PLAY_MUSIC,
      page: () => PlayMusicView(),
      binding: PlayMusicBinding(),
    ),

    /// Focus Mode
    GetPage(
      name: _Paths.FOCUS_MODE,
      page: () => const FocusModeView(),
      binding: FocusModeBinding(),
    ),
    GetPage(
      name: _Paths.WEEKLY_REPORT,
      page: () => const WeeklyReportView(),
      binding: WeeklyReportBinding(),
    ),


  ];
}
