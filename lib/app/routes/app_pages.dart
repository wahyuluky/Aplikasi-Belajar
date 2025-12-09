import 'package:flutter_application_1/app/modules/to-do-list/bindings/to_do_list_binding.dart';
import 'package:flutter_application_1/app/modules/to-do-list/views/to_do_list_view.dart';
import 'package:get/get.dart';

import '../modules/addschedule/bindings/addschedule_binding.dart';
import '../modules/addschedule/views/addschedule_view.dart';
import '../modules/addtugas/bindings/addtugas_binding.dart';
import '../modules/addtugas/views/addtugas_view.dart';
import '../modules/anggota/bindings/anggota_binding.dart';
import '../modules/anggota/views/anggota_view.dart';
import '../modules/chat/bindings/chat_binding.dart';
import '../modules/chat/views/chat_view.dart';
import '../modules/choose_friend/bindings/choose_friend_binding.dart';
import '../modules/choose_friend/views/choose_friend_view.dart';
import '../modules/choose_music/bindings/choose_music_binding.dart';
import '../modules/choose_music/views/choose_music_view.dart';
import '../modules/dashboard/bindings/dashboard_binding.dart';
import '../modules/dashboard/views/dashboard_view.dart';
import '../modules/editschedule/bindings/editschedule_binding.dart';
import '../modules/editschedule/views/editschedule_view.dart';
import '../modules/edittugas/bindings/edittugas_binding.dart';
import '../modules/edittugas/views/edittugas_view.dart';
import '../modules/focus_rest/bindings/focus_rest_binding.dart';
import '../modules/focus_rest/views/focus_rest_view.dart';
import '../modules/grupbelajar/bindings/grupbelajar_binding.dart';
import '../modules/grupbelajar/views/grupbelajar_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/materi/bindings/materi_binding.dart';
import '../modules/materi/views/materi_view.dart';
import '../modules/music_collection/bindings/music_collection_binding.dart';
import '../modules/music_collection/views/music_collection_view.dart';
import '../modules/play_music/bindings/play_music_binding.dart';
import '../modules/play_music/views/play_music_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/profile_teman/bindings/profile_teman_binding.dart';
import '../modules/profile_teman/views/profile_teman_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';
import '../modules/schedule/bindings/schedule_binding.dart';
import '../modules/schedule/views/schedule_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/timerfokus/bindings/timerfokus_binding.dart';
import '../modules/timerfokus/views/timerfokus_view.dart';
import '../modules/timerfokusresult/bindings/timerfokusresult_binding.dart';
import '../modules/timerfokusresult/views/timerfokusresult_view.dart';
import '../modules/tugas/bindings/tugas_binding.dart';
import '../modules/tugas/views/tugas_view.dart';
import '../modules/weekly_report/bindings/weekly_report_binding.dart';
import '../modules/weekly_report/views/weekly_report_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    /// Splash
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.DASHBOARD,
      page: () => DashboardView(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: _Paths.SCHEDULE,
      page: () => ScheduleView(),
      binding: ScheduleBinding(),
    ),
    GetPage(
      name: _Paths.ADDSCHEDULE,
      page: () => AddscheduleView(),
      binding: AddscheduleBinding(),
    ),
    GetPage(
      name: _Paths.EDITSCHEDULE,
      page: () => EditscheduleView(),
      binding: EditscheduleBinding(),
    ),
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
      name: _Paths.TUGAS,
      page: () => TugasView(),
      binding: TugasBinding(),
    ),
    GetPage(
      name: _Paths.ADDTUGAS,
      page: () => AddtugasView(),
      binding: AddtugasBinding(),
    ),
    GetPage(
      name: _Paths.EDITTUGAS,
      page: () => EdittugasView(),
      binding: EdittugasBinding(),
    ),
    GetPage(
      name: _Paths.TIMERFOKUS,
      page: () => TimerFokusView(),
      binding: TimerfokusBinding(),
    ),
    GetPage(
      name: _Paths.TIMERFOKUSRESULT,
      page: () => TimerfokusresultView(),
      binding: TimerfokusresultBinding(),
    ),
    GetPage(
      name: _Paths.GRUPBELAJAR,
      page: () => GrupbelajarView(),
      binding: GrupbelajarBinding(),
    ),
    GetPage(
      name: _Paths.CHAT,
      page: () => ChatView(),
      binding: ChatBinding(),
    ),
    GetPage(
      name: _Paths.MATERI,
      page: () => MateriView(),
      binding: MateriBinding(),
    ),
    GetPage(
      name: _Paths.ANGGOTA,
      page: () => AnggotaView(),
      binding: AnggotaBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE_TEMAN,
      page: () => ProfileTemanView(),
      binding: ProfileTemanBinding(),
    ),
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
    GetPage(
      name: _Paths.WEEKLY_REPORT,
      page: () => WeeklyReportView(),
      binding: WeeklyReportBinding(),
    ),
    GetPage(
      name: _Paths.FOCUS_REST,
      page: () => FocusRestView(),
      binding: FocusRestBinding(),
    ),
    GetPage(
      name: _Paths.MUSIC_COLLECTION,
      page: () => MusicCollectionView(),
      binding: MusicCollectionBinding(),
    ),
  ];
}
