import 'package:dio/dio.dart';
import 'package:kemet/features/home/data/repos/home_repo_implementation.dart';

import 'package:get_it/get_it.dart';

import '../../features/auth/data/repositories/auth_repo_implementation.dart';
import '../../features/profile/data/repos/profile_repo_implements.dart';
import '../../features/settings/data/repositories/edit_profile_repo_implement.dart';
import 'api_service.dart';

final sl = GetIt.instance;

class ServiceLocator {
  void init() {
    sl.registerSingleton<ApiService>(ApiService(Dio()));
    sl.registerSingleton<AuthRepoImplementation>(AuthRepoImplementation(sl()));
    sl.registerSingleton<HomeRepoImplement>(HomeRepoImplement(sl()));
    sl.registerSingleton<ProfileRepoImplements>(ProfileRepoImplements(sl()));
    sl.registerSingleton<EditProfileRepoImplement>(
        EditProfileRepoImplement(sl()));
  }
}
