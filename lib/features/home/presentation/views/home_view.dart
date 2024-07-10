import 'package:kemet/constants.dart';
import 'package:kemet/core/utils/app_router.dart';
import 'package:kemet/core/widgets/drawer.dart';
import 'package:kemet/features/home/data/repos/home_repo_implementation.dart';
import 'package:kemet/features/home/presentation/manager/likes_cubit/likes_cubit.dart';
import 'package:kemet/features/home/presentation/manager/places_cubit/places_cubit.dart';
import 'package:kemet/features/home/presentation/manager/posts_cubit/posts_cubit.dart';
import 'package:kemet/features/settings/presentations/views/settings_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/utils/service_locator.dart';
import '../../../../core/widgets/navigation_screen.dart';
import '../../../camera/presentation/views/widgets/camera_view_body.dart';
import '../../../profile/presentations/views/profile_body.dart';
import '../manager/BNB_cubit/bnbcubit_cubit.dart';
import 'widgets/app_bar_home.dart';
import 'widgets/home_view_body.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime timeBackPress = DateTime.now();
    List screens = const [
      HomeViewBody(),
      CameraViewBody(),
      ProfileBody(),
      SettingsBody(),
    ];
    return WillPopScope(
      onWillPop: () async {
        final difference = DateTime.now().difference(timeBackPress);
        final isExitWarning = difference >= const Duration(seconds: 2);
        timeBackPress = DateTime.now();
        if (isExitWarning) {
          const message = 'press back again to exit';
          Fluttertoast.showToast(msg: message, gravity: ToastGravity.BOTTOM);
          return false;
        } else {
          Fluttertoast.cancel();
          return true;
        }
      },
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                PlacesCubit(sl<HomeRepoImplement>())..fetchPlaces(),
          ),
          BlocProvider(
            create: (context) =>
                PostsCubit(sl<HomeRepoImplement>())..fetchPosts(),
          ),
          BlocProvider(
            create: (context) => BNBCubit(),
          ),
          BlocProvider(
            create: (context) => LikesCubit(
              sl<HomeRepoImplement>(),
            ),
          ),
        ],
        child: BlocBuilder<BNBCubit, BnbcubitState>(
          builder: (context, state) {
            int currentIndex = BlocProvider.of<BNBCubit>(context).currentIndex;
            return Scaffold(
              appBar: PreferredSize(
                  preferredSize: Size(double.infinity,
                      MediaQuery.of(context).size.height * 0.1),
                  child: currentIndex == 0
                      ? const AppBarHome()
                      : const SizedBox()),
              drawer: const CustomDrawer(),
              body: screens[currentIndex],
              bottomNavigationBar: const BuildBNavBar(),
              floatingActionButton: currentIndex == 0
                  ? FloatingActionButton(
                      shape: const CircleBorder(
                      // Adjust the radius as needed
                      ),
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.add,
                        color: mainColor,
                      ),
                      onPressed: () {
                        GoRouter.of(context).push(AppRouter.addPost);
                      },
                    )
                  : null,
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
            );
          },
        ),
      ),
    );
  }
}
