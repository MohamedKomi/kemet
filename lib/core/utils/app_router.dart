import 'dart:io';

import 'package:kemet/features/auth/presntation/views/auth_view.dart';
import 'package:kemet/features/auth/presntation/views/forget_pass_view.dart';
import 'package:kemet/features/camera/presentation/views/explore_monuments_view.dart';
import 'package:kemet/features/camera/presentation/views/photo_view.dart';
import 'package:kemet/features/home/data/models/places_model/Places.dart';
import 'package:kemet/features/home/presentation/views/add_post_view.dart';
import 'package:kemet/features/home/presentation/views/home_view.dart';
import 'package:kemet/features/home/presentation/views/place_details_view.dart';
import 'package:kemet/features/home/presentation/views/places_view.dart';
import 'package:kemet/features/on_boarding/views/on_board_app.dart';
import 'package:kemet/features/on_boarding/views/on_boarding.dart';
import 'package:kemet/features/settings/presentations/views/edit_profile_view.dart';
import 'package:kemet/features/settings/presentations/views/widgets/helps.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/presntation/views/new_pass_view.dart';
import '../../features/auth/presntation/views/otp_view.dart';
import '../../features/camera/presentation/views/translate_view.dart';
import '../../features/home/data/models/places_model/PlacesAfterTranslate.dart';
import '../../features/settings/presentations/views/widgets/support.dart';
import '../../features/splash/views/lang_view.dart';
import '../../features/splash/views/splash_view.dart';

abstract class AppRouter {
  static const firstPage = '/';
  static const langPage = '/langePge';
  static const onBoardingPage = '/onBoardingPage';
  static const loginPage = '/loginPage';
  static const forgetPassPage = '/forgetPassPage';
  static const newPassPage = '/newPassPage';
  static const otpPage = '/otpPage';
  static const onBoardAppPage = '/onBoardAppPage';
  static const home = '/home';
  static const setting = '/setting';
  static const places = '/places';
  static const placeDetails = '/placeDetails';
  static const cameraView = '/cameraView';
  static const exploreMonuments = '/exploreMonuments';
  static const translateView = '/translateView';
  static const helps = '/helps';
  static const editProfile = '/editProfile';
  static const support = '/support';
  static const addPost = '/addPost';
  static const photoView = '/photoView';

  static final router = GoRouter(
    routes: [
      GoRoute(
        path: firstPage,
        builder: (context, state) => const SplashView(),
      ),
      GoRoute(
        path: langPage,
        builder: (context, state) => LangView(onSetting: state.extra as bool),
      ),
      GoRoute(
        path: onBoardingPage,
        builder: (context, state) => const OnBoarding(),
      ),
      GoRoute(
        path: loginPage,
        builder: (context, state) => const LoginViews(),
      ),
      GoRoute(
        path: forgetPassPage,
        builder: (context, state) =>
            ForgetPassView(isRegister: state.extra as bool),
      ),
      GoRoute(
        path: newPassPage,
        builder: (context, state) => NewPassView(
          parameters: state.extra as Map<String, dynamic>,
        ),
      ),
      GoRoute(
        path: otpPage,
        builder: (context, state) => OTPView(
          parameters: state.extra as Map<String, dynamic>,
        ),
      ),
      GoRoute(
        path: onBoardAppPage,
        builder: (context, state) => const OnBoardApp(),
      ),
      GoRoute(
        path: home,
        builder: (context, state) => const HomeView(),
      ),
      GoRoute(
        path: places,
        builder: (context, state) => PlacesView(
          places: state.extra as Places,
        ),
      ),
      GoRoute(
          path: placeDetails,
          builder: (context, state) => PlaceDetailsView(
                place: state.extra as PlacesAfterTranslate,
              )),
      GoRoute(
        path: exploreMonuments,
        builder: (context, state) => ExploreMonumentsView(
          data: state.extra as Map<String, dynamic>,
        ),
      ),
      GoRoute(
        path: translateView,
        builder: (context, state) => TranslateView(
          imageFile: state.extra as File?,
        ),
      ),
      GoRoute(
        path: helps,
        builder: (context, state) => const Helps(),
      ),
      GoRoute(
        path: editProfile,
        builder: (context, state) => const EditProfileView(),
      ),
      GoRoute(
        path: support,
        builder: (context, state) => const Support(),
      ),
      GoRoute(
        path: addPost,
        builder: (context, state) => const AddPostView(),
      ),
      GoRoute(
        path: photoView,
        builder: (context, state) =>
            PhotoView(data: state.extra as Map<String, dynamic>),
      ),
    ],
  );
}
